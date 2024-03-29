#!/bin/sh
# export MOZ_PLUGIN_PATH="~/usr/lib/flashplayer/"

# If starrtx is giving grief:
# - Disable auto-start: ~/.zlogin
# - Disable atuo-tty login: /etc/systemd/system/getty@tty1.service.d/autologin.conf
# - Check xorg-logs: ~/.local/share/xorg/Xorg.0.log

# BUG with something regarding imagemagick7's library libmagick6.
# - imagemagik's "display <image>" works.
# - opening images (e.g. png's) in emacs crashes emacs.
# Can be fixed by:
# a. export MAGICK_OCL_DEVICE=OFF
# b. or pacman -Rsc ocl-icd
# c. or build imagemagick with the option --disable-opencl
# ref:
# https://www.reddit.com/r/emacs/comments/8rqu4d/emacs_crashes_when_viewing_pdfs/
# https://debbugs.gnu.org/cgi/bugreport.cgi?bug=31771
# https://bugs.archlinux.org/task/47864

export MAGICK_OCL_DEVICE=OFF

# if on work-Dell, scale up retardedly small screen:
if [ $(hostname) == "dell" ]; then
    # doesn't work anymore after update & recompile of stumpwm
    # xrandr --output eDP-1 --scale 0.5x0.5 --output HDMI-1 --auto --right-of eDP-1
    xrandr --output eDP-1 --scale 0.4x0.4 --output DP-3 --scale 0.5x0.5 --right-of eDP-1
    # xrandr -s "1600x900" # --dpi 100
fi

# add executable path
if [ -f /etc/SuSE-release ]; then
    export PATH=$HOME/bin:$HOME/usr/bin:$HOME/usr/local/bin:/usr/bin:/usr/local/bin:/bin:/usr/games:/usr/X11R6/bin
else
    export PATH=$HOME/bin:$PATH
fi

# (nodeadkeys = only press once for ~ ^)
if [ -f /etc/arch-release ]; then
    #or X11 will give warning:
    #setxkbmap -option compose:ralt

    ## setxkbmap se nodeadkeys &
    setxkbmap se &
fi

# XSET OPTIONS.
# use "xset -q" to see values.
xset -b &                          #Turn off beeps:
xset +fp /usr/share/fonts/local &  #\
xset +fp ~/.fonts &                # To get fonts in X11-apps
xset fp rehash &                   #/
# #turn off screen blanking & turn on energy star features
# xset s off
# xset +dpms                 # enabled by default I think
xset dpms 0 0 600            # turn off monitor after 5 min.
# xset r rate 240 120        # until repeat in millisec begins / hz-repeat rate then

# Don't need xscreensaver if using xset +dpms
if [ -f /usr/bin/xscreensaver ]; then
    # Kill any running xscreensaver. Then start anew.
    xscreensaver-command -exit; killall xscreensaver 2>/dev/null; xscreensaver -no-splash &
else
    # for locking screen (e.g. work place policy requires it)
    # (much smaller than xscreensaver)
    xautolock -time 10 -locker slock &
fi
xbacklight -set 50         # reduce screen brightness by 50%

# reduce blue light from monitor, especially during evening
# redshift &

# check if we have music player daemon
if [ -f /usr/bin/mpd ]; then
    # MPD daemon start (if no other user instance exists)
    [ ! -s ~/.mpd/mpd.pid ] && mpd
fi


# # När jag tittar på film:
# xset -dpms; xset s off

#Set cursor theme:
xsetroot -cursor_name left_ptr &

# Hide cursor if inactive (can cause trouble in OpenTTD, virtual windows, DosBOX):
# if [ -f /usr/bin/unclutter ]; then
#     unclutter -idle 2 -jitter 1 -root&
# fi

xrdb -load ~/.Xresources &
xmodmap $HOME/.Xmodmap

# använder inte för monterar med fel iso-encoding på arch.
# if [ -f /usr/bin/devmon ]; then
#     devmon &
# fi

#start some useful stuff:
#emacs --daemon &

#xcompmgr &

if [ -f /usr/bin/autocutsel ]; then
    autocutsel -fork &
    autocutsel -selection PRIMARY -fork &
fi

#parcellite &

if [ -f /etc/SuSE-release ]; then
    #DEFAULT_SESSION=/home/b2/karlf/usr/bin/stumpwm
    DEFAULT_SESSION=stumpwm
else
#   DEFAULT_SESSION=startfluxbox
    # DEFAULT_SESSION=ck-launch-session stumpwm
    DEFAULT_SESSION=stumpwm
fi

DESKTOP_BACKGROUND=~/.fluxbox/backgrounds/suede.jpg
#DESKTOP_BACKGROUND=~/.fluxbox/backgrounds/tiles/dark_tile.jpg

xsetroot -solid '#333333' &

if [ -f $DESKTOP_BACKGROUND ]; then
#   feh --bg-tile DESKTOP_BACKGROUND &
    feh --bg-scale $DESKTOP_BACKGROUND &
else
    xsetroot -solid black &
fi


# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# clipboard manager using dmenu. After install do:
#  systemctl --user enable clipmenud.service
# Note: must start _after_ xserver, sourced from: /etc/X11/xinit/xinitrc.d
(sleep 60; clipmenud) &


# Source: http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample

case $1 in
#lägg till: xmonad,
    awesome)
        exec awesome
        ;;
    blackbox)
        exec blackbox
        ;;
    compiz)
        exec compiz-manager
        ;;
    dswm)
        #deep space windowmanager
        exec dswm
        ;;
    dwm)
        # while true; do
        #     xsetroot -name "$( date +"%F %R" )"
        #     sleep 1m    # Update time every minute
        # done &

        conky -c ~/conky-dwm | while read -r; do xsetroot -name "$REPLY"; done &

        feh --bg-tile .fluxbox/backgrounds/tiles/dark_tile.jpg
        urxvt&

#       exec dwm
        exec ~/.skript/dwm_inf.sh

        ;;
    enlightenment)
        exec enlightenment_start
        ;;
    fluxbox)
        exec startfluxbox
        ;;
    fvwm2)
        exec fvwm2
        ;;
    gnome)
        exec gnome-session
        ;;
    icewm)
        icewmbg &
        icewmtray &
        exec icewm
        ;;
    ion)
        exec ion
        ;;
    jwm)
        exec jwm
        ;;
    kde)
        exec startkde
        ;;
    lxde)
        exec startlxde
        ;;
    musca)
        exec musca
        ;;
    openbox)
        exec openbox-session
        ;;
    ratpoison)
        exec ratpoison
        ;;
    scrotwm)
        feh --bg-scale ~/.fluxbox/backgrounds/krets.png
        exec scrotwm
        ;;
    stumpwm)
        exec stumpwm
        ;;
    wmaker)
        exec wmaker
        ;;
    xfce4)
        exec startxfce4
        ;;
    xmonad)
        #exec xmonad
        ;;
    *)
        exec $DEFAULT_SESSION
        ;;
esac
