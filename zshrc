# -*- shell-script -*-
#Do: man zshoptions
#run chsh (change login shell) to switch to zsh
#
#resources: http://grml.org/zsh/zsh-lovers.html
# http://www.rayninfo.co.uk/tips/zshtips.html
# http://reasoniamhere.com/2014/01/11/outrageously-useful-tips-to-master-your-z-shell/
#
# * .zshrc    - runs for each new shell(roughly equivalent to .bashrc)
# * .zprofile - runs only for login shells(like .bash_profile)
# * .zlogout  - runs on logout
# * .zshenv   - holds environmental variables

# Also, this is useful reference, command line tools one should know:
# http://kadekillary.work/post/cli-4-ds/
# and on SED:
# http://www.grymoire.com/Unix/Sed.html#uh-61

# TIP:
# press Alt+q in the middle of a command you’re typing. This will clear
# the console prompt and allow you execute another command (like a man
# lookup). Afterwards the things you’ve typed before the Alt+q will
# magically reappear.

# http://www.bash2zsh.com/

# # Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000                  # max events stored in internal histlist
SAVEHIST=50000                  # max events to save in histfile
PAGER='less'

#use Emacs keybindings
bindkey -e

#Doing this, only past commands beginning with the current input would
#have been shown.
bindkey "^[[A" up-line-or-history
bindkey "^[[B" down-line-or-history

# # completion in the middle of a line
# bindkey '^i' expand-or-complete-prefix

# for rxvt
# bindkey "\e[7~" beginning-of-line # Home
# bindkey "\e[8~" end-of-line       # End

bindkey "\e[1~" beginning-of-line    # Home
bindkey "\e[4~" end-of-line          # End
bindkey "\e[3~" delete-char          # Del
bindkey "\e[2~" quoted-insert        # Ins

bindkey "\e[Z"  reverse-menu-complete # Shift+Tab
bindkey '^[[Z' reverse-menu-complete

#Page up/down, search hist, based on what is entered so far
bindkey '^[[5~' history-search-backward
bindkey '^[[6~' history-search-forward

# Kommenterar ut detta 13/4, verkar inte behövas pga export WORDCHARS ovan.
# # useful for path editing — backward-delete-word, but with / as
# # additional delimiter
# backward-delete-to-slash () {
#     local WORDCHARS=${WORDCHARS//\//}
#     zle .backward-delete-word
# }
# zle -N backward-delete-to-slash
# #bindkey '^[w' backward-delete-to-slash

# #let wildcards also match to (hidden) dot-files.
# setopt globdots

# #automatically list choices on ambigous completion
# setopt autolist

# #list jobs in long format by default
setopt long_list_jobs

#don't (auto) nice jobs when sending them to back ground (bg).
unsetopt bgnice

# #add/(remove) a trailing slash instead of space if auto completed
# #parameter is a path.
# unsetopt autoparamslash

#navigate to folders without "cd"
setopt autocd

#all terminals share the same history, rather than have the last shell
#exited replace the histfile.
setopt appendhistory

# #_all_ zsh sessions share the same history files
# setopt share_history
# #write after each command
# setopt inc_append_history

#when saving hist, remove older duplication of more recent comands.
setopt hist_ignore_all_dups

#when saving, ignore older commands that duplicate newer ones.
setopt hist_save_no_dups

#puts timestamps in the history
setopt extended_history

#don't save commands that start with space
setopt hist_ignore_space

#recursive look for file through directories:
# ls somedir/**/Makefile
setopt extendedglob

#If there's no match for wildcard, like ?, then pass as is.
#i.e. don't have to "www.youtube.com/watch=?blabla" in "" any longer.
setopt nonomatch
#else, see:
# <ccxCZ> for youtube-dl the automatic url escaping is handy
# <ccxCZ> autoload -Uz url-quote-magic  [12:26]
# <ccxCZ> zle -N self-insert url-quote-magic


#kind of aggresive, offers to correct when doing
#cp file_copy1.txt file_copy2.txt if latter doesn't exist.
##if so then do: alias mv='nocorrect mv'
#setopt correct_all

#correct mistyped shell commands, but not arguments
#(using tab-completion for these anyways..)
setopt correct

#Have "cd -" [TAB] expand a list of previous paths...
setopt autopushd

#reverse "cd -" with "cd +", so most recent path at top of list.
setopt pushdminus

#...and ignore duplicate paths in list
setopt pushd_ignore_dups

# Omit printing directory stack
# setopt pushdsilent

#don't beep
unsetopt beep

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

#TAB-autocompletion (autoload for speed)
autoload -Uz compinit
compinit

# I'm not using pacman-color anyomre, so commented out.
# #Same completions for pacman-color as for pacman:
# compdef _pacman pacman-color=pacman

