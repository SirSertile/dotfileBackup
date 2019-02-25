#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
#. /etc/X11/Xsession

xset +fp /home/bluesteelblade/.fonts &
xset +fp /home/bluesteelblade/.fonts/bitmap/ctrld-font &
#xset +fp /home/bluesteelblade/.fonts/bitmap &
xset fp rehash &
#fc-cache -fv &

~/.fehbg &

compton --config .config/compton/compton.conf &

#./lemonbar.sh | lemonbar -p -d -B#5c5c5c -g 600x20+400+5 &

#sudo mount /dev/sda2/ home/bluesteelblade/Documents/Windows\ Documents/

#rofi.color-normal: #3A3A3A, #212121, #3a3a3a, #3a3a3a, #002cff &
#rofi.color-window: #3a3a3a, #3a3a3a, #212121 &
#rofi.color-active: #3a3a3a, #3a3a3a, #212121 &
#rofi.color-urgent: #3a3a3a, #3a3a3a, #212121 &
#sleep 2 &

# KEEP LAST 2 LINES BUTTING UP AGAINST EACH OTHER
export THEME="$HOME/.config/customs/colors.sh"
exec herbstluftwm --locked
