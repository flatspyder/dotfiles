# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# Update APT.
e_header "Updating APT"
sudo apt-get --qq update
sudo apt-get --qq dist-upgrade

# Install APT packages.
packages=(
  build-essential
  lib32stdc++6
  git-core
  htop
  libssl-dev
  ngrep
  nmap
  telnet
  tree
  zsh
)

packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo apt-get -qq install "$package"
  done
fi
