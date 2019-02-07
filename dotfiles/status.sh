#!/bin/sh
#prints a bunch of stats on my computer for when I login

#internal battery
BATPERC1=$(acpi --battery | cut -d, -f2 | grep -m 1 % | cut -d '%' -f1 | tr -d [:space:])
#external battery
BATPERC2=$(acpi --battery | cut -d, -f2 | grep -m 2 % | tail -n1 | cut -d '%' -f1 | tr -d [:space:])
#making sure batperc is the same length (2 characters [i.e 05 instead of 5])
if [ $BATPERC1 -lt 10 ]
	then
	BATPERC1=00$BATPERC1
fi
if [ $BATPERC1 -lt 100 ]
	then
	BATPERC1=0$BATPERC1
fi
if [ $BATPERC2 -lt 10 ]
	then
	BATPERC2=00$BATPERC2
fi
if [ $BATPERC2 -lt 100 ]
	then
	BATPERC2=0$BATPERC2
fi

DATE=$(date "+%a %b %d")
TIME=$(date "+%T")



QUOTE=$(shuf -n 1 quotes)

#echo the fancy bar (39 chars long)
echo
echo "            " STATUS-UPDATE
echo "                   "\|
echo \| DATE: $DATE \| INT-BAT: $BATPERC1%  \|
echo \| TIME: $TIME " " \| EXT-BAT: $BATPERC2% \| 
echo 
#echo some inspirational quote 
echo QUOTE-OF-THE-DAY
echo
echo $QUOTE"\n"
