-- tmux mappings; shifted keys are written unshifted (| is shift+\)
-- commented-out binds are rex defaults left unmapped, as of:
-- beta 0.1.0 (1758) · preview
-- server 0.0.1793645657-gd018d2

local prefix = "ctrl+a>"

-- window --
-- rex.bind("cmd+n", "client.window.new") -- New Window
-- rex.bind("shift+cmd+w", "client.window.close") -- Close Window
-- rex.bind("ctrl+cmd+f", "client.window.fullscreen.toggle") -- Toggle Full Screen
-- rex.bind("cmd+w", "client.close") -- Close

-- app --
rex.bind(prefix .. "shift+;", "client.palette.toggle") -- Command Palette <shift+cmd+p>
-- rex.bind("cmd+,", "client.settings") -- Settings
-- rex.bind("shift+cmd+,", "client.diagnostics") -- Rex Diagnostics
-- rex.bind("shift+cmd+u", "client.update.accept") -- Install Update
-- rex.bind("alt+shift+cmd+u", "client.update.accept_when_idle") -- Relaunch when Idle
-- rex.bind("shift+cmd+.", "client.notice.dismiss") -- Dismiss Notice

-- session --
rex.bind(prefix .. "s", "session.switch") -- Change Session <cmd+k>
rex.bind(prefix .. "shift+4", "session.rename") -- Rename Session
rex.bind(prefix .. "shift+9", "session.previous") -- Previous Session
rex.bind(prefix .. "shift+0", "session.next") -- Next Session
rex.bind(prefix .. "shift+6", "session.new") -- New Session <shift+cmd+n>
-- rex.bind("cmd+r", "session.refresh") -- Refresh Sessions

