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

# Source shared aliases and functions.
if [[ -f "$curr/source/50_aliases.sh" ]]; then
  source "$curr/source/50_aliases.sh"
fi
if [[ -f "$curr/source/50_functions.sh" ]]; then
  source "$curr/source/50_functions.sh"
fi

# Default emacs command line mode
bindkey -e

# Who doesn't want home and end to work?
bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word
bindkey '^J'      backward-kill-line            # ctrl+j     delete everything before cursor

# Incremental backward search
bindkey "^R" history-incremental-pattern-search-backward

# ==================================================================
# = Source Shared Files =
# ==================================================================
# Source a curated list of shared files.
local files_to_source=(
  # Core setup
  "00_dotfiles.sh"
  # Note: 20_path.sh is sourced in .zshenv

  # Shared configurations (already sourced above, but let's be explicit)
  # "50_aliases.sh"
  # "50_functions.sh"

  # Other shared configurations
  "50_editor.sh"
  "50_file.sh"
  "50_vcs.sh"
  "50_devel.sh"
  "50_net.sh"

  # OS-specific configurations (with guards inside)
  "50_osx.sh"
  "50_ubuntu.sh"
)

for file in "${files_to_source[@]}"; do
  if [[ -f "$curr/source/$file" ]]; then
    source "$curr/source/$file"
  fi
done

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/src/google-cloud-sdk/path.zsh.inc" ]; then source "$HOME/src/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/src/google-cloud-sdk/completion.zsh.inc" ]; then source "$HOME/src/google-cloud-sdk/completion.zsh.inc"; fi

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Add VS Code to path
if [ -d "$HOME/Applications/Visual Studio Code.app" ]; then
    export PATH="$PATH:$HOME/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
