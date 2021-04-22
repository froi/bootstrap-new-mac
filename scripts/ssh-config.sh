#!/usr/bin/env zsh

source scripts/utils.sh

cecho "################################################################################################" $blue
cecho "                                                                                                " $blue
cecho "                              Generate ssh keys & add to ssh-agent                              " $blue
cecho "                                                                                                " $blue
cecho "            The script will be creating two ssh keys. A default key and a GitHub key.           " $blue
cecho "            The default key is meant to be used for ssh logins or anything else.                " $blue
cecho "            The GitHub key is meant to be used for GitHub SSH access. This script will          " $blue
cecho "            also attempt to add this key to your GitHub account.                                " $blue
cecho " See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/ " $blue
cecho "                                                                                                " $blue
cecho "################################################################################################" $blue

vared -p "Name your default key: " -c defaultKeyName
vared -p "Name your GitHub key: " -c githubKeyName
vared -p "What email do you want to use for your ssh keys? " -c useremail

cecho "Generating default ssh key" $cyan
cecho "Using default ssh file location, enter a passphrase: " $cyan
ssh-keygen -t rsa -b 4096 -f ~/.ssh/"$defaultKeyName" -C "$useremail default key via bootstrap script"  # will prompt for password

cecho "Generating GitHub ssh key" $cyan
cecho "Using default ssh file location, enter a passphrase: " $cyan
ssh-keygen -t rsa -b 4096 -f ~/.ssh/"$githubKeyName" -C "$useremail default key via bootstrap script"  # will prompt for password

eval "$(ssh-agent -s)"

cecho "###########################################################################" $cyan
cecho "                                                                           " $cyan
cecho " sshconfig is synced add key to ssh-agent and store passphrase in keychain " $cyan
cecho "                                                                           " $cyan
cecho "###########################################################################" $cyan
ssh-add -K ~/.ssh/"$defaultKeyName"
ssh-add -K ~/.ssh/"$githubKeyName"

# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config
# file to automatically load keys into the ssh-agent and store passphrases in your keychain.
if [ -e ~/.ssh/config ]
then
    cecho "ssh config already exists. Skipping adding osx specific settings... " $green
else
cecho "Writing osx specific settings to ssh config... " @cyan
cat <<'EOT' >> ~/.ssh/config
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/$defaultKeyName
Host GitHub
    AddKeysToAgent yes
    UseKeychain yes
    Hostname github.com
    User git
    IdentityFile ~/.ssh/$githubKeyName
EOT
fi

cecho "#########################################" $blue
cecho "                                         " $blue
cecho "      Add ssh-key to GitHub via api      " $blue
cecho "                                         " $blue
cecho "#########################################" $blue

cecho "Adding ssh-key to GitHub (via api)..." $cyan
cecho "Important! For this step, use a github personal token with the admin:public_key permission." $cyan
cecho "If you don't have one, create it here: https://github.com/settings/tokens/new" $cyan
vared -p "Do you have a GH personal token? [y/n]: " -c response
CONTINUE=false
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if [ "$CONTINUE" = true ]; then
    retries=3
    SSH_KEY=`cat ~/.ssh/$githubKeyName.pub`

    for ((i=0; i<retries; i++)); do
        vared -p 'GitHub username: ' -c ghusername
        vared -p 'Machine name: ' -c ghtitle
        vared -p 'GitHub personal token: ' -c ghtoken

        gh_status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -H "Authorization: token $ghtoken" -d '{"title":"'$ghtitle'","key":"'"$SSH_KEY"'"}' 'https://api.github.com/user/keys')

        if (( $gh_status_code -eq == 201))
        then
            echo "GitHub ssh key added successfully!"
            break
        else
                echo "Something went wrong. Enter your credentials and try again..."
                echo -n "Status code returned: "
                echo $gh_status_code
        fi
    done

    [[ $retries -eq i ]] && echo "Adding ssh-key to GitHub failed! Try again later."
else
    cecho "You can add the ssh key manually to your Gihtub account." $red
    cecho "Follow the instructions found here:" $red
    cecho "https://help.github.com/en/articles/adding-a-new-ssh-key-to-your-github-account" $cyan
fi
