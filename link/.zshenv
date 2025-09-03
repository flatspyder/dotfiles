# .zshenv is sourced on all invocations of the shell, both interactive and non-interactive.
# It should be used for setting environment variables, not for anything that produces output
# or assumes the shell is attached to a tty.

# Defines environment variables.
privenv="$HOME/.private-env"
[[ -f "$privenv" ]] && source $privenv

# Editors.
# --------
export EDITOR='vim'
export VISUAL='mvim -f'
export PAGER='less'

# Language.
# ---------
if [[ -z "$LANG" ]]; then
  eval "$(locale)"
fi

# The zstyle configurations below appeared to be remnants of a Prezto setup
# that is no longer in use and have been removed for cleanliness.

# Less.
# -----
# Set the default Less options.
# Mouse-wheel scrolling has been disabled by -X (disable screen clearing).
# Remove -X and -F (exit if the content fits on one screen) to enable it.
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
if (( $+commands[lesspipe.sh] )); then
  export LESSOPEN='| /usr/bin/env lesspipe.sh %s 2>&-'
fi

# Paths.
# ------
typeset -gU cdpath fpath mailpath manpath path
typeset -gUT INFOPATH infopath

# Commonly used directories.
dev="$HOME/Developer"

cdpath=(
  $cdpath
)

# Set the list of directories that info searches for manuals.
infopath=(
  /usr/local/share/info
  /usr/share/info
  $infopath
)

# Set the list of directories that man searches for manuals.
manpath=(
  /usr/local/share/man
  /usr/share/man
  $manpath
)

for path_file in /etc/manpaths.d/*(.N); do
  manpath+=($(<$path_file))
done
unset path_file

# Source the master path configuration file.
if [[ -f "$HOME/.dotfiles/source/20_path.sh" ]]; then
  source "$HOME/.dotfiles/source/20_path.sh"
fi

# Add paths from /etc/paths.d on systems that use it.
for path_file in /etc/paths.d/*(.N); do
  path+=($(<$path_file))
done
unset path_file

# Temporary Files.
if [[ -d "$TMPDIR" ]]; then
  export TMPPREFIX="${TMPDIR%/}/zsh"
  if [[ ! -d "$TMPPREFIX" ]]; then
    mkdir -p "$TMPPREFIX"
  fi
fi

# Use Anaconda to Path
condaenv="$HOME/miniconda3/etc/profile.d/conda.sh"
[[ -f "$condaenv" ]] && source $condaenv
