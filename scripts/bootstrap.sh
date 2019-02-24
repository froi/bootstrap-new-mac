#!/bin/bash
source scripts/utils.sh

FILES=('.bash_profile' '.bash_prompt' '.exports' '.aliases' '.gitconfig')
CURRENTPATH=$(pwd)

cecho "[Download] dotfiles from https://github.com/froi/dotfiles" $blue
for F in ${FILES[@]}; do
    cecho "--> [Download]: dotfile -> ${HOME}/${F}" $cyan
    curl https://raw.githubusercontent.com/froi/dotfiles/master/$F -o $HOME/$F
done

if [ !-d "$HOME/.hammerspoon/init.lua"]; then
    mkdir -p $HOME/.hammerspoon
fi

cecho "[Download] Hammerspoon/init.lua" $blue
curl https://gist.githubusercontent.com/froi/df2e5df19d9b79512f11/raw/5256386b2fabb7716a4a4be9ce808a8d3f6cf0ad/init.lua -o $HOME/.hammerspoon/init.lua

cecho "Do you want to configure your ssh keys now? [y/n]: " $cyan
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    source ssh-config.sh
else
    cecho "SSH keys not configured" $red
    cecho "You can revisit this later on." $red
    cecho "See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/" $cyan
fi

source $HOME/.bash_profile

cecho "Bootstrap.sh -> DONE" $green