function brew_installed() {
  local f="$1"
  local installed=$(brew info --json "${f}" |jq '.[].installed |length')
  return $((! "${installed}"))
}

# for gnu
if brew_installed gnu-tar; then
  PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
  MANPATH="/opt/homebrew/opt/gnu-tar/libexec/gnuman:$MANPATH"
fi
if brew_installed gnu-sed; then
  PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
  MANPATH="/opt/homebrew/opt/gnu-sed/libexec/gnuman:$MANPATH"
fi
if brew_installed gawk; then
  PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
  MANPATH="/opt/homebrew/opt/gawk/libexec/gnuman:$MANPATH"
fi
if brew_installed grep; then
  PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
  MANPATH="/opt/homebrew/opt/grep/libexec/gnuman:$MANPATH"
fi

# for anyenv
if brew_installed anyenv; then
  eval "$(anyenv init -)"
fi

# for rust
if [ -f "$HOME/.cargo/env" ]; then
  . "$HOME/.cargo/env"
fi

# for postgresql
if brew_installed postgresql@16; then
  export PGSQL_HOME="/opt/homebrew/opt/postgresql@16"
  export PATH="$PGSQL_HOME/bin:$PATH"
  export LDFLAGS="${LDFLAGS} -L$PGSQL_HOME/lib"
  export CPPFLAGS="${CPPFLAGS} -I$PGSQL_HOME/include"
fi

# for git
source $(brew --prefix)/etc/bash_completion.d/git-prompt.sh
fpath=($(brew --prefix)/share/zsh-completions $(brew --prefix)/share/zsh/site-functions $fpath)
autoload -Uz compinit && compinit -u
GIT_PS1_SHOW_COLORHINSTS=true
GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM=auto
setopt PROMPT_SUBST
PROMPT='
%Bstatus=%? / %D{%Y-%m-%d %H:%M:%S}
%F{green}%n@%m%f:%F{cyan}%~%f$(__git_ps1 " (%s)")%f%b
\$ '

# for Android SDK
export ANDROID_HOME="${HOME}/Library/Android/sdk"
export PATH="${PATH}:${ANDROID_HOME}/platform-tools"

# .local/bin
export PATH="${HOME}/.local/bin:${PATH}"
