#!/bin/bash

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
