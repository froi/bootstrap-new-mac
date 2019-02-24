#!/bin/bash
source utils.sh

# Homebrew
echo ""
cecho "============== Installing Homebrew and Cask ==============" $green
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo ""
cecho "============== Tapping Brew Caskroom/fonts ==============" $green
brew tap caskroom/fonts
brew tap heroku/brew

echo ""
cecho "================= Installing Brew Casks =================" $green
while read app
do
    cecho "Installing ${app}" $blue
    brew cask install "$app"
done <data/cask_apps

echo ""
cecho "================= Installing Brew apps =================" $green
while read app
do
    cecho "Installing ${app}" $blue
    brew install "$app"
done <data/brew_apps

echo ""
cecho "=============== Install node global tools ===============" $green
npm install -g npm
npm install -g eslint
npm install -g prettier

echo ""
cecho "================= Install Python tools =================" $green
pip3 install pylint
pip3 install flake8

echo ""
cecho "==================== Install Jekyll ====================" $green
sudo gem install jekyll bundler

echo ""
cecho "================== Install MacOs Apps =================="
cecho "Need to log in to App Store manually to install apps with mas...." $red
echo "Opening App Store. Please login."
open "/Applications/App Store.app"
echo "Is app store login complete.(y/n)? "
read response
if [ "$response" != "${response#[Yy]}" ]
then
	source mac-apps-install.sh
else
	cecho "App Store login not complete. Skipping installing App Store Apps" $red
fi