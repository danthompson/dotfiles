#!/usr/bin/env bash

osascript -e 'tell application "System Preferences" to quit'

# # # Show the ~/Library folder.
# # chflags nohidden ~/Library
# #
# # # Disable opening and closing window animations
# # defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
# #
# # # Expand save panel by default
# # defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
# # defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
# # #
# # # # Expand print panel by default
# # # defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# # # defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
# # #
# # # # Save to disk (not to iCloud) by default
# # # defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
# # #
# # # # Automatically quit printer app once the print jobs complete
# # # defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
# # #
# # # # Disable Resume system-wide
# # # defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false
# # #
# # # # Keyboard & Input                                                            #
# # #
# # # Disable smart dashes, smart quotes, period substitution
# # defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
# # defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
# # defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
# # #
# # # Enable full keyboard access for all controls
# # defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
# # #
# # # Disable press-and-hold for keys in favor of key repeat
# # defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
# # #
# # # Set a blazingly fast keyboard repeat rate
# # defaults write NSGlobalDomain KeyRepeat -int 1
# # defaults write NSGlobalDomain InitialKeyRepeat -int 15
# # #
# # # # Automatically illuminate built-in MacBook keyboard in low light
# # # defaults write com.apple.BezelServices kDim -bool true
# # #
# # # # Turn off keyboard illumination when computer is not used for 5 minutes
# # # defaults write com.apple.BezelServices kDimTime -int 300
# # #
# # # Disable auto-correct
# # defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
# # #
# # # # Stop iTunes from responding to the keyboard media keys
# # # launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null
# # #
# # # # Trackpad, mouse, Bluetooth accessories                                      #
# # #
# # # # Trackpad: enable tap to click for this user and for the login screen
# # # defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
# # # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
# # # defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# # # defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
# # #
# # # Increase sound quality for Bluetooth headphones/headsets
# # defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40
# # #
# # # # Screen                                                                      #
# # #
# # # # Require password immediately after sleep or screen saver begins
# # # defaults write com.apple.screensaver askForPassword -int 1
# # # defaults write com.apple.screensaver askForPasswordDelay -int 0
# # #
# # # # Save screenshots to the ~/Desktop folder
# # # defaults write com.apple.screencapture location -string "${HOME}/Desktop"
# # #
# # # Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
# # defaults write com.apple.screencapture type -string "png"
# # #
# # # Disable shadow in screenshots
# # defaults write com.apple.screencapture disable-shadow -bool true
# # #
# # # Enable subpixel font rendering on non-Apple LCDs
# # defaults write NSGlobalDomain AppleFontSmoothing -int 2
# # #
# # # # Finder                                                                      #
# # #
# # # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
# # defaults write com.apple.finder QuitMenuItem -bool true
# # #
# #
# # Finder: disable window animations and Get Info animations
# defaults write com.apple.finder DisableAllAnimations -bool true
# #
# # Finder: show hidden files by default
# defaults write com.apple.finder AppleShowAllFiles -bool true
# #
# # Finder: show all filename extensions
# defaults write NSGlobalDomain AppleShowAllExtensions -bool true
# #
# # Finder: show status bar
# defaults write com.apple.finder ShowStatusBar -bool true
# #
# # Finder: show path bar
# defaults write com.apple.finder ShowPathbar -bool true
# # #
# # # # Finder: allow text selection in Quick Look
# # # defaults write com.apple.finder QLEnableTextSelection -bool true
# # #
# # # # Display full POSIX path as Finder window title
# # # defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
# # # #
# # Keep folders on top when sorting by name
# defaults write com.apple.finder _FXSortFoldersFirst -bool true
# # #
# # When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
# # #
# # Disable the warning when changing a file extension
# defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
# # #
# # Avoid creating .DS_Store files on network or USB volumes
# defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
# defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
# # #
# # Use AirDrop over every interface.
# defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true
# # #
# # Always open everything in Finder's list view.
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
# # #
# # Expand the following File Info panes:
# # “General”, “Open with”, and “Sharing & Permissions”
# defaults write com.apple.finder FXInfoPanesExpanded -dict General -bool true OpenWith -bool true Privileges -bool true
#
#
# killall "Finder" &> /dev/null
#
#
# # #
# # # # Dock                                                                        #
# # #
# # # # Show indicator lights for open applications in the Dock
# # # defaults write com.apple.dock show-process-indicators -bool true
# # #
# # # # Don’t animate opening applications from the Dock
# # # defaults write com.apple.dock launchanim -bool false
# # #
# # # # Automatically hide and show the Dock
# # # defaults write com.apple.dock autohide -bool true
# # #
# # # # Make Dock icons of hidden applications translucent
# # # defaults write com.apple.dock showhidden -bool true
# # #
# # # No bouncing icons
# # defaults write com.apple.dock no-bouncing -bool true
# # #
# # # # Disable hot corners
# # # defaults write com.apple.dock wvous-tl-corner -int 0
# # # defaults write com.apple.dock wvous-tr-corner -int 0
# # # defaults write com.apple.dock wvous-bl-corner -int 0
# # # defaults write com.apple.dock wvous-br-corner -int 0
# # #
# # # # Don't show recently used applications in the Dock
# # # defaults write com.Apple.Dock show-recents -bool false
# # #
# # # # Calendar                                                                    #
# # #
# # # # Week starts on monday
# # # defaults write com.apple.iCal "first day of week" -int 1
# # #
# # # # Terminal                                                                    #
# # #
# # # Only use UTF-8 in Terminal.app
# # defaults write com.apple.terminal StringEncodings -array 4
# # #
# # # # Appearance
# # defaults write com.apple.terminal "Default Window Settings" -string "Pro"
# # defaults write com.apple.terminal "Startup Window Settings" -string "Pro"
# # defaults write com.apple.Terminal ShowLineMarks -int 0
# # #
# # # # Activity Monitor                                                            #
# # #
# # # # Show the main window when launching Activity Monitor
# # # defaults write com.apple.ActivityMonitor OpenMainWindow -bool true
# # #
# # # # Visualize CPU usage in the Activity Monitor Dock icon
# # # defaults write com.apple.ActivityMonitor IconType -int 5
# # #
# # # # Show all processes in Activity Monitor
# # # defaults write com.apple.ActivityMonitor ShowCategory -int 0
# # #
# # # # Sort Activity Monitor results by CPU usage
# # # defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
# # # defaults write com.apple.ActivityMonitor SortDirection -int 0
# # #
# # # # Software Updates                                                            #
# # #
# # # Enable the automatic update check
# # defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true
# # #
# # # Check for software updates daily, not just once per week
# # defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
# # #
# # # Download newly available updates in background
# # defaults write com.apple.SoftwareUpdate AutomaticDownload -bool true
# # #
# # # Install System data files & security updates
# # defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -bool true
# # #
# # # Turn on app auto-update
# # defaults write com.apple.commerce AutoUpdate -bool true
# # #
# # # # Allow the App Store to reboot machine on macOS updates
# # # defaults write com.apple.commerce AutoUpdateRestartRequired -bool true
# # #
# # # # Safari
# # #
# # # Privacy: don’t send search queries to Apple
# # defaults write com.apple.Safari UniversalSearchEnabled -bool false
# # defaults write com.apple.Safari SuppressSearchSuggestions -bool true
# # #
# # # Press Tab to highlight each item on a web page
# # defaults write com.apple.Safari WebKitTabToLinksPreferenceKey -bool true
# # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2TabsToLinks -bool true
# # #
# # # Show the full URL in the address bar (note: this still hides the scheme)
# # defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# #
# # # Always show Safari's "URL display" tab in the lower left on mouseover.
# # defaults write com.apple.Safari ShowOverlayStatusBar -bool true
# # #
# # # Set Safari’s home page to `about:blank` for faster loading
# # defaults write com.apple.Safari HomePage -string "about:blank"
# # #
# # # Prevent Safari from opening ‘safe’ files automatically after downloading
# # defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# # #
# # # Allow hitting the Backspace key to go to the previous page in history
# # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true
# # #
# # # Hide Safari’s bookmarks bar by default
# # defaults write com.apple.Safari ShowFavoritesBar -bool false
# # #
# # # Hide Safari’s sidebar in Top Sites
# # defaults write com.apple.Safari ShowSidebarInTopSites -bool false
# # #
# # # Disable Safari’s thumbnail cache for History and Top Sites
# # defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
# #
# # # Enable Safari’s debug menu
# # defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
# # #
# # # Make Safari’s search banners default to Contains instead of Starts With
# # defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
# # #
# # # Remove useless icons from Safari’s bookmarks bar
# # defaults write com.apple.Safari ProxiesInBookmarksBar "()"
# # #
# # # Enable the Develop menu and the Web Inspector in Safari
# # defaults write com.apple.Safari IncludeDevelopMenu -bool true
# # defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
# # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# # #
# # # Add a context menu item for showing the Web Inspector in web views
# # defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
# # #
# # # Enable continuous spellchecking
# # defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# # # Disable auto-correct
# # defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false
# # #
# # # Disable AutoFill
# # defaults write com.apple.Safari AutoFillFromAddressBook -bool false
# # defaults write com.apple.Safari AutoFillPasswords -bool false
# # defaults write com.apple.Safari AutoFillCreditCardData -bool false
# # defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false
# # #
# # # Warn about fraudulent websites
# # defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true
# # #
# # # # # Disable plug-ins
# # # # defaults write com.apple.Safari WebKitPluginsEnabled -bool false
# # # # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2PluginsEnabled -bool false
# # #
# # # # Disable Java
# # # defaults write com.apple.Safari WebKitJavaEnabled -bool false
# # # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabled -bool false
# # # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaEnabledForLocalFiles -bool false
# # #
# # # # Block pop-up windows
# # # defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
# # # defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false
# # #
# # # Enable “Do Not Track”
# # defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true
# # #
# # # Update extensions automatically
# # defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true
# # #
# # # # Kill affected applications                                                  #
# # #
for app in "Finder"; do
  killall "${app}" &> /dev/null
done
