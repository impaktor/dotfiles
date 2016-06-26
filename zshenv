# -*- shell-script -*-

if [ -f /etc/SuSE-release ]; then
    #because zsh in SuSE expands non-unique names!
    # setopt no_global_rcs
    #Och eller kör 'zsh -d' från terminalen.
    export PATH=/nfs/bin:$PATH
fi

export PATH=$HOME/usr/bin:$HOME/usr/local/bin:$PATH
export COWPATH=$HOME/usr/src/cow:/usr/share/cowsay/cows:$COWPATH

# #Don't include "/" as a word character. Makes C-w better on paths.
export WORDCHARS="*?_-.[]~=&;export%^(){}<>"
