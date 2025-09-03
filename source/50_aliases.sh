# Aliases that are shared between Bash and Zsh.

# Simple clear command.
alias cl='clear'

# Lists the ten most used commands.
# `history 0` works in both Bash and Zsh to show the whole history.
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"
