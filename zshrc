eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(anyenv init -)"
. "$HOME/.cargo/env"

PATH="/opt/homebrew/opt/gnu-tar/libexec/gnubin:$PATH"
MANPATH="/opt/homebrew/opt/gnu-tar/libexec/gnuman:$MANPATH"
PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
MANPATH="/opt/homebrew/opt/gnu-sed/libexec/gnuman:$MANPATH"
PATH="/opt/homebrew/opt/gawk/libexec/gnubin:$PATH"
MANPATH="/opt/homebrew/opt/gawk/libexec/gnuman:$MANPATH"
PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
MANPATH="/opt/homebrew/opt/grep/libexec/gnuman:$MANPATH"

function brew_installed() {
  local f="$1"
  local installed=$(brew info --json "${f}" |jq '.[].installed |length')
  return $((! "${installed}"))
}

# for postgresql
if brew_installed postgresql@16; then
  export PGSQL_HOME="/opt/homebrew/opt/postgresql@16"
  export PATH="$PGSQL_HOME/bin:$PATH"
  export LDFLAGS="${LDFLAGS} -L$PGSQL_HOME/lib"
  export CPPFLAGS="${CPPFLAGS} -I$PGSQL_HOME/include"
fi
