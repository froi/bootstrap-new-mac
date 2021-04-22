#!/usr/bin/env zsh

source scripts/utils.sh

if [ ! -d "$HOME/.hammerspoon" ]; then
    mkdir -p $HOME/.hammerspoon
    cecho "[Download] Hammerspoon/init.lua" $blue
    curl https://gist.githubusercontent.com/froi/df2e5df19d9b79512f11/raw/aea46d10243c359d68c83694fe17a9c955380fe0/init.lua -o $HOME/.hammerspoon/init.lua
fi
if [ ! -a "$HOME/.hammerspoon/init.lua" ]; then
    cecho "[Download] Hammerspoon/init.lua" $blue
    curl https://gist.githubusercontent.com/froi/df2e5df19d9b79512f11/raw/aea46d10243c359d68c83694fe17a9c955380fe0/init.lua -o $HOME/.hammerspoon/init.lua
fi

vared -p "Do you want to configure your ssh keys now? [y/N]: " -c response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    source scripts/ssh-config.sh
else
    cecho "SSH keys not configured" $red
    cecho "You can revisit this later on." $red
    cecho "See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/" $cyan
fi

if ! type "brew" > /dev/null; then
    echo ""
    cecho "================== Installing Homebrew ==================" $green
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    cat << EOT >> ~/.zshrc
    if type brew &>/dev/null; then
        FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

        autoload -Uz compinit
        compinit
    fi
EOT
else
    echo ""
    cecho "Homebrew is already installed. Skipping." $blue
fi

cecho "Bootstrap.sh -> DONE" $green
