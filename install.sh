#!/bin/sh
dfdir="$(cd $(dirname $0) && pwd)"

function backupAndInstall() {
  frompath="$1"
  topath="$2"
  if [ -h "$topath" ]; then
    rm "$topath"
  elif [ -e "$topath" ]; then
    mv "$topath"{,.bk}
  fi
  ln -s "$frompath" "$topath"
}

# install homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
(cd "$dfdir" && brew bundle)

# initialize anyenv
if [ ! -d ~/.anyenv ]; then
	anyenv init
	eval "$(anyenv init -)"
	anyenv install --init
fi

# install dotfiles
backupAndInstall "${dfdir}"/zshrc ~/.zshrc
backupAndInstall "${dfdir}"/gitconfig ~/.gitconfig

mkdir -p ~/.ssh
chmod 700 ~/.ssh
backupAndInstall "${dfdir}"/ssh-config ~/.ssh/config

mkdir -p ~/.config/karabiner
chmod 700 ~/.config ~/.config/karabiner
backupAndInstall "${dfdir}"/karabiner.json ~/.config/karabiner/karabiner.json
