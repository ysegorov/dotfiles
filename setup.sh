#!/usr/bin/env bash

cd "$(dirname "$0")"
dotfiles_dir=$(pwd)

link () {
    src="$dotfiles_dir/$1"
    dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    rm -rf "$dst"
    ln -s "$src" "$dst"
    printf "[ok] %s -> %s\n" $dst $src
}

unlink() {
    dst="$HOME/$1"
    [ -L "$dst" ] && rm -rf "$dst" && printf "[ok] rm %s\n" $dst
}

systemctl_enable () {
    systemctl --user enable "$1"
    printf "[ok] systemctl --user enable %s\n" $1
}

dmode () {
    dst="$HOME/$1"
    mkdir -p "$dst"
    chmod "$2" "$dst"
    printf "[ok] chmod %s %s\n" $2 $dst
}

echo "================================"
echo "   Setting up .gnupg links...   "
echo "================================"

dmode ".gnupg" "700"
link  ".gnupg/gpg.conf"
link  ".gnupg/gpg-agent.conf"

echo "================================"
echo "   Setting up .local links...   "
echo "================================"

unlink ".local/env.d"
unlink ".local/bash.d"
link   ".local/bin"

echo "================================="
echo "   Setting up .config links...   "
echo "================================="

dmode ".cache/psql" "700"
link ".config/alacritty"
link ".config/environment.d"
link ".config/hg"
link ".config/inputrc"
link ".config/git"
link ".config/kitty"
link ".config/mako"
link ".config/mbsync"
link ".config/msmtp"
link ".config/neomutt"
link ".config/nord-dircolors"
link ".config/npm"
link ".config/nvim"
link ".config/pylint"
link ".config/psql"
link ".config/swappy"
link ".config/sway"
link ".config/waybar"
link ".config/user-dirs.dirs"
link ".config/user-dirs.locale"
link ".config/systemd/user/sway-session.target"
link ".config/systemd/user/waybar.service"
link ".config/systemd/user/tunnel-linode.service"
link ".config/systemd/user/mbsync.service"
link ".config/systemd/user/mbsync.timer"
link ".config/systemd/user/pgenv.service"
link ".config/systemd/user/nginx.service"

echo "==============================="
echo "   Setting up \$HOME links...   "
echo "==============================="

unlink ".ackrc"
unlink ".dircolors"
unlink ".gitconfig"
unlink ".hgrc"
unlink ".iex.exs"
unlink ".inputrc"
unlink ".jshintrc"
unlink ".jython"
unlink ".mbsyncrc"
unlink ".msmtprc"
unlink ".npmrc"
unlink ".pam_environment"
unlink ".psqlrc"
unlink ".pylintrc"
unlink ".xprofile"
unlink ".Xresources"
link   ".vim"
link   ".vimrc"
link   ".bash_logout"
link   ".bash_profile"
link   ".bash_aliases"
link   ".bashrc"
link   ".gtkrc-2.0.mine"
link   ".pypirc"

echo "=================================="
echo "   Enabling systemd services...   "
echo "=================================="

systemctl --user daemon-reload
systemctl_enable "waybar.service"
systemctl_enable "tunnel-linode.service"
systemctl_enable "pgenv.service"
systemctl_enable "nginx.service"
systemctl_enable "mbsync.timer"


# mkdir -p ${target}/_npm
