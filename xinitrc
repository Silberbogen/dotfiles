#!/bin/sh

# dbus-start
#if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; 
#then
#       eval "$(dbus-launch --sh-syntax --exit-with-session)"
#fi

#source /etc/X11/xinit/xinitrc.d/30-dbus
#export MEMCPU='memcpu'

# Dropbox entschlüsseln
echo "KENNWORT" | encfs -S ~/Dropbox/Encoded ~/DropBox_Decoded

DEFAULT_SESSION=awesome
synclient touchpadoff=1 &
setxkbmap -layout de nodeadkeys &
#wicd-gtk &
#$XDG_CONFIG_HOME/wmfs/autostart.sh &
#(sleep 3s && xfce4-power-manager) &
#(sleep 45s && dropbox start) &
#unclutter &
# exec ck-launch-session dbus-launch irgendwas

case $1 in
awesome)
	volumeicon &
	xfce4-power-manager &
#	conky &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
        wicd-gtk &
        xfce4-notes &
#        guake &
	exec ck-launch-session dbus-launch awesome
	;;
dwm)
	conky -c .conkyrc.dwm | while read -r; do xsetroot -name "$REPLY"; done &
	nitrogen --restore &
	xfce4-power-manager &
	unclutter &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch dwm
	;;
e17)
        (sleep 45s && dropboxd start) &
        wicd-gtk &
        xscreensaver -no-splash &
        guake &
        xfce4-notes &
	exec ck-launch-session dbus-launch enlightenment_start
	;;
fluxbox)
	volumeicon &
	xfce4-power-manager &
	conky -q -c .conkyrcfluxbox &
	unclutter &
	(sleep 3s && mmaker -vf Fluxbox) &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch startfluxbox
	;;
fvwm)
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch fvwm
	;;
gnome)
	exec ck-launch-session dbus-launch gnome-session
	;;
i3)
	xfce4-power-manager &
        xscreensaver -no-splash &
	(sleep 1s && nitrogen --restore) &
        (sleep 45s && dropboxd start) &
#        guake &
	exec ck-launch-session dbus-launch i3
	;;
lxde)
	exec ck-launch-session dbus-launch startlxde
	;;
musca)
	nitrogen --restore &
	xfce4-power-manager &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch musca
	;;
openbox)
	xfce4-power-manager &
	(sleep 1s && nitrogen --restore) &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch openbox-session
	;;
pekwm)
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch pekwm
	;;
ratpoison)
	#xmodmap .xmodmaprc &
	nitrogen --restore &
        xscreensaver -no-splash &
	(sleep 1s && nitrogen --restore) &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch ratpoison
	;;
scrotwm)
	#conky -c .conkydwm | while read -r; do xsetroot -name "$REPLY"; done &
	(sleep 1s && nitrogen --restore) &
	xfce4-power-manager &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch scrotwm
	;;
startkde)
	exec ck-launch-session dbus-launch startkde
	;;
wmfs)
	volumeicon &
	xfce4-power-manager &
        xscreensaver -no-splash &
	#(sleep 1s && nitrogen --restore) &
	conky | while read -r; do wmfs -s -name "$REPLY"; done &
	#(sleep 3s && unclutter) &
        (sleep 45s && dropboxd start) &
	wicd-gtk &
        xfce4-notes &
#        guake &
        exec ck-launch-session dbus-launch wmfs
	;;
wmii)
	conky &
	volumeicon &
	xfce4-power-manager &
        xscreensaver -no-splash &
	(sleep 1s && nitrogen --restore) &
        (sleep 45s && dropboxd start) &
        wicd-gtk &
#        guake &
	exec ck-launch-session dbus-launch wmii
	;;
xfce)
        guake &
	exec ck-launch-session dbus-launch startxfce4
	;;
xmonad)
	xsetroot -cursor_name left_ptr &
	volumeicon &
	xfce4-power-manager &
        xscreensaver -no-splash &
        (sleep 45s && dropbox start) &
	exec ck-launch-session dbus-launch xmonad
	;;
*)
	volumeicon &
	xfce4-power-manager &
	#(sleep 1s && nitrogen --restore) &
	# conky | while read -r; do wmfs -s -name "$REPLY"; done &
	#(sleep 3s && unclutter) &
        xscreensaver -no-splash &
        (sleep 45s && dropboxd start) &
	exec ck-launch-session dbus-launch $DEFAULT_SESSION
	;;
esac
