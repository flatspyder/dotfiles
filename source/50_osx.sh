# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"
#alias c='pbcopy'
alias p='pbpaste'

# Make 'less' more.
[ "$(command -v lesspipe.sh >/dev/null 2>&1)" ] && eval "$(lesspipe.sh)"

# Lock current session and proceed to the login screen.
alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'

# Sniff network info.
alias sniff="sudo ngrep -d 'en0' -t '^(GET|POST) ' 'tcp and port 80'"

# Process grep should output full paths to binaries.
alias pgrep='pgrep -fli'

# Show current Finder directory.
function finder {
  osascript 2>/dev/null <<EOF
    tell application "Finder"
      return POSIX path of (target of window 1 as alias)
    end tell
EOF
}

# convert text to audio file
function speak () {
	echo
	echo 'Converting text to speech'
	echo

	say $1 -o input.aiff

	afconvert -v -c 1 -f WAVE -d LEI16@22050 input.aiff output.wav
	
	rm input.aiff
}
