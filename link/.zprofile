# ~/.zprofile - bridge login shells to main Zsh configuration

if [[ -f "$HOME/.zshrc" ]]; then
  source "$HOME/.zshrc"
fi
