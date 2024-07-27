#!/bin/sh
dfdir="$(cd $(dirname $0) && pwd)"

function backupAndInstall() {
  frompath="$1"
  topath="$2"
  if [ -h "$topath" ]; then
    rm "$topath"
  elif [ -e "$topath" ]; then
    mv *$topath*{,.bk}
  fi
  ln -s "$frompath" "$topath"
}

# install homebrew
if [ ! -x /opt/homebrew/bin/brew ]; then
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"
(cd "$dfdir" && brew bundle)

# install dotfiles
backupAndInstall "${dfdir}"/zshrc ~/.zshrc