-- tab --
rex.bind(prefix .. "c", "client.tab.new") -- New Tab <cmd+t>
rex.bind(prefix .. "n", "client.tab.next") -- Show Next Tab <ctrl+tab, shift+cmd+]>
rex.bind(prefix .. "p", "client.tab.previous") -- Show Previous Tab <ctrl+shift+tab, shift+cmd+[>
rex.bind(prefix .. "ctrl+l", "client.tab.next") -- Show Next Tab <ctrl+tab, shift+cmd+]>
rex.bind(prefix .. "ctrl+h", "client.tab.previous") -- Show Previous Tab <ctrl+shift+tab, shift+cmd+[>
rex.bind(prefix .. ",", "client.tab.rename") -- Rename Tab
rex.bind(prefix .. "shift+7", "client.tab.close") -- Close Tab <alt+cmd+w>
for i = 1, 9 do
  rex.bind(prefix .. i, "client.tab.goto", { index = i }) -- Go to Tab <cmd+1..9>
end
-- rex.bind("ctrl+shift+pageup", "client.tab.move.backward") -- Move Tab Backward
-- rex.bind("ctrl+shift+pagedown", "client.tab.move.forward") -- Move Tab Forward

-- pane: split --
rex.bind(prefix .. "shift+\\", "pane.split", { direction = "right" }) -- Split Pane Right <cmd+d, shift+cmd+right>
rex.bind(prefix .. "-", "pane.split", { direction = "down" }) -- Split Pane Down <shift+cmd+d, shift+cmd+down>
-- rex.bind("shift+cmd+left", "pane.split.left") -- Split Pane Left
-- rex.bind("shift+cmd+up", "pane.split.up") -- Split Pane Up
-- rex.bind("cmd+enter", "pane.split.auto") -- Split Pane Best Fit

-- pane: focus --
rex.bind(prefix .. "h", "pane.focus", { direction = "left" }) -- Focus Pane Left <alt+cmd+left>
rex.bind(prefix .. "j", "pane.focus", { direction = "down" }) -- Focus Pane Down <alt+cmd+down>
rex.bind(prefix .. "k", "pane.focus", { direction = "up" }) -- Focus Pane Up <alt+cmd+up>
rex.bind(prefix .. "l", "pane.focus", { direction = "right" }) -- Focus Pane Right <alt+cmd+right>
rex.bind(prefix .. "o", "pane.focus_next") -- Focus Next Pane <cmd+]>
rex.bind(prefix .. "y", "pane.focus_previous") -- Focus Previous Pane <cmd+[>

-- pane: resize --
rex.bind(prefix .. "shift+h", "pane.resize", { direction = "left", amount = 5 }) -- Resize Pane
rex.bind(prefix .. "shift+j", "pane.resize", { direction = "down", amount = 5 }) -- Resize Pane
rex.bind(prefix .. "shift+k", "pane.resize", { direction = "up", amount = 5 }) -- Resize Pane
rex.bind(prefix .. "shift+l", "pane.resize", { direction = "right", amount = 5 }) -- Resize Pane
rex.bind(prefix .. "m", "pane.zoom") -- Zoom Pane <shift+cmd+enter>
rex.bind(prefix .. "z", "pane.zoom") -- Zoom Pane <shift+cmd+enter>

-- pane: movement --
rex.bind(prefix .. "shift+1", "pane.move_to_new_tab") -- Move Pane to New Tab
rex.bind(prefix .. "t", "pane.move_to_tab") -- Move Pane to Tab
-- rex.bind("alt+shift+cmd+left", "pane.move.left") -- Move Pane Left
-- rex.bind("alt+shift+cmd+right", "pane.move.right") -- Move Pane Right
-- rex.bind("alt+shift+cmd+up", "pane.move.up") -- Move Pane Up
-- rex.bind("alt+shift+cmd+down", "pane.move.down") -- Move Pane Down
-- rex.bind("alt+cmd+enter", "pane.float") -- Float Pane
-- rex.bind("alt+cmd+m", "pane.minimize_floating") -- Minimize Floating Window
-- rex.bind("alt+shift+cmd+enter", "pane.minimize_all_floating") -- Minimize Floating Windows

-- pane --
rex.bind(prefix .. "x", "pane.close") -- Close Pane <cmd+w>
rex.bind(prefix .. "ctrl+a", "pane.send_key", { key = "ctrl+a" }) -- Send Key
-- rex.bind("cmd+backspace", "pane.send_key") -- Send Key, sent key not documented
-- rex.bind("cmd+left", "pane.send_key") -- Send Key, sent key not documented
-- rex.bind("cmd+right", "pane.send_key") -- Send Key, sent key not documented
-- rex.bind("alt+left", "pane.send_key") -- Send Key, sent key not documented
-- rex.bind("alt+right", "pane.send_key") -- Send Key, sent key not documented
-- rex.bind("shift+cmd+g", "pane.go_to_directory") -- Go to Directory
-- rex.bind("ctrl+cmd+i", "pane.insert_path") -- Insert Path
-- rex.bind("cmd+up", "client.prompt.previous") -- Jump to Previous Prompt
-- rex.bind("cmd+down", "client.prompt.next") -- Jump to Next Prompt

-- find --
-- rex.bind("cmd+f", "client.find.open") -- Find
-- rex.bind("cmd+g", "client.find.next") -- Find Next
-- rex.bind("shift+cmd+g", "client.find.previous") -- Find Previous

-- view --
rex.bind(prefix .. "r", "client.config.reload") -- Reload Config
-- rex.bind("shift+cmd+=", "client.font.increase") -- Increase Font Size
-- rex.bind("cmd+=", "client.font.increase") -- Increase Font Size
-- rex.bind("cmd+-", "client.font.decrease") -- Decrease Font Size
-- rex.bind("cmd+0", "client.font.reset") -- Reset Font Size
-- rex.bind("cmd+/", "client.sidebar.toggle") -- Toggle Sidebar
-- rex.bind("cmd+.", "client.sidebar.activity.toggle") -- Toggle Activity
-- rex.bind("shift+cmd+s", "client.tab_style.toggle") -- Toggle Tab Style
