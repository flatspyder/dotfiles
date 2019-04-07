# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
if is_osx; then
    PATH=/usr/local/bin:$(path_remove /usr/local/bin)
    PATH=/usr/local/sbin:$(path_remove /usr/local/sbin)
    PATH=$HOME/miniconda3/bin:$(path_remove $HOME/miniconda3/bin)
    export PATH
fi

# Add Go binaries to path
PATH=$(path_remove /usr/local/go/bin):/usr/local/go/bin
PATH=$(path_remove $GOPATH/bin):$GOPATH/bin

# Add NPM binaries to path
PATH=$(path_remove $HOME/.npm-global):$HOME/.npm-global

# Add local user binaries to path
PATH=$(path_remove $HOME/bin):$HOME/bin
