# -*- shell-script -*-

if [ -f /etc/SuSE-release ]; then
    #because zsh in SuSE expands non-unique names!
    # setopt no_global_rcs
    #Och eller kör 'zsh -d' från terminalen.
    export PATH=/nfs/bin:$PATH
fi

export PATH=$HOME/usr/bin:$HOME/usr/local/bin:$HOME/.local/bin:$PATH
export COWPATH=$HOME/usr/src/cow:/usr/share/cowsay/cows:$COWPATH

# #Don't include "/" as a word character. Makes C-w better on paths.
export WORDCHARS="*?_-.[]~=&;export%^(){}<>"

# Man, I hate nefarious programs (Gimp, firefox, etc.) spawning zombie
# folders, as a "feature".
export XDG_DESKTOP_DIR="$HOME/"
export XDG_DOCUMENTS_DIR="$HOME/dokument"
export XDG_DOWNLOAD_DIR="$HOME/"
export XDG_MUSIC_DIR="$HOME/audio/music/"
export XDG_PICTURES_DIR="$HOME/bilder/"
export XDG_VIDEOS_DIR="$HOME/dvd/"

export LC_MESSAGES="en_US.UTF-8"

# http://www.linuxquestions.org/questions/slackware-14/gtk-3-mouse-wheel-doesn%27t-work-on-current-wed-sep-25-a-4175478706/
export GDK_CORE_DEVICE_EVENTS=1
