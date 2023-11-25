#!/bin/bash

mkdir -p ~/.local/share/fonts

if [ -d ~/.local/share/fonts ]
then
  RegularFont=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Regular/HackNerdFont-Regular.ttf?raw=true
  BoldFont=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Bold/HackNerdFont-Bold.ttf?raw=true
  ItalicFont=https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/Hack/Italic/HackNerdFont-Italic.ttf?raw=true

  curl -fLo ~/.local/share/fonts/'Hack Regular Nerd Font Complete.ttf' $RegularFont
  curl -fLo ~/.local/share/fonts/'Hack Bold Nerd Font Complete.ttf' $BoldFont
  curl -fLo ~/.local/share/fonts/'Hack Italic Nerd Font Complete.ttf' $ItalicFont
fi
