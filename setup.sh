#!/usr/bin/env bash

cd "$(dirname "$0")"
dotfiles_dir=$(pwd)

link () {
    src="$dotfiles_dir/$1"
    dst="$HOME/$1"
    mkdir -p "$(dirname "$dst")"
    rm -rf "$dst"
    ln -s "$src" "$dst"
    printf "[ok] %s -> %s\n" $src $dst
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

link ".local/bin"
link ".local/bash.d"
link ".local/env.d"

echo "================================="
echo "   Setting up .config links...   "
echo "================================="

dmode ".cache/psql" "700"
link ".config/alacritty"
link ".config/hg"
link ".config/inputrc"
link ".config/git"
link ".config/mako"
link ".config/mbsync"
link ".config/msmtp"
link ".config/neomutt"
link ".config/npm"
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
link ".config/systemd/user/ssh-agent.service"
link ".config/systemd/user/ssh-gpg-keys.service"
link ".config/systemd/user/mbsync.service"
link ".config/systemd/user/mbsync.timer"
link ".config/systemd/user/pgenv.service"
link ".config/systemd/user/nginx.service"

echo "==============================="
echo "   Setting up \$HOME links...   "
echo "==============================="

unlink ".ackrc"
unlink ".hgrc"
unlink ".iex.exs"
unlink ".inputrc"
unlink ".gitconfig"
unlink ".mbsyncrc"
unlink ".msmtprc"
unlink ".npmrc"
unlink ".psqlrc"
unlink ".pylintrc"
unlink ".jshintrc"
unlink ".jython"
unlink ".xprofile"
unlink ".Xresources"
link   ".vim"
link   ".vimrc"
link   ".bash_logout"
link   ".bash_profile"
link   ".bashrc"
link   ".dircolors"
link   ".gtkrc-2.0.mine"
link   ".pam_environment"
link   ".pypirc"

echo "=================================="
echo "   Enabling systemd services...   "
echo "=================================="

systemctl --user daemon-reload
systemctl_enable "waybar.service"
systemctl_enable "tunnel-linode.service"
systemctl_enable "ssh-agent.service"
systemctl_enable "ssh-gpg-keys.service"
systemctl_enable "pgenv.service"
systemctl_enable "nginx.service"
systemctl_enable "mbsync.timer"


# mkdir -p ${target}/_npm
