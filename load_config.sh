#!/bin/bash

git clone https://github.com/w1am/dotfiles.git dotfiles_temp_config_download
path=`pwd`
filename=dotfiles_temp_config_download

if [ -d ~/.config/nvim ]
then
  rm -rf ~/.config/nvim
fi
cp -r $path/$filename/.config/nvim /home/$USER/.config

if [ -d ~/.config/fish ]
then
  rm -rf ~/.config/fish
fi
cp -r $path/$filename/.config/fish /home/$USER/.config

if [ -d ~/.config/alacritty ]
then
  rm -rf ~/.config/alacritty
fi
cp -r $path/$filename/.config/alacritty /home/$USER/.config

rm -rf $filename
