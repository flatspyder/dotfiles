# Pretty print json
alias json='python -m json.tool'

if [[ -n "$ANDROID_HOME" ]]; then
  alias adb="$ANDROID_HOME/platform-tools/adb"
fi

# Count code lines in some directory.
# Usage: loc [-r] [ext ...]
#   -r    search subdirectories recursively
# If no extensions are provided, a default set of common language
# extensions is used (py go c h js jsx ts tsx css html sh).
# Non-code files like images or documents are ignored.
# # => Lines of code for .py: 3781
# # => Lines of code for .js: 3354
# # => Lines of code for .css: 2970
# # => Total lines of code: 10105
function loc() {
  local recursive=false
  if [[ "$1" == "-r" ]]; then
    recursive=true
    shift
  fi

  local -a defaults=(py go c h js jsx ts tsx css html sh)
  local -A known=([py]=1 [go]=1 [c]=1 [h]=1 [js]=1 [jsx]=1 [ts]=1 [tsx]=1 [css]=1 [html]=1 [sh]=1)
  local -a exts=()

  if [[ $# -eq 0 ]]; then
    for ext in "${defaults[@]}"; do
      exts+=(".$ext")
    done
  else
    local arg
    for arg in "$@"; do
      arg="${arg#.}"
      if [[ -n ${known[$arg]} ]]; then
        exts+=(".$arg")
      fi
    done
  fi

  if [[ ${#exts[@]} -eq 0 ]]; then
    echo "No known language extensions specified."
    return 1
  fi

  local find_opts=()
  $recursive || find_opts=(-maxdepth 1)

  local total=0
  local ext
  local lines

  for ext in "${exts[@]}"; do
    lines=$(find . "${find_opts[@]}" -type f -name "*$ext" -exec wc -l {} + 2>/dev/null | awk '{s+=$1} END{print s+0}')
    if (( lines > 0 )); then
      total=$((total + lines))
      echo "Lines of code for ${fg[blue]}$ext${reset_color}: ${fg[green]}$lines${reset_color}"
    fi
  done
  echo "${fg[blue]}Total${reset_color} lines of code: ${fg[green]}$total${reset_color}"
}

# Monitor IO in real-time (open files etc).
function openfiles() {
  sudo dtrace -n 'syscall::open*:entry { printf("%s %s",execname,copyinstr(arg0)); }'
}

function serve() {
  local port=9000
  if [[ $1 =~ ^[0-9]+$ ]]; then
    port="$1"
  fi
  python3 -m http.server "$port"
}
