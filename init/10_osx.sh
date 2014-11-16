# OSX-only stuff. Abort if not OSX.
[[ "$OSTYPE" =~ ^darwin ]] || return 1

# If Homebrew available, run an update

if [[ ! "$(type -P brew)" ]]; then
    e_arrow "Please install Homebrew."
else
    e_header "Updating Homebrew"
    brew doctor
    brew update

    # Install Homebrew recipes.
    recipes=(
        ctags protobuf
        python lesspipe nmap
        tree zsh
    )

    list="$(to_install "${recipes[*]}" "$(brew list)")"
    if [[ "$list" ]]; then
        e_header "Installing Homebrew recipes: $list"
        brew install $list
    fi

    # Install Quicklook plugins.
    recipes=(
        suspicious-package
        quicklook-json
        qlmarkdown
        qlstephen
        qlcolorcode
    )

    list="$(to_install "${recipes[*]}" "$(brew list)")"
    if [[ "$list" ]]; then
        e_header "Installing Quick Look plugins: $list"
        brew tap phinze/homebrew-cask
        brew install brew-cask
        brew cask install $list
    fi

    # This is where brew stores its binary symlinks
    local binroot="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin
fi
