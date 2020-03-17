#!/bin/bash
source $THEME
Clock() {
	DATETIME=$(date "+%a %b %d, %T")
	echo "$DATETIME"
}
Battery() {
	BATPERC=$(acpi --battery | cut -d, -f2)
	echo $BATPERC
}
network() {
	timeout 1 ping -c 1 8.8.8.8 >/dev/null 2>&1 &&
	/usr/bin/printf  "\ue0f0" || /usr/bin/printf "X"
	#/usr/bin/printf  "\ue0f0" || /usr/bin/printf "X"
}
anetwork() {
	# using iwconfig makes it not fucking	 spray pings everywhere 
	# SSID = $(sudo iwconfig wlp3s0 | grep ESSID: | cut -d: -f2)
	[[ -z $(sudo iwconfig wlp3s0 | grep ESSID: | cut -d: -f2) ]] && /usr/bin/printf "X" || /usr/bin/printf  "\ue0f0"
	#/usr/bin/printf  "\ue0f0" || /usr/bin/printf "X"
}
bnetwork() {
	[[ -z $(ip a show wlp3s0 | grep inet -m 1 | awk '{print $2}') ]] && /usr/bin/printf "X" || /usr/bin/printf  "\ue0f0"
}
volume() {
	volume=$(amixer -c 1 get Master | awk '/Mono: Playback/ {print $4}' | tr -d '[]%,')
	if [ "$(amixer -c 1 get Master | grep -c off)" -eq "0" ]
	then
		# Makes sure the length is the same regardless if volume is at 100 
		if [ ${#volume} -lt 3 ]; then
			echo $volume" "
		else
			echo $volume
		fi
	else
		echo MM
		#/usr/bin/printf "\ue202"
	fi
	#\ue202 is a mute symbol
}
Heat() {
	HEAT=$(acpi -t | cut -d, -f2 | cut -c 1-5)
	echo $HEAT
}
color() {
	TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
	if [ $TEMP -lt 50000 ]
	then
		echo "#5aff25"
	elif [ $TEMP -gt 50000 ]
	then
 		echo "#ffe425"
	elif [ $TEMP -gt 70000 ]
	then
		echo "#ff2121"
	fi
}
charge() {
	CHARGING=$(acpi --ac | cut -c12-18)
	if [ $CHARGING = "on-line" ]
	then
		OUT=$lemoncharge
	elif [ $CHARGING = "off-lin" ]
	then
		OUT=$lemontext
	fi
	echo "$OUT"
}
textcolor(){
	echo $lemontext
}
titlecolor(){
	echo $lemontitle
}
alertcolor(){
	echo $lemonalert
}
leftbar(){
	while true; do
		#	echo -e "\ue044" %{c} %{F$(titlecolor)}NET: %{F$(textcolor)}$(network)    %{F$(titlecolor)}CLK: %{F$(textcolor)}$(Clock)    %{F$(titlecolor)}VOL: %{F$(textcolor)}$(volume)    %{F$(titlecolor)}HEAT: %{F$(textcolor)}$(Heat)    %{F$(titlecolor)}BAT: %{F$(charge)}$(Battery)"
		#	/usr/bin/printf "\ue00b test" 
		#/usr/bin/printf
		echo -e "%{c} %{F$(titlecolor)}NET: %{F$(textcolor)}$(bnetwork)  %{F$(titlecolor)}VOL: %{F$(textcolor)}$(volume)  %{F$(titlecolor)}HEAT: %{F$(textcolor)}$(Heat)  %{F$(titlecolor)}BAT: %{F$(charge)}$(Battery)"
		sleep 1
	done
}
rightbar(){
	while true; do
		echo "%{c} %{F$(titlecolor)}CLK: %{F$(textcolor)}$(Clock)"
		sleep 1
	done
}
alertbar(){
	on=0
	while true; do
		#internal battery
		BATPERC1=$(acpi --battery | cut -d, -f2 | grep -m 1 % | cut -d '%' -f1 | tr -d [:space:])
		#external battery
		BATPERC2=$(acpi --battery | cut -d, -f2 | grep -m 2 % | tail -n1 | cut -d '%' -f1 | tr -d [:space:])
		TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
		ALERTS=""
		
		if [ $BATPERC1 -lt 25 ]
		then
			ALERTS="$ALERTS INT-BAT-LOW"
		fi

		if [ $BATPERC2 -lt 25 ]
		then
			ALERTS="$ALERTS EXT-BAT-LOW"
		fi

		if [ $TEMP -gt 75000 ]
		then
			ALERTS="$ALERTS CPU-HOT"
		fi

		if [ -z "$ALERTS" ]
		then
			echo ""
		else 
			
			if [ $on -eq 1 ]
			then 
				on=0
				echo -e "%{c} %{F$(alertcolor)}\ue1aa$ALERTS \ue1ac" 
			else
				on=1
				echo ""
			fi
		fi
		sleep 1
	done
}



leftbar | lemonbar -g 320x20+5+5 -B $lemonback \
-p -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' \
-f '-ctrld-fixed-medium-r-normal--13-80-96-96-c-80-iso10646-1' & \
#-f 'sans-serif:size=9' 



alertbar | lemonbar -g 310x20+500+5 \
-p -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' \
-f '-ctrld-fixed-medium-r-normal--13-80-96-96-c-80-iso10646-1' &
 


rightbar | lemonbar -g 200x20+1161+5 -B $lemonback \
-p -f '-wuncon-siji-medium-r-normal--10-100-75-75-c-80-iso10646-1' \
-f '-ctrld-fixed-medium-r-normal--13-80-96-96-c-80-iso10646-1'
#-f 'sans-serif:size=9'

#fonts
#ctrld(triedandtrue)
#-ctrld-fixed-medium-r-normal--13-80-96-96-c-80-iso10646-1
