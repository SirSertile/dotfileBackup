#!/bash/sh
#linking of files
rm -r dotfiles
mkdir dotfiles
ln -s $HOME/.xinitrc dotfiles/.xinitrc
ln -s $HOME/.config/herbstluftwm/autostart dotfiles/autostart
ln -s $HOME/.config/lemonbar.sh dotfiles/lemonbar.sh
ln -s $HOME/.config/scriptswitcher.sh dotfiles/scriptswitcher.sh
ln -s $HOME/XTerm dotfiles/XTerm
ln -s $HOME/.Xresources dotfiles/.Xresources
