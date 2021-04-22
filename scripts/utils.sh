#!/usr/bin/env zsh

function cecho() {
  echo "${2}${1}${reset}"
  return
}

# Set the colours you can use
export black=$(tput setaf 0)
export red=$(tput setaf 1)
export green=$(tput setaf 2)
export yellow=$(tput setaf 3)
export blue=$(tput setaf 4)
export magenta=$(tput setaf 5)
export cyan=$(tput setaf 6)
export white=$(tput setaf 7)

# Resets the style
export reset=`tput sgr0`