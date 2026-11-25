#!/usr/bin/env bash
# Fast-forwards every git repo found under the given directories.
# Written for bash 3.2, which is what macOS ships.

set -o pipefail

USAGE="Usage: sync-repos.sh [options] DIR [DIR...]"
TIME_FORMAT="%Y-%m-%d %H:%M:%S"

BLUE=$'\e[1;34m'
GREEN=$'\e[1;32m'
YELLOW=$'\e[1;33m'
RED=$'\e[1;31m'
BOLD=$'\e[1m'
RESET=$'\e[0m'
info() { printf '%s\n' "${BLUE}ℹ${RESET} $*"; }
ok() { printf '%s\n' "${GREEN}✓${RESET} $*"; }
warn() { printf '%s\n' "${YELLOW}⚠${RESET} $*"; }
err() { printf '%s\n' "${RED}✗${RESET} $*"; }

usage() {
  cat <<EOF
${USAGE}

Fast-forward every git repo found under the given directories.

positional arguments:
  DIR            Directory to search recursively for git repos

options:
  -h, --help     Show this help message and exit
  -n, --dry-run  Preview actions without making changes
  -y, --yes      Sync without asking for confirmation
EOF
}

current_branch() { git -C "$1" rev-parse --abbrev-ref HEAD 2>/dev/null; }
has_commits() { git -C "$1" rev-parse --verify HEAD >/dev/null 2>&1; }

has_any_remote() {
  local out
  out=$(git -C "$1" remote 2>/dev/null) && [[ -n "${out}" ]]
}

in_progress_operation() {
  local marker
  for marker in MERGE_HEAD rebase-apply rebase-merge CHERRY_PICK_HEAD REVERT_HEAD; do
    [[ -e "$1/.git/${marker}" ]] && return 0
  done
  return 1
}

dirty() {
  local out
  out=$(git -C "$1" status --porcelain 2>/dev/null) || return 0
  [[ -n "${out}" ]]
}

count() {
  local n
  n=$(git -C "$1" rev-list --count "$2" 2>/dev/null) || n=0
  echo "${n}"
}

# Stops descending at the first repo on each path, so nested repos are not synced.
find_repos() {
  find "$1" -type d -exec test -d '{}/.git' ';' -print0 -prune 2>/dev/null | sort -z
}

dry_run=false
assume_yes=false
dirs=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    -n | --dry-run) dry_run=true ;;
    -y | --yes) assume_yes=true ;;
    -h | --help)
      usage
      exit 0
      ;;
    --)
      shift
      dirs+=("$@")
      break
      ;;
    -*)
      printf '%s\n' "invalid option: $1" "${USAGE}" >&2
      exit 1
      ;;
    *) dirs+=("$1") ;;
  esac
  shift
done

