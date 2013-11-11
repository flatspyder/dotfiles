# History settings

# Allow use to re-edit a failed history substitution.
shopt -s histreedit
# History expansions will be verified before execution.
shopt -s histverify

# append to the history file, don't overwrite it
shopt -s histappend

# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Append commands to the history every time a prompt is show,
# instead of after closing the session.
export PROMPT_COMMAND='history -a'

# Easily re-execute the last history command.
alias r="fc -s"
