export PATH

# Create Go path for source code
export GOPATH=$HOME/src/gocode

# Add Go binaries to path
PATH=$(path_remove /usr/local/go/bin):/usr/local/go/bin
PATH=$(path_remove $GOPATH/bin):$GOPATH/bin

# Virtualenv should use Distribute instead of legacy setuptools
export VIRTUALENV_DISTRIBUTE=true

# Centralized location for new virtual environments
export PIP_VIRTUALENV_BASE=$HOME/Virtualenvs

# Pip should only run if there is a virtualenv currently activated
#export PIP_REQUIRE_VIRTUALENV=true

# cache pip-installed packages to avoid re-downloading
export PIP_DOWNLOAD_CACHE=$HOME/.pip/cache