#if marker on "f" complete Mafile to Makefile.
setopt complete_in_word

#in completion, recognize exact matches even if ambiguous
#setopt recexact

#make TABx2 show menu of options to select
zstyle ':completion:*' menu select=2

#display message when completion list is bigger (terminal) than screen.
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s

#Show where I am (top/bottom/precentage) in the completion list if it's too large for the screen
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s

#make TABx2 show description in cyan just above the list.
zstyle ':completion:*:descriptions' format '%U%F{cyan}%d%f%u'

#have "cd .." [TAB] expand to cd ../, and similar.
zstyle ':completion*' special-dirs ..

# cd directory stack menu (cd -[TAB] gives list previous pwd's)
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

#cd not select parent dir (exclude itself from cd ../ list I think)
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Debian Recommended:
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

#color completoins list like we're using normal "ls"
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#gnuplot completes on *.gnu and *.gp files
compdef '_files -g "*.g{nu,p}"' gnuplot

# #povray completes on *.pov
compdef '_files -g "*.pov"' povray

# completes on *.scm scheme-files
compdef '_files -g "*.csc"' csc

#"make latex" completes on *.tex files
compdef '_files -g "*.tex"' buildlatex.sh


########################################
#I DONT KNOW WHAT THIS IS FOR, BUT MIGHT BE USEFUL:

  # #  http://v3ng34nce.org/dotfiles/zsh/.zsh/completion
  # zstyle ':completion:*:expand:*'        tag-order all-expansions            # insert all expansions for expand completer
  # zstyle ':completion:*:history-words'   list false                          #
  # zstyle ':completion:*:history-words'   menu yes                            # activate menu
  # zstyle ':completion:*:history-words'   remove-all-dups yes                 # ignore duplicate entries
  # zstyle ':completion:*:history-words'   stop yes                            #
  # zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'        # match uppercase from lowercase
  # zstyle ':completion:*:matches'         group 'yes'                         # separate matches into groups
  # zstyle ':completion:*:messages'        format '%d'                         #
  # zstyle ':completion:*:options'         auto-description '%d'               #
  # zstyle ':completion:*:options'         description 'yes'                   # describe options in full


# completions for some progs. not in default completion system
# http://www.strcat.de/dotfiles/dot.zshstyle
# zstyle ':completion:*:*:mpg123:*' file-patterns '*.(mp3|MP3):mp3\ files *(-/):directories'
# zstyle ':completion:*:*:ogg123:*' file-patterns '*.(ogg|OGG):ogg\ files *(-/):directories'


# #Be as verbose as possible:
# #http://www.linux-mag.com/id/1106/
# zstyle ':completion:*' verbose true
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

########################################

# DEBIAN RECOMMENDED
##########################
#describe one-argument commands upon completion
# zstyle ':completion:*' auto-description 'specify: %d'

# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# eval "$(dircolors -b)"

# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

##########################

# typing: file.avi will open file using mpv
alias -s avi=mpv

#load in shell-functions & aliases common to both zsh and bash:
if [ -f ~/.shell_common ]; then
    . ~/.shell_common
fi

#xdvi autocompleatar till dvi-filer. Ej testad.
xdvi() { command xdvi ${*:-*.dvi(om[1])} }

#use menu:
zstyle ':completion:*:*:xdvi:*' menu yes select

#and sort by time:
zstyle ':completion:*:*:xdvi:*' file-sort time



#------------------------------
# Prompt
#------------------------------

setLeftPrompt () {
    # load some modules
    autoload -U colors zsh/terminfo # Used in the colour alias below
    colors
    setopt prompt_subst

    # make some aliases for the colours: (coud use normal escap.seq's too)
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
        eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NO_COLOR="%{$terminfo[sgr0]%}"

    # Check the UID
    if [[ $UID -ge 1000 ]]; then # normal user
        eval PR_USER='${PR_GREEN}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_GREEN}%#${PR_NO_COLOR}'
    elif [[ $UID -eq 0 ]]; then # root
        eval PR_USER='${PR_RED}%n${PR_NO_COLOR}'
        eval PR_USER_OP='${PR_RED}%#${PR_NO_COLOR}'
    fi

    # Check if we are on SSH or not
    if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
        eval PR_HOST='${PR_YELLOW}%M${PR_NO_COLOR}' #SSH
    else
        eval PR_HOST='${PR_GREEN}%M${PR_NO_COLOR}' # no SSH
    fi
    # set the prompt: [username@host][~/path][returncode if != 0]%
    PS1=$'${PR_CYAN}[${PR_USER}${PR_CYAN}@${PR_HOST}${PR_CYAN}][${PR_BLUE}%~${PR_CYAN}]%(?..[${PR_RED}%?${PR_CYAN}])${PR_USER_OP} '
    PS2=$'%_>'

    # #Right hand side prompt shows time:
    # RPROMPT=$'%T'
}

