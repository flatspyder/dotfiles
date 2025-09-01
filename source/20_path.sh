typeset -gU path PATH

# APPLE, Y U PUT /usr/bin B4 /usr/local/bin?!
if is_osx; then
  path=(
    /usr/local/bin
    /usr/local/sbin
    $HOME/miniconda3/bin
    $path
  )
fi

# Add Go binaries to path
path=(
  /usr/local/go/bin
  $GOPATH/bin
  $path
)

# Add NPM binaries to path
path=(
  $HOME/.npm-global
  $path
)

# Add local user binaries to path
path=(
  $HOME/bin
  $path
)
