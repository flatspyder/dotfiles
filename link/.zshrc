#!/usr/bin/env zsh

curr="$HOME/.dotfiles"

# Load main files.
source "$curr/zsh/startup.sh"
source "$curr/zsh/completion.sh"
source "$curr/zsh/highlight.sh"

autoload -U colors && colors

# Load and execute the prompt theming system.
fpath=("$curr/zsh" $fpath)
autoload -Uz promptinit && promptinit
prompt 'oligaymond'

# OS detection
function is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}
function is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}
function get_os() {
  for os in osx ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# ==================================================================
# = Aliases =
# ==================================================================

# Simple clear command.
alias cl='clear'

# Lists the ten most used commands.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# ==================================================================
# = Functions =
# ==================================================================

# Show how much RAM application uses.
# $ ram safari
# # => safari uses 154.69 MBs of RAM.
function ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ $sum != "0" ]]; then
      echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
    else
      echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
    fi
  fi
}

function size() {
  # du -sh "$@" 2>&1 | grep -v '^du:' | sort -nr
  du -shck "$@" | sort -rn | awk '
      function human(x) {
          s="kMGTEPYZ";
          while (x>=1000 && length(s)>1)
              {x/=1024; s=substr(s,2)}
          return int(x+0.5) substr(s,1,1)
      }
      {gsub(/^[0-9]+/, human($1)); print}'
}

# $ git log --no-merges --pretty=format:"%ae" | stats
# # => 514 a@example.com
# # => 200 b@example.com
function stats() {
  sort | uniq -c | sort -r
}

# Shortcut for searching commands history.
# hist git
function hist() {
  history 0 | grep $@
}

# $ retry ping google.com
function retry() {
  echo Retrying "$@"
  $@
  sleep 1
  retry $@
}

# Default emacs command line mode
bindkey -e

# Who doesn't want home and end to work?
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Incremental backward search
bindkey "^R" history-incremental-pattern-search-backward

# ==================================================================
# = Shared source files =
# ==================================================================

source "$curr/source/50_devel.sh"
source "$curr/source/50_editor.sh"
source "$curr/source/50_file.sh"
source "$curr/source/50_net.sh"
source "$curr/source/50_osx.sh"
source "$curr/source/50_ubuntu.sh"
source "$curr/source/50_vcs.sh"

if is_osx; then
    source "$HOME/src/google-cloud-sdk/completion.zsh.inc"
    source "$HOME/src/google-cloud-sdk/path.zsh.inc"
fi
