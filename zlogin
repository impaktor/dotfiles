# Testing autostart of startx for zsh.
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
