#!/bin/bash

source ./scripts/utils.sh

cecho "###############################################" $cyan
cecho "              Mac OS Setup Script              " $cyan
cecho "              By Froilan Irizarry              " $cyan
cecho "                                               " $cyan
cecho "             Heavily influenced by             " $cyan
cecho "     https://github.com/nnja/new-computer      " $cyan
cecho "                                               " $cyan
cecho "      Want to follow me on the interwebs?      " $cyan
cecho "        Github: https://github.com/froi        " $cyan
cecho "      Twitter: https://twitter.com/skfroi      " $cyan
cecho "       Twitch! https://twitch.tv/skfroi        " $cyan
cecho "###############################################" $cyan

echo ""
cecho "###############################################" $red
cecho "   🛑   DO NOT RUN THIS SCRIPT BLINDLY   🛑    " $red
cecho "          YOU'LL PROBABLY REGRET IT...         " $red
cecho "                                               " $red
cecho "               READ IT THOROUGHLY              " $red
cecho "          AND EDIT TO SUIT YOUR NEEDS          " $red
cecho "   https://github.com/froi/bootstrap-new-mac   " $red
cecho "###############################################" $red

# Set continue to false by default.
CONTINUE=false

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo ""
cecho "=============== Bootstrapping environment ===============" $blue
source ./scripts/bootstrap.sh

echo ""
cecho "==================== Installing Apps ====================" $blue
source ./scripts/install.sh

echo ""
cecho "============== Updating Mac settings ==============" $blue
source ./scripts/mac-settings.sh

echo ""
cecho "====================== 🎉 DONE 🎉 =======================" $green

echo ""
cecho "====================== Cleaning Up ======================" $blue
unset cecho