# right prompt sets git info if in git dir.
setRightPrompt () {
    # http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
    setopt prompt_subst
    autoload -Uz vcs_info

    # shows unfinished git actions, like when in merge confilict, etc.
    # zstyle ':vcs_info:*' actionformats \
    #     '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '

    # %F(7) = white
    # %F(6) = cyan
    # %F(5) = magenta
    # %F(4) = blue
    # %F(3) = yellow
    # %F(2) = green
    # %F(1) = red
    # %F(0) = grey

    # enable it for git, and svn (also available: cvs, mercurial, bzr, etc.)
    zstyle ':vcs_info:*' enable git svn

#    eval STATUS="%F{6}[%m%u%c%F{6}]"                             # %m (stash), %u (unstaged), %c (staged)
    eval STATUS="%F{6}%m%u%c%{$reset_color%}"                    # %m (stash), %u (unstaged), %c (staged)
    eval PRG="%F{0}[%s]%{$reset_color%}"                         # %s (git,or svn)
    eval BRANCH="%F{6}[%F{4}%b%F{6}]%{$reset_color%}"            # %b (branch)
    eval REPO_PATH="%F{6}[%F{3}%r%F{7}%S%F{6}]%{$reset_color%}"  # %r (root dir), %S (path rel root)

    zstyle ':vcs_info:*'    formats "${PRG}${BRANCH}%{$reset_color%}"
    zstyle ':vcs_info:git*' formats "${PRG}${BRANCH}${STATUS}%{$reset_color%}"

    # how to show branches in svn, svk, and bzr: "(svn)-[<branch>:<revision>]-"
    zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{5}:%F{3}%r'

    # can slow things down, needed for %c (staged) and %u (unstaged) sequence
    zstyle ':vcs_info:*' check-for-changes true

    # when %c (staged) show a green "S" (instead of uncolored "S")
    zstyle ':vcs_info:*' stagedstr '%F{2}S%F{0}'

    # when %u (unstaged) show a red "U" (instead of uncolored "U")
    zstyle ':vcs_info:*' unstagedstr '%F{1}U%F{9}'

    # or use pre_cmd, see man zshcontrib
    vcs_info_wrapper() {
        vcs_info
        if [ -n "$vcs_info_msg_0_" ]; then
            echo "${vcs_info_msg_0_}%{$reset_color%}$del"
        fi
    }
    RPROMPT=$'$(vcs_info_wrapper)'
}


if [[ ${TERM} == "dumb" ]]; then
    # http://www.emacswiki.org/emacs/TrampMode#toc10
    # switch of the zsh line editor, cause emacs shell and TRAMP
    # doesn’t work with it.
    unsetopt prompt_cr  #eller är det "unsetopt promptcr"?
    unsetopt zle
    unsetopt prompt_subst
    # unfunction precmd
    # unfunction preexec
    unsetopt complete_in_word
    PS1='$ '
    # prompt off     # only needed if I use promptinit.
else
    # Setup my default prompt
    setLeftPrompt
    setRightPrompt

    # #(autoload for speed) prompt theme, and select
    # autoload -U promptinit
    # promptinit
    # prompt zefram
fi


# Add compleations not yet included in main vanilla zsh:
# Note: might want to force rebuild: rm -f ~/.zcompdump; compinit
fpath=($HOME/usr/src/zsh-completions/src $fpath)

# Add grayed out compleation suggestions as you type
# trigger end-of-line to accept (e.g. C-e on if using emacs keys)
source ~/usr/src/zsh-autosuggestions/zsh-autosuggestions.zsh


#------------------------------
# External libs. for syntax coloring
#------------------------------

#fishshell like syntax highlighting (have this last in this file)
if [ -d ~/usr/src/zsh-syntax-highlighting/ ]; then
    source ~/usr/src/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

#fishshell like history search, loads after zsh-syntax-highlighting.zsh
if [ -d ~/usr/src/zsh-history-substring-search/ ]; then
    source ~/usr/src/zsh-history-substring-search/zsh-history-substring-search.zsh

    # bind UP and DOWN arrow keys
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    # bind P and N for EMACS mode
    bindkey -M emacs '^P' history-substring-search-up
    bindkey -M emacs '^N' history-substring-search-down

    # bind k and j for VI mode
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
fi

# # command completion: highlight matching part of command, and
# zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

# Should be far down in config file, as it edits PATH in the init setp
if [ -d $HOME/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
fi
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi
# testar att disabla, 2021-09-03, tar lång tid att starta terminal
# source /usr/share/nvm/init-nvm.sh
