#!/bin/bash
themedir=$(realpath .)
echo "Installing Blue Steel Theme"
echo $themedir
cd $HOME
sudo rm .Xresources 
sudo rm XTerm 
cd $themedir
sudo cp .Xresources $HOME/.Xresources
sudo cp XTerm $HOME/XTerm
#sudo cp colors.sh $THEME/../colors.sh
feh --bg-fill ./goblinslayer.png

