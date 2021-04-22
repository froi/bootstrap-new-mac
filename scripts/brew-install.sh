#!/usr/bin/env zsh

source scripts/utils.sh

echo ""
cecho "================== Tapping heroku/brew ==================" $blue
brew tap heroku/brew

echo ""
cecho "================ Installing Git and LFS ================" $blue
echo ""
brew install git
brew install git-lfs

echo ""
cecho "=================== Installing Grep ===================" $blue
echo ""
brew install grep

echo ""
cecho "=============== Installing Heroku CLI ================" $blue
echo ""
brew install heroku

echo ""
cecho "================== Installing Less ==================" $blue
echo ""
brew install less

echo ""
cecho "============== Installing libmemcached ==============" $blue
echo ""
brew install libmemcached

echo ""
cecho "=========== Installing and Configuring NVM ===========" $blue
echo ""

mkdir -p ~/.nvm

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | zsh
cat << EOT >> ~/.zshrc
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
EOT

source ~/.zshrc
nvm install --lts

echo ""
cecho "========= Installing and Configurating pyenv =========" $blue
echo ""
brew install pyenv

cat << EOT >> ~/.zshrc
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
EOT

echo ""
cecho "================= Installing tree =================" $blue
echo ""
brew install tree

echo ""
cecho "================ Installing trash ================" $blue
echo ""
brew install trash

echo ""
cecho "================ Installing wget ================" $blue
echo ""
brew install wget

echo ""
cecho "======= 🎉 Brew apps installation DONE 🎉 ========" $green
