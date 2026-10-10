#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
# http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/
############################

########## Variables

dir=$HOME/.dotfiles                    # dotfiles directory
olddir=$HOME/.dotfiles_old             # old dotfiles backup directory

# list of files/folders to symlink in homedir
files="bashrc conkerorrc conkyrc gnuplot guile mailcap pylintrc scrotwm.conf shell_common tmux.conf octaverc vimrc xinitrc xpdfrc Xmodmap Xresources zshrc zshenv zlogin"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir/.$file
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Install nyxt config
mkdir -p $HOME/.config/nyxt/
ln -s $dir/nyxt.lisp $HOME/.config/nyxt/config.lisp

# Keep in its own directory, since log is written to current config folder by default.
# Looks for valid config folder in order:
# 1. ~/.stumpwmrc
# 2. ~/.stumpwm.d/init.lisp
# 3. ~/.config/stumpwm/config (XDG)
echo "Creating ~/.stumpwm/init.lisp symlink."
ln -s $dir/stumpwmrc ~/.stumpwm.d/init.lisp
