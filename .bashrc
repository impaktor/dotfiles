# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Functions: check for a separate function file, and if we find one
# source it.
if [[ -f ~/.bash_functions ]]; then
    . ~/.bash_functions
fi

# Check for an interactive session
[ -z "$PS1" ] && return

#load in shell-functions & aliases common to both zsh and bash:
if [ -f ~/.shell_common ]; then
    . ~/.shell_common
fi


#Default:
#PS1='[\u@\h \W]\$ '

#auto complete after man and sudo:
complete -cf sudo
complete -cf man

#Global varialbles:
#------------------
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTFILESIZE=5000
export HISTSIZE=10000

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

#don't need "cd" to enter directories, since Bash 4.0:
shopt -s autocd

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#Alias:
#------
# läst in från extern alias-fil
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# add executable paths
export PATH=$PATH:$HOME/usr/bin:$HOME/usr/local/bin

#Prompt:
#-------
#  Legend:
   # \a         an ASCII bell character (07)
   # \d         the date in "Weekday Month Date" format (e.g., "Tue May 26")
   # \D{format} the format is passed to strftime(3) and the result
   #            is inserted into the prompt string an empty format
   #            results in a locale-specific time representation.
   #            The braces are required
   # \e         an ASCII escape character (033)
   # \h         the hostname up to the first `.'
   # \H         the hostname
   # \j         the number of jobs currently managed by the shell
   # \l         the basename of the shell's terminal device name
   # \n         newline
   # \r         carriage return
   # \s         the name of the shell, the basename of $0 (the portion following
   #            the final slash)
   # \t         the current time in 24-hour HH:MM:SS format
   # \T         the current time in 12-hour HH:MM:SS format
   # \@         the current time in 12-hour am/pm format
   # \A         the current time in 24-hour HH:MM format
   # \u         the username of the current user
   # \v         the version of bash (e.g., 2.00)
   # \V         the release of bash, version + patch level (e.g., 2.00.0)
   # \w         the current working directory, with $HOME abbreviated with a tilde
   # \W         the basename of the current working directory, with $HOME
   #            abbreviated with a tilde
   # \!         the history number of this command
   # \#         the command number of this command
   # \$         if the effective UID is 0, a #, otherwise a $
   # \nnn       the character corresponding to the octal number nnn
   # \\         a backslash
   # \[         begin a sequence of non-printing characters, which could be used
   #            to embed a terminal control sequence into the prompt
   # \]         end a sequence of non-printing characters


if [ -f /etc/debian_version ]; then

# set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

# set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
    force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	    color_prompt=yes
        else
	    color_prompt=
        fi
    fi

