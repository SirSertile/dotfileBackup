#!/bash/sh
#copy files to the directory
inittag="$(herbstclient attr tags.focus.name)"
herbstclient add BACKUP
herbstclient use BACKUP
cd $HOME/DotfileBackup
#linking of files
#copy the current dotfiles to the current address, then delete them and symlink them? 
cp $HOME/.xinitrc dotfiles/.xinitrc
cp $HOME/.config/herbstluftwm/autostart dotfiles/autostart
cp $HOME/.config/lemonbar.sh dotfiles/lemonbar.sh
cp $HOME/.config/scriptswitcher.sh dotfiles/scriptswitcher.sh
cp $HOME/XTerm dotfiles/XTerm
cp $HOME/.Xresources dotfiles/.Xresources
rm -r dotfiles
mkdir dotfiles

#USER INTERFACE HERE FOR GITHUB LOGIN

xterm -e "cd $HOME/Documents/DotfileBackup;\
git init; \
git add ./dotfiles; \
git commit -m 'automatically pushed at $(date)';\
git push -u origin master;\
sleep 1"
herbstclient close_or_remove
herbstclient use $inittag
herbstclient merge_tag BACKUP $inittag

#make symlinks for them to keep around for editability 
ln -s $HOME/.xinitrc dotfiles/.xinitrc
ln -s $HOME/.config/herbstluftwm/autostart dotfiles/autostart
ln -s $HOME/.config/lemonbar.sh dotfiles/lemonbar.sh
ln -s $HOME/.config/scriptswitcher.sh dotfiles/scriptswitcher.sh
ln -s $HOME/XTerm dotfiles/XTerm
ln -s $HOME/.Xresources dotfiles/.Xresources