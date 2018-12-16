#curl wttr.in; read
list=("Weather" "Calendar" "Calendar(all)" "Calendar(school)" "Calendar(personal)" "Calendar(work)")
calendar=("All" "School" "Personal" "Work")
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

case $(disprofi ${list[*]}) in
"${list[0]}")
	command="curl wttr.in/?m"
	;;
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

xterm -e "$command ; read"

herbstclient close_or_remove
herbstclient use $inittag
herbstclient merge_tag EXTRA $inittag