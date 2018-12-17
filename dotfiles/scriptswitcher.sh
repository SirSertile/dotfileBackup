#!/bin/bash
#defines lists for rofi
list=("Weather" "Calendar" "Games")
calendar=("All" "School" "Personal" "Work")
#function takes a list and displays rofi with all the stuff in the lists
function disprofi {
	args=($(echo "$@" | tr ' ' '\n'))
	main=''
	for index in ${!args[*]}
	do
		main="$main${args[$index]}\n"
	done
	input="$(echo -e $main | rofi -dmenu -lines 5)"
	echo $input
}

#scrapes contents of a dir with ls
function scrapedir {
	echo $(ls $HOME/$1)
}

#main switching statement
bashcommand=""
case $(disprofi ${list[*]}) in
#WEATHER
"${list[0]}")
	command="curl wttr.in/?m;read"
	;;
#CALENDAR
"${list[1]}")
	case $(disprofi ${calendar[*]}) in
		#ALL
		${calendar[0]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'Class of 2022 Events' --calendar 'LCDI shifts' --calendar 'rezdevhead@gmail.com' --calendar 'david.serate@mymail.champlain.edu' --calendar 'Champlain Fall 2018 Semester'"
		;;
		#WORK
		${calendar[1]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'LCDI shifts'"
		;;
		#SCHOOL
		${calendar[2]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'Class of 2022 Events' --calendar 'LCDI shifts' --calendar 'david.serate@mymail.champlain.edu' --calendar 'Champlain Fall 2018 Semester'"
		;;
		#PERSONAL
		${calendar[3]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'rezdevhead@gmail.com'"
		;;
	esac
	command="$command;read"
	;;
#GAMES
"${list[2]}")
	gamedir="Documents/games/flash"
	gamelist=($(scrapedir $gamedir))
	game=$(disprofi ${gamelist[*]})
	if [ "$game" != "" ]
	then
		bashcommand="cd $HOME/$gamedir; flashplayer $game"
	fi
;;
*)
	command=""
	;;
esac

inittag="$(herbstclient attr tags.focus.name)"
active="#002cff"
transparent="#212121"
normal="3a3a3a"
if [ "$bashcommand" == "" ]
then
	herbstclient add EXTRA
	herbstclient use EXTRA
	xterm -e "$command"
	herbstclient close_or_remove
	herbstclient use $inittag
	herbstclient merge_tag EXTRA $inittag
else
	herbstclient add EXTRA
	herbstclient use EXTRA
	bash -c "$bashcommand"
	herbstclient close_or_remove
	herbstclient use $inittag
	herbstclient merge_tag EXTRA $inittag
fi