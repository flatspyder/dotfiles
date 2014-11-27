# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
if is_osx; then
    PATH=/usr/local/bin:$(path_remove /usr/local/bin)
    PATH=/usr/local/sbin:$(path_remove /usr/local/sbin)
    export PATH
fi

# Add Go binaries to path
PATH=$(path_remove /usr/local/go/bin):/usr/local/go/bin
PATH=$(path_remove $GOPATH/bin):$GOPATH/bin
