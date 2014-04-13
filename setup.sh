#!/usr/bin/env bash

cwd=`pwd`

ln -sfiv ${cwd}/.i3 ${cwd}/.xprofile ${cwd}/.Xresources ${cwd}/.inputrc ${cwd}/.bashrc ${cwd}/.bash_profile ${cwd}/.pylintrc ${cwd}/.hgrc ${cwd}/.bash_aliases ${cwd}/.bash_functions ${cwd}/.dircolors ${cwd}/.gitconfig ${HOME}

mkdir -p ${HOME}/.config/
ln -sfiv ${cwd}/.config/dunst ${HOME}/.config/

mkdir -p ${HOME}/.config/mc/
ln -sfiv ${cwd}/.config/mc/solarized.ini ${HOME}/.config/mc/
