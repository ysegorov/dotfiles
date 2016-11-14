#!/usr/bin/env bash

cwd=`pwd`

ln -sfi ${cwd}/bin ${HOME}/
ln -sfi ${cwd}/.bash.d ${HOME}/
ln -sfiv ${cwd}/.i3 ${cwd}/.xprofile ${cwd}/.Xresources ${cwd}/.inputrc ${cwd}/.bashrc ${cwd}/.bash_profile ${cwd}/.pylintrc ${cwd}/.hgrc ${cwd}/.dircolors ${cwd}/.gitconfig ${cwd}/.npmrc ${cwd}/.psqlrc ${HOME}

mkdir -p ${HOME}/.config/
ln -sfiv ${cwd}/.config/dunst ${HOME}/.config/
ln -sfiv ${cwd}/.config/termite ${HOME}/.config/
ln -sfiv ${cwd}/.config/compton ${HOME}/.config/

#mkdir -p ${HOME}/.config/mc/
#ln -sfiv ${cwd}/.config/mc/solarized.ini ${HOME}/.config/mc/

mkdir -p ${HOME}/_npm
