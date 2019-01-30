#!/bin/bash
#defines lists for rofi
list=("Weather" "Calendar" "Bookmarks" "Games")
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
		${calendar[2]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'LCDI shifts'"
		;;
		#SCHOOL
		${calendar[1]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'Class of 2022 Events' --calendar 'LCDI shifts' --calendar 'david.serate@mymail.champlain.edu' --calendar 'Champlain Fall 2018'"
		;;
		#PERSONAL
		${calendar[3]})
			command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'rezdevhead@gmail.com'"
		;;
	esac
	command="$command;read"
	;;
"${list[2]}")
	#handles bookmarks
	urls=()
	names=()
	#pulls the text from the quickmarks file
	quickmarks="$HOME/.config/qutebrowser/quickmarks"
	linecount=$(wc -l < $quickmarks)
	#iterates through lines 
	for i in $(seq 0 $linecount)
	do
		linetext=($(awk 'NR=="'"$i"'"' $quickmarks))
		url=${linetext[-1]}
		urls+=($url)
		#fill up the name and URL lists
		for j in ${!linetext[*]}
		do
			if [ "${linetext[$j]}" == "$url" ]
			then
				#if its the url exit the loop
				break 
			else 
				if [ "$j" == "0" ]
				then
					#don't have a space on the first line
					name+="${linetext[$j]}"
				else
					#this underscore makes it not FUCKING have a delimiter and be all fucky
					name+="_${linetext[$j]}"
				fi
			fi
		done
		names+=($name)
		name=''
	done
	inputvalue=$(disprofi ${names[*]})
	#take inputvalue and go from name > URL and THEN go URL > qutebrowser
	for i in ${!names[*]}
	do
		if [ "$inputvalue" == "${names[$i]}" ]
		then
			qutebrowser ${urls[$i]} --target window
		fi
	done
;;
#GAMES
"${list[3]}")
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
herbstclient add EXTRA
herbstclient use EXTRA
if [ "$bashcommand" == "" ]
then
	xterm -e "$command"
else
	bash -c "$bashcommand"
fi
herbstclient close_or_remove
herbstclient use $inittag
herbstclient merge_tag EXTRA $inittag