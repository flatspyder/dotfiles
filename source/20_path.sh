# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
if is_osx; then
    PATH=/usr/local/bin:$(path_remove /usr/local/bin)
    PATH=/usr/local/sbin:$(path_remove /usr/local/sbin)
    export CUDA_HOME=/usr/local/cuda
    export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
    PATH="$CUDA_HOME/bin:$PATH"
    export PATH
fi

# Add Go binaries to path
PATH=$(path_remove /usr/local/go/bin):/usr/local/go/bin
PATH=$(path_remove $GOPATH/bin):$GOPATH/bin
