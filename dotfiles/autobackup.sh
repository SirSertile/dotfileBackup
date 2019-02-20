#!/bin/bash
echo "Initializing Backup . . . "

DIRNAME="System Backup for "$(hostname)" on "$( date "+%b %d, %Y %H:%M:%S")
echo $DIRNAME

# CUT UP ARGUMENTS INTO A LIST

# STEP 1 RSYNC STUFF
if [ -z "$1" ]
	then
	ls
	echo "Which directory would you like to back up?"
	read directory
	sudo rsync -aH "$directory" ./"$DIRNAME"
else
	sudo rsync -aH $1 ./"$DIRNAME"
fi 
# STEP 2 PUSH TO GOOGLE DRIVE
drive push -hidden -no-prompt ./"$DIRNAME" 

# STEP 3 DELETE STUFF FROM FOLDER
sudo rm -r ./"$DIRNAME"

echo "Backup Finished"
