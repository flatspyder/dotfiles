# Functions that are shared between Bash and Zsh.

# OS detection functions
is_osx() {
  [[ "$OSTYPE" =~ ^darwin ]] || return 1
}

is_ubuntu() {
  [[ "$(cat /etc/issue 2> /dev/null)" =~ Ubuntu ]] || return 1
}

get_os() {
  for os in osx ubuntu; do
    is_$os; [[ $? == ${1:-0} ]] && echo $os
  done
}

# Show how much RAM an application uses.
# $ ram safari
ram() {
  local sum
  local items
  local app="$1"
  if [ -z "$app" ]; then
    echo "First argument - pattern to grep from processes"
  else
    sum=0
    for i in $(ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'); do
      sum=$(($i + $sum))
    done
    sum=$(echo "scale=2; $sum / 1024.0" | bc)
    if [[ "$sum" != "0" ]]; then
      echo "$app uses $sum MBs of RAM."
    else
      echo "There are no processes with pattern '$app' are running."
    fi
  fi
}

# A better `du -sh`
size() {
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

# Pipe to this to get a count of unique lines.
# $ git log --no-merges --pretty=format:"%ae" | stats
stats() {
  sort | uniq -c | sort -r
}

# Shortcut for searching command history.
# $ hist git
hist() {
  history 0 | grep "$@"
}

# Retry a command until it succeeds.
# $ retry ping google.com
retry() {
  echo "Retrying \"$@\"..."
  $@
  # shellcheck disable=SC2181
  if [[ $? -ne 0 ]]; then
    sleep 1
    retry "$@"
  fi
}