# Om en terminal öppnas som root blir prompten röd.
    user_color() {
        if [ "$UID" -eq "0" ]; then
            echo 31
        elif [ "$UID" -eq "1000" ]; then
            echo 33
        fi
    }


    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;$(user_color)m\]@\h\:\[\033[00;33m\]\w\[\033[00;37m\]\$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

#Två rader, snygg
#export PS1="[\e[31m\$(pwd)\e[0m :: \e[32m\@\e[0m :: \e[33m\l\e[0m]\n[\e[32m\u\e[0m@\e[34m\H\e[0m] \$ "
fi

if [ -f /etc/arch-release ]; then

 ##################################################
 # Fancy PWD display function
 ##################################################
 # The home directory (HOME) is replaced with a ~
 # The last pwdmaxlen characters of the PWD are displayed
 # Leading partial directory names are striped off
 # /home/me/stuff          -> ~/stuff               if USER=me
 # /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
 ##################################################
    bash_prompt_command() {
     # How many characters of the $PWD should be kept
        local pwdmaxlen=25
     # Indicate that there has been dir truncation
        local trunc_symbol=".."
        local dir=${PWD##*/}
        pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
        NEW_PWD=${PWD/#$HOME/\~}
        local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
        if [ ${pwdoffset} -gt "0" ]
        then
            NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
            NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
        fi
    }

    bash_prompt() {
        case $TERM in
            xterm*|rxvt*)
                local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
                ;;
            *)
                local TITLEBAR=""
                ;;
        esac
        local NONE="\[\033[0m\]"    # unsets color to term's fg color

     # regular colors
        local K="\[\033[0;30m\]"    # black
        local R="\[\033[0;31m\]"    # red
        local G="\[\033[0;32m\]"    # green
        local Y="\[\033[0;33m\]"    # yellow
        local B="\[\033[0;34m\]"    # blue
        local M="\[\033[0;35m\]"    # magenta
        local C="\[\033[0;36m\]"    # cyan
        local W="\[\033[0;37m\]"    # white

     # emphasized (bolded) colors
        local EMK="\[\033[1;30m\]"
        local EMR="\[\033[1;31m\]"
        local EMG="\[\033[1;32m\]"
        local EMY="\[\033[1;33m\]"
        local EMB="\[\033[1;34m\]"
        local EMM="\[\033[1;35m\]"
        local EMC="\[\033[1;36m\]"
        local EMW="\[\033[1;37m\]"

     # background colors
        local BGK="\[\033[40m\]"
        local BGR="\[\033[41m\]"
        local BGG="\[\033[42m\]"
        local BGY="\[\033[43m\]"
        local BGB="\[\033[44m\]"
        local BGM="\[\033[45m\]"
        local BGC="\[\033[46m\]"
        local BGW="\[\033[47m\]"

        local UC=$G                 # user's color
        [ $UID -eq "0" ] && UC=$R   # root's color

        PS1="$TITLEBAR ${UC}\u${EMK} ${EMB}\${NEW_PWD} ${UC}\\$ ${NONE}"
     #PS1="$TITLEBAR ${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${UC}\\$ ${NONE}"
     # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
     # extra backslash in front of \$ to make bash colorize the prompt
    }

 # This ensures that the NEW_PWD variable will be updated when you cd somewhere else, and it
 #  sets the PS1 variable, which contains the command prompt.
    PROMPT_COMMAND=bash_prompt_command
    bash_prompt
    unset bash_prompt

 ##################################################
 # Fancy PWD display function  ----  END!
 ##################################################
fi






#dirsize - finds directory sizes and lists them for the current directory
function dirsize () {
    du -shx * .[a-zA-Z0-9_]* 2> /dev/null | \
        egrep '^ *[0-9.]*[MG]' | sort -n > /tmp/list
    egrep '^ *[0-9.]*M' /tmp/list
    egrep '^ *[0-9.]*G' /tmp/list
    rm -rf /tmp/list
}

function  freq (){
    cpufreq=`cat  /proc/cpuinfo  |  grep 'cpu MHz'` echo
    ${cpufreq:31}
}





#-----------------------------------

#netinfo - shows network information for your system
function my_netinfo () {
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip= "fill in IP here...."
    echo "${myip}"
    echo "---------------------------------------------------"
}

#system Info - shows system information for yor system
function my_sysinfo() {
    clear
    num_cpus=`cat /proc/cpuinfo | grep -c "model name"`
    machine_cpu=`cat /proc/cpuinfo | grep -m 1 "model name" | cut -d: -f2`
    machine_mhz=`cat /proc/cpuinfo | grep -m 1 "cpu MHz" | cut -d: -f2`
    machine_cpuinfo=`uname -mp`
    todays_date=`date +"%D %r"`
    machine_uptime=`uptime`
    machine_ram=`cat /proc/meminfo | grep -m 1 "MemTotal:" | cut -d: -f2 |  sed 's/^[ \t]*//'`
    machine_video=`lspci | grep -m 1 "VGA" | cut -d: -f3 |  sed 's/^[ \t]*//'`
    machine_eth_card=`lspci | grep -m 1 "Ethernet" | cut -d: -f3 |  sed 's/^[ \t]*//'`
    machine_audio_controller=`lspci | grep -m 1 "audio" | cut -d: -f3 |  sed 's/^[ \t]*//'`
    arch_damons=`grep "DAEMONS=" /etc/rc.conf `
    last_logins=`last | head`
    eth0info=`ifconfig eth0 | grep "inet addr:" | sed 's/inet addr/Local IP/g' | sed 's/^[ \t]*//;s/[ \t]*$//'`

    echo "ARCH LINUX - Machine Information Script ver .10"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "DATE: $todays_date   MACHINE NAME: $HOSTNAME  "
    echo " "
    echo "Eth0: $eth0info"
    echo "ETHERNET CARD: $machine_eth_card"
    echo "CPU INFO: Qty=$num_cpus $machine_cpuinfo"
    echo "VIDEO CARD: $machine_video"
    echo "AUDIO CONTROLLER: $machine_audio_controller"
    echo "RAM INFO: $machine_ram"
    echo " "
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    route
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "DISK USAGE:"
    df -h
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "UPTIME: $machine_uptime"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
    echo "$arch_damons"
    echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
}

function my_ip(){ # Get IP adresses.
    MY_IP=$(/sbin/ifconfig ppp0 | awk '/inet/ { print $2 } ' | \
        sed -e s/addr://)
    MY_ISP=$(/sbin/ifconfig ppp0 | awk '/P-t-P/ { print $3 } ' | \
        sed -e s/P-t-P://)
}

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }
function pp() { my_ps f | awk '!/awk/ && $0~var' var=${1:-".*"} ; }

function ii(){   # Get current host related info.
    echo -e "\nYou are logged on ${bldred}$HOST"
    echo -e "\nAdditionnal information:$txtrst " ; uname -a
    echo -e "\n${bldred}Users logged on:$txtrst " ; w -h
    echo -e "\n${bldred}Current date :$txtrst " ; date
    echo -e "\n${bldred}Machine stats :$txtrst " ; uptime
    echo -e "\n${bldred}Memory stats :$txtrst " ; free
    my_ip 2>&- ;
    echo -e "\n${bldred}Local IP Address :$txtrst" ; echo ${MY_IP:-"Not connected"}
    echo -e "\n${bldred}ISP Address :$txtrst" ; echo ${MY_ISP:-"Not connected"}
    echo -e "\n${bldred}Open connections :$txtrst "; netstat -pan --inet;
    echo
}

function killps(){                 # Kill by process name.
    local pid pname sig="-TERM"   # Default signal.
    if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
        echo "Usage: killps [-SIGNAL] pattern"
        return;
    fi
    if [ $# = 2 ]; then sig=$1 ; fi
    for pid in $(my_ps| awk '!/awk/ && $0~pat { print $1 }' pat=${!#} ) ; do
        pname=$(my_ps | awk '$1~var { print $5 }' var=$pid )
        if ask "Kill process $pid <$pname> with signal $sig?"
        then kill $sig $pid
        fi
    done
}



#TESTAR LITE TILL:
 alias ff="find ./ -type f | grep -v \.svn | xargs grep -C1 --color=auto"


# if [ "$TERM" = "linux" ]; then
#     echo -en "\e]P0222222" #black
#     echo -en "\e]P8222222" #darkgrey
#     echo -en "\e]P1803232" #darkred
#     echo -en "\e]P9982b2b" #red
#     echo -en "\e]P25b762f" #darkgreen
#     echo -en "\e]PA89b83f" #green
#     echo -en "\e]P3aa9943" #brown
#     echo -en "\e]PBefef60" #yellow
#     echo -en "\e]P4324c80" #darkblue
#     echo -en "\e]PC2b4f98" #blue
#     echo -en "\e]P5706c9a" #darkmagenta
#     echo -en "\e]PD826ab1" #magenta
#     echo -en "\e]P692b19e" #darkcyan
#     echo -en "\e]PEa1cdcd" #cyan
#     echo -en "\e]P7ffffff" #lightgrey
#     echo -en "\e]PFdedede" #white
#     clear #for background artifacting
# fi
