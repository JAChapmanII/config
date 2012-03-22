#!/bin/bash

if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[[ -x "$f" ]] && . "$f"
	done
	unset f
fi

setxkbmap dvorak
setxkbmap -option caps:super

xset m 2.5 7
xset r rate 160 80

numlockx

HOST="${HOST-$HOSTNAME}"
HOST="${HOST-$(hostname)}"

case $HOST in
	Ratushnyak)
		xrandr --output DVI-I-1 --mode 2560x1600 \
			--output DVI-I-2 --mode 1600x1200 --rotate left --left-of DVI-I-1 ;;
	*)
		echo "No screen adjustments made" ;;
esac

if [[ -f "${XDG_CONFIG_HOME}/fehbg" ]]; then
	eval $(cat "${XDG_CONFIG_HOME}/fehbg")
fi

export XSESSION="${1-xmonad}"
case $XSESSION in
	[Xx]*) exec ck-launch-session xmonad   ;;
	[Kk]*) exec ck-launch-session startkde ;;
	[Ii]*) exec ck-launch-session i3       ;;
esac

