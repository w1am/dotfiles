#!/bin/bash

if ! [ $(id -u) = 0 ]; then
  echo "The script need to be run as root." >&2
  exit 1
fi

# Update system
sudo apt update

# General
sudo apt install -y git
sudo apt install -y npm
sudo npm install --global yarn
sudo apt install apt-transport-https curl

# Trash
apt install -y trash-cli

# Gnome Tweak Tools
sudo apt-add-repository universe
sudo apt -y install gnome-tweak-tool

# Terminal && Shell
sudo add-apt-repository -y ppa:mmstick76/alacritty
sudo apt -y install alacritty
sudo apt -y install fish
curl -L https://get.oh-my.fish | fish
chsh -s /usr/bin/fish

# Install gnome shell extensions
sudo apt install -y chrome-gnome-shell 
sudo apt install -y gnome-shell-extensions

# TMUX Config
wget -P /home/$USER https://raw.githubusercontent.com/w1am/dotfiles/master/.tmux.conf

# Alacritty Config
wget -P /home/$USER https://raw.githubusercontent.com/w1am/dotfiles/master/.config/alacritty/.tmux.conf

# Install Patched Fonts
mkdir -p ~/.local/share/fonts

if [ -d ~/.local/share/fonts ]
then
  RegularFont=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Regular/complete/Hack%20Regular%20Nerd%20Font%20Complete.ttf?raw=true
  BoldFont=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Bold/complete/Hack%20Bold%20Nerd%20Font%20Complete.ttf?raw=true
  ItalicFont=https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/Hack/Italic/complete/Hack%20Italic%20Nerd%20Font%20Complete.ttf?raw=true

  curl -fLo ~/.local/share/fonts/'Hack Regular Nerd Font Complete.ttf' $RegularFont
  curl -fLo ~/.local/share/fonts/'Hack Bold Nerd Font Complete.ttf' $BoldFont
  curl -fLo ~/.local/share/fonts/'Hack Italic Nerd Font Complete.ttf' $ItalicFont
fi

# NVM
omf install bass
omf install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Install Node
nvm install --lts
nvm alias default 0.12.7

# Install Alacritty themes
npx alacritty-themes

# Tmux
sudo apt install -y tmux

# Package Manager
sudo apt install -y synaptic

# Nvim pre release
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
mkdir /usr/local/bin/nvim && mv nvim.appimage /usr/local/bin/nvim

# Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Brave browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt install -y brave-browser


# Turn on universal access mode and set reduce keyboard delay for fast typing experience
gsettings set org.gnome.desktop.a11y always-show-universal-access-status true
gsettings set org.gnome.desktop.peripherals.keyboard delay 198

# Configure general settings and turn on dark theme
gsettings set org.gnome.desktop.interface gtk-theme "HighContrastInverse"
gsettings set org.gnome.desktop.interface enable-animations false
dconf write /org/gnome/desktop/sound/event-sounds false

gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
gsettings set org.gnome.shell.extensions.dash-to-dock intellihide false
gsettings set org.gnome.shell.extensions.dash-to-dock autohide true

# Power settings
gsettings set org.gnome.settings-daemon.plugins.power idle-dim false
gsettings set org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

# Change locale format
gsettings set org.gnome.system.locale region 'en_GB.UTF-8'

# Change default terminal
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# Top bar
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-date true

# VSCODE
sudo snap install code --classic

# Languages
yarn global add pyright
yarn global add typescript
pip install jedi
python3 -m pip install --user --upgrade pynvim

# PostgreSQL
sudo apt install -y postgresql postgresql-contrib

# VLC
sudo snap install vlc

echo "Installation complete"
