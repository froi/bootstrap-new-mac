#!/bin/bash
source scripts/utils.sh

cecho "##############################################################" $green
cecho "                                                              " $green
cecho "             Set OSX Preferences - Borrowed from              " $green
cecho " https://github.com/mathiasbynens/dotfiles/blob/master/.macos " $green
cecho "                                                              " $green
cecho "##############################################################" $green

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Start hammerspoon at login
defaults write org.hammerspoon.Hammerspoon.Spoon StartAtLogin -bool true

# Don’t show the preferences window on next start
defaults write org.hammerspoon.Hammerspoon.Spoon ShowPrefsOnNextStart -bool false

cecho "##################################" $blue
cecho "                                  " $blue
cecho "    Finder, Dock, & Menu Items    " $blue
cecho "                                  " $blue
cecho "##################################" $blue

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Only Show Open Applications In The Dock  
defaults write com.apple.dock static-only -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Menu bar: hide the Time Machine, User icons, but show the volume Icon.
for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
	defaults write "${domain}" dontAutoLoad -array \
		"/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
		"/System/Library/CoreServices/Menu Extras/User.menu"
done
defaults write com.apple.systemuiserver menuExtras -array \
	"/System/Library/CoreServices/Menu Extras/Volume.menu" \
	"/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
	"/System/Library/CoreServices/Menu Extras/AirPort.menu" \
	"/System/Library/CoreServices/Menu Extras/Battery.menu" \
	"/System/Library/CoreServices/Menu Extras/Clock.menu"

cecho "################################" $blue
cecho "                                " $blue
cecho "    Text Editing / Keyboards    " $blue
cecho "                                " $blue
cecho "################################" $blue

# Disable smart quotes and smart dashes
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

cecho "############################" $blue
cecho "                            " $blue
cecho "    Screenshots / Screen    " $blue
cecho "                            " $blue
cecho "############################" $blue

# Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

cecho "#################################################################" $blue
cecho "                                                                 " $blue
cecho "    Address Book, Dashboard, iCal, TextEdit, and Disk Utility    " $blue
cecho "                                                                 " $blue
cecho "#################################################################" $blue

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0

cecho "#####################" $blue
cecho "                     " $blue
cecho "    Mac App Store    " $blue
cecho "                     " $blue
cecho "#####################" $blue

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

cecho "##############" $blue
cecho "              " $blue
cecho "    Photos    " $blue
cecho "              " $blue
cecho "##############" $blue

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

cecho "#####################" $blue
cecho "                     " $blue
cecho "    Google Chrome    " $blue
cecho "                     " $blue
cecho "#####################" $blue

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false