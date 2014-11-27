# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Package management
alias update="sudo apt-get -qq update && sudo apt-get upgrade"
alias install="sudo apt-get install"
alias remove="sudo apt-get remove"
alias search="apt-cache search"

# Process grep should output full paths to binaries.
alias pgrep='pgrep -fl'

# Make 'less' more.
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
