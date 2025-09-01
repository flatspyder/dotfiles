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

# Git log colors.
zstyle -s ':prezto:module:git:log:medium' format '_git_log_medium_format' \
  || _git_log_medium_format='%C(bold)Commit:%C(reset) %C(green)%H%C(red)%d%n%C(bold)Author:%C(reset) %C(cyan)%an <%ae>%n%C(bold)Date:%C(reset)   %C(blue)%ai (%ar)%C(reset)%n%+B'
zstyle -s ':prezto:module:git:log:oneline' format '_git_log_oneline_format' \
  || _git_log_oneline_format='%C(green)%h%C(reset) %s%C(red)%d%C(reset)%n'
zstyle -s ':prezto:module:git:log:brief' format '_git_log_brief_format' \
  || _git_log_brief_format='%C(green)%h%C(reset) %s%n%C(blue)(%ar by %an)%C(red)%d%C(reset)%n'

# Status
zstyle -s ':prezto:module:git:status:ignore' submodules '_git_status_ignore_submodules' \
  || _git_status_ignore_submodules='none'

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

# Set the list of directories that Zsh searches for programs.
# More specific paths are handled by source/20_path.sh, which is sourced in .zshrc.
path=(
  /usr/local/opt/ruby/bin
  /usr/{bin,sbin}
  /{bin,sbin}
  $HOME/.dotfiles/bin
  $HOME/.local/bin
  $HOME/src/flutter/bin
  $path
)

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

# Create Go path for source code
export GOPATH=$HOME/src/gocode

# Virtualenv should use Distribute instead of legacy setuptools
export VIRTUALENV_DISTRIBUTE=true

# Centralized location for new virtual environments
export PIP_VIRTUALENV_BASE=$HOME/Virtualenvs

# Pip should only run if there is a virtualenv currently activated
#export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache

# Use Anaconda to Path
condaenv_anaconda="$HOME/anaconda2/etc/profile.d/conda.sh"
condaenv_miniconda="$HOME/miniconda3/etc/profile.d/conda.sh"
if [[ -f "$condaenv_anaconda" ]]; then
  source "$condaenv_anaconda"
elif [[ -f "$condaenv_miniconda" ]]; then
  source "$condaenv_miniconda"
fi
unset condaenv_anaconda condaenv_miniconda

# Perl 5
PATH="$HOME/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="$HOME/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/perl5"; export PERL_MM_OPT;
