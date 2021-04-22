#!/usr/bin/env zsh

source scripts/utils.sh

echo ""
cecho "==================== Installing dash ====================" $blue
echo ""
brew install cask dash

echo ""
cecho "================== Installing dropbox ==================" $blue
echo ""
brew install cask dropbox

echo ""
cecho "=================== Installing firefox ==================" $blue
echo ""
brew install cask firefox

echo ""
cecho "=============== Installing google-chrome ==============" $blue
echo ""
brew install cask google-chrome

echo ""
cecho "================== Installing iterm2 =================" $blue
echo ""
brew install cask iterm2

echo ""
cecho "================= Installing postgres ================" $blue
echo ""
brew install cask postgres

echo ""
cecho "================= Installing slack ================" $blue
echo ""
brew install cask slack

echo ""
cecho "================ Installing spotify ===============" $blue
echo ""
brew install cask spotify

echo ""
cecho "========== Installing visual-studio-code =========" $blue
echo ""
brew install cask visual-studio-code

echo ""
cecho "================= Installing vlc ================" $blue
echo ""
brew install cask vlc

echo ""
cecho "==== 🎉 Brew Cask apps installation DONE 🎉 =====" $green
