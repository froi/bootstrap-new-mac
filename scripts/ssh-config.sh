#!/bin/bash
source utils.sh

cecho "################################################################################################" $blue
cecho "                                                                                                " $blue
cecho "                              Generate ssh keys & add to ssh-agent                              " $blue
cecho " See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/ " $blue
cecho "                                                                                                " $blue
cecho "################################################################################################" $blue

cecho "Generating ssh keys, adding to ssh-agent..." $cyan
read -p 'Input email for ssh key: ' useremail

cecho "Use default ssh file location, enter a passphrase: " $cyan
ssh-keygen -t rsa -b 4096 -C "$useremail"  # will prompt for password
eval "$(ssh-agent -s)"

cecho "###########################################################################" $cyan
cecho "                                                                           " $cyan
cecho " sshconfig is synced add key to ssh-agent and store passphrase in keychain " $cyan
cecho "                                                                           " $cyan
cecho "###########################################################################" $cyan
ssh-add -K ~/.ssh/id_rsa

# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config 
# file to automatically load keys into the ssh-agent and store passphrases in your keychain.
if [ -e ~/.ssh/config ]
then
    cecho "ssh config already exists. Skipping adding osx specific settings... " $green
else
	cecho "Writing osx specific settings to ssh config... " @cyan
   cat <<EOT >> ~/.ssh/config
	Host *
		AddKeysToAgent yes
		UseKeychain yes
		IdentityFile ~/.ssh/id_rsa
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
read -p "Do you have a GH personal token? [y/n]: " response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if CONTINUE; then
    retries=3
    SSH_KEY=`cat ~/.ssh/id_rsa.pub`

    for ((i=0; i<retries; i++)); do
        read -p 'GitHub username: ' ghusername
        read -p 'Machine name: ' ghtitle
        read -sp 'GitHub personal token: ' ghtoken

        gh_status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$ghusername:$ghtoken" -d '{"title":"'$ghtitle'","key":"'"$SSH_KEY"'"}' 'https://api.github.com/user/keys')

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