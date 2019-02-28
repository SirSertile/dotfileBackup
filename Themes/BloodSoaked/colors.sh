#!/usr/bin/env bash
# "BLOOD SOAKED THEME"
# CONSOLE / XTERM PALETTE

#export THEME=$(realpath $0)
#echo $THEME
#echo $(export -p)

background="#1C1C1C"
foreground="#474747"
black="#242424"
red="#f28a98"
green="#a1f28a"
yellow="#eaf28a"
blue="#4a63ed"
violet="#e68af2"
ltblue="#8aedf2"
white="#e0e0e0"

# CUSTOM NAMED COLORS

midnight="#212121"
darkestnight="#1C1C1C"
blackout="#0D0D0D"
steelgrey="#3a3a3a"
brightsteel="#a3a3a3"
alertorange="#ffa447"
alertgreen="#05c92f"
alertred="#f28a98"
brightblue="#002cff"
bloodred="#4d0000"

# Herbstluftwm config

# general colors

background_color=$bloodred
normal_color=$steelgrey
urgent_color=$alertorange

# active colors

active_color=$bloodred
active_inner_color=$darkestnight
active_outer_color=$bloodred
floating_outer_color=$darkestnight

# frame colors

frame_border_active_color=$bloodred
frame_border_normal_color=$midnight
frame_border_inner_color=$darkestnight

# frame background colors

frame_bg_normal_color=$midnight
frame_bg_active_color=$bloodred
inner_color=''

# HERBST NERD NUMBERS 

frame_border_width="11"
frame_border_inner_width="9"
frame_bg_transparent="10"
frame_transparent_width="0"
frame_gap="5"
frame_active_opacity="75"
frame_normal_opacity="75"
inner_width="0"
border_width="0"
floating_border_width="1"
floating_outer_width="1"

# Lemonbar config

lemonalert=$alertred
lemonback=$midnight
lemontext=$bloodred
lemontitle=$blackout
lemoncharge=$alertgreen

#feh  --bg-fill '/home/bluesteelblade/Pictures/Wallpapers/goblinslayer.png' 
