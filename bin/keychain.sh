#!/usr/bin/env bash

eval `keychain -q --eval id_chtd_rsa id_inet_rsa id_dsa`

xfce4-terminal --hide-borders --maximize --tab --tab --tab --tab --tab --tab --tab --tab &

sleep 3
wmctrl -r Терминал -t 3

ssh -fN hg@bitbucket.org