if [[ ${#dirs[@]} -eq 0 ]]; then
  printf '%s\n' "${USAGE}" >&2
  exit 1
fi

roots=()
missing=()
for dir in "${dirs[@]}"; do
  dir="${dir/#\~/${HOME}}"
  if [[ -d "${dir}" ]]; then
    roots+=("$(cd "${dir}" && pwd -P)")
  else
    missing+=("${dir}")
  fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
  list=$(printf '%s, ' "${missing[@]}")
  err "not a directory: ${list%, }"
  exit 1
fi

repo_paths=()
repo_names=()
for root in "${roots[@]}"; do
  while IFS= read -r -d '' path; do
    seen=false
    for existing in "${repo_paths[@]}"; do
      if [[ "${existing}" == "${path}" ]]; then
        seen=true
        break
      fi
    done
    ${seen} && continue

    if [[ "${path}" == "${root}" ]]; then
      name=$(basename "${path}")
    else
      name=${path#"${root}"/}
    fi
    repo_paths+=("${path}")
    repo_names+=("${name}")
  done < <(find_repos "${root}" || true)
done

roots_list=$(printf '%s, ' "${roots[@]}")
roots_list=${roots_list%, }

if [[ ${#repo_paths[@]} -eq 0 ]]; then
  warn "No git repos found under: ${roots_list}"
  exit 0
fi

info "Found ${#repo_paths[@]} repo(s):"
for name in "${repo_names[@]}"; do
  printf '  %s\n' "${name}"
done
echo

if ! ${dry_run} && ! ${assume_yes}; then
  printf 'Sync %d repo(s)? [y/N] ' "${#repo_paths[@]}"
  if ! read -r answer && [[ -z "${answer}" ]]; then
    echo
  fi
  case "${answer}" in
    [Yy] | [Yy][Ee][Ss]) ;;
    *)
      err "Aborted."
      exit 1
      ;;
  esac
  echo
fi

mode=""
${dry_run} && mode="(DRY-RUN MODE)"
started=$(date "+${TIME_FORMAT}")
info "Starting sync at ${started} ${mode} under: ${roots_list}"

updated=0
up_to_date=0
skipped=0
errors=0

for i in "${!repo_paths[@]}"; do
  path=${repo_paths[${i}]}
  repo=${repo_names[${i}]}
  info "Syncing repo: ${BOLD}${repo}${RESET}"

  if ! has_any_remote "${path}"; then
    warn "No git remotes configured; skipping."
    skipped=$((skipped + 1))
    continue
  fi

  if ! current=$(current_branch "${path}"); then
    err "Could not determine current branch."
    errors=$((errors + 1))
    continue
  fi

  if [[ "${current}" == "HEAD" ]]; then
    warn "Detached HEAD; skipping pull. (Attach to a branch to sync.)"
    skipped=$((skipped + 1))
    continue
  fi

  if ! has_commits "${path}"; then
    warn "Repo has no commits yet; skipping."
    skipped=$((skipped + 1))
    continue
  fi

  if in_progress_operation "${path}"; then
    warn "Operation in progress (merge/rebase/cherry-pick/revert); skipping."
    skipped=$((skipped + 1))
    continue
  fi

  is_dirty=false
  if dirty "${path}"; then
    is_dirty=true
    warn "Working tree has uncommitted changes."
  fi

  if ! fetch_err=$(git -C "${path}" fetch --prune --quiet 2>&1 >/dev/null); then
    err "git fetch failed: ${fetch_err}"
    errors=$((errors + 1))
    echo
    continue
  fi

  if ! tracking_branch=$(git -C "${path}" rev-parse --abbrev-ref "${current}@{upstream}" 2>/dev/null); then
    warn "Current branch '${current}' has no upstream tracking branch."
    skipped=$((skipped + 1))
    continue
  fi

  behind=$(count "${path}" "HEAD..${tracking_branch}")
  ahead=$(count "${path}" "${tracking_branch}..HEAD")

  if [[ "${ahead}" -gt 0 && "${behind}" -gt 0 ]]; then
    warn "Branch '${current}' diverged: ${ahead} ahead, ${behind} behind ${tracking_branch}."
    skipped=$((skipped + 1))
  elif [[ "${ahead}" -gt 0 ]]; then
    info "Branch '${current}' is ${ahead} commit(s) ahead of ${tracking_branch}."
    up_to_date=$((up_to_date + 1))
  elif [[ "${behind}" -gt 0 ]]; then
    if ${is_dirty}; then
      warn "Branch '${current}' is ${behind} commit(s) behind ${tracking_branch}, but working tree is dirty."
      skipped=$((skipped + 1))
    else
      info "Fast-forwarding '${current}' by ${behind} commit(s)…"
      before=$(git -C "${path}" rev-parse HEAD)
      if ${dry_run}; then
        printf '  [DRY-RUN] Would pull %s to update %s.\n' "${tracking_branch}" "${repo}"
        ok "Simulated update complete."
        updated=$((updated + 1))
      elif git -C "${path}" pull --ff-only --no-rebase --quiet >/dev/null 2>&1; then
        after=$(git -C "${path}" rev-parse HEAD)
        ok "Updated: ${before} → ${after}"
        git --no-pager -C "${path}" log --oneline --decorate "${before}..${after}"
        updated=$((updated + 1))
      else
        err "Pull failed (non-ff?). Investigate manually."
        errors=$((errors + 1))
      fi
    fi
  else
    ok "Up to date on '${current}'."
    up_to_date=$((up_to_date + 1))
  fi

  echo
done

finished=$(date "+${TIME_FORMAT}")
ok "Complete at ${finished} ${mode}"
info "Summary: ${updated} updated, ${up_to_date} up-to-date, ${skipped} skipped, ${errors} errors"
