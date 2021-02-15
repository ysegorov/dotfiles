#
# NB. this file will be sourced by login shell only
# see man bash, invocation section
#

TTY=$(tty)

systemctl --user set-environment PATH="${HOME}/.local/bin:${PATH}"

export $(systemctl --user show-environment)

[[ "$TTY" == /dev/tty* ]] || return 0

if [[ -z $DISPLAY && "$TTY" == "/dev/tty1" ]]; then
    systemd-cat --identifier sway sway
    systemctl --user stop sway-session.target
    systemctl --user unset-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
    logout
else
    # NB. force load of .bashrc for login shell
    [[ -f ~/.bashrc ]] && source ~/.bashrc
fi
