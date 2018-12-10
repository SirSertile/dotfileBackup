#curl wttr.in; read
options="Weather\nCalendar(all)\nCalendar(school)\nCalendar(personal)\nCalendar(work)"
input="$(echo -e $options | rofi -dmenu -lines 5)"
inittag="$(herbstclient attr tags.focus.name)"
active="#002cff"
transparent="#212121"
normal="3a3a3a"
herbstclient add EXTRA
herbstclient use EXTRA
case $input in
"Weather")
	command="curl wttr.in/?m"
	;;
"Calendar(all)")
	command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'Class of 2022 Events' --calendar 'LCDI shifts' --calendar 'rezdevhead@gmail.com' --calendar 'david.serate@mymail.champlain.edu' --calendar 'Champlain Fall 2018 Semester'"
	;;
"Calendar(work)")
	command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'LCDI shifts'"
	;;
"Calendar(school)")
	command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'Class of 2022 Events' --calendar 'LCDI shifts' --calendar 'david.serate@mymail.champlain.edu' --calendar 'Champlain Fall 2018 Semester'"
	;;
"Calendar(personal)")
	command="gcalcli calw 1 --configFolder /home/bluesteelblade/.config/gcalcli/ --calendar 'rezdevhead@gmail.com'"
	;;
*)
	command=$input
	;;
esac
xterm -e "$command ; read"

herbstclient close_or_remove
herbstclient use $inittag
herbstclient merge_tag EXTRA $inittag