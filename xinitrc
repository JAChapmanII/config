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

session="${1-xmonad}"
case $session in
	[Xx]*) exec ck-launch-session xmonad   ;;
	[Kk]*) exec ck-launch-session startkde ;;
esac

