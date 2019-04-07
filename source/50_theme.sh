# Use Base16 colour profiles for terminal
# git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"