#!/bash/sh
#copy files to the directory
inittag="$(herbstclient attr tags.focus.name)"
herbstclient add BACKUP
herbstclient use BACKUP
cd $HOME/DotfileBackup
xterm -e "cd $HOME/Documents/DotfileBackup;\
git init; \
git add ./dotfiles; \
git commit -m 'automatically pushed at $(date)';\
git push -u origin master; read"
herbstclient close_or_remove
herbstclient use $inittag
herbstclient merge_tag BACKUP $inittag
