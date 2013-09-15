#!/bin/zsh

export BROWSER=firefox
export TERMINAL=urxvt
export LANG=fr_FR.utf8
export XDG_MENU_PREFIX=lxde-
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ibus-daemon -drx
urxvtd -o -f -q
exec i3
exec i3 -V >> ~/.i3/i3log 2>&1
