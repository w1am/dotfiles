#!/bin/bash

DOWNLOAD_DIR=/home/$USER/Downloads

# Update system
sudo apt update

# Verify git
command -v git >/dev/null 2>&1 ||
{ echo >&2 "Git is not installed. Installing..";
  sudo apt install git
}

if ! [ $(id -u) = 0 ]; then
  echo "The script need to be run as root." >&2
  exit 1
fi

# Nvim pre release
sudo snap install nvim --edge --classic

# Symlink stuff
sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node"
sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm"

# Gnome tweak tool and alacritty
sudo apt-add-repository -y universe
sudo add-apt-repository -y ppa:mmstick76/alacritty

# Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

# General
cat apps.list | xargs sudo apt-get -y install

# yarn
sudo npm install --global yarn

# Oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

mkdir -p /home/$USER/.config/alacritty
mkdir -p /home/$USER/.config/nvim

# TMUX Config and ZSH Config
cp $DOWNLOAD_DIR/w1am/.tmux.conf /home/$USER
cp $DOWNLOAD_DIR/w1am/.zshrc /home/$USER

# NVM
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash

# Install Node
nvm install --lts

# Packer
git clone https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Languages
yarn global add pyright, typescript
pip3 install jedi
python3 -m pip install --user --upgrade pynvim

echo "1/3 Setting up gnome..."
source ./ubuntu.sh
sleep 2
echo "2/3 Installing patched fonts.."
source ./patched_fonts.sh
echo "3/3 Loading configs..."
sleep 2
source ./load_config.sh

# Set default shell
sudo chsh -s /usr/bin/zsh

echo "Done."

