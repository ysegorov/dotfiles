#!/usr/bin/env bash

cwd=`pwd`
target=${HOME}

ln -sfvi -T ${cwd}/bin ${target}/.bin
ln -sfvi -T ${cwd}/bash.d ${target}/.bash.d
ln -sfvi -T ${cwd}/vim ${target}/.vim

find ${cwd} -maxdepth 1 -type f \( \! -name 'setup.sh' \! -name '.gitignore' \) -exec bash -c 'ln -svfi -T "$1" "$2/.`basename $1`"' _ {} ${target} \;

mkdir -p ${target}/.config/
ln -sfiv ${cwd}/config/i3 ${cwd}/config/dunst ${cwd}/config/termite ${cwd}/config/chromium-flags.conf ${target}/.config/

mkdir -p ${target}/_npm
