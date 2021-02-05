#!/bin/sh

i3status --config ~/.i3/i3status.conf | while :
do
    read line
    LG=`xkb-switch`
    if [ $LG == "us" ]
    then
        dat="[{ \"full_text\": \" $LG\", \"color\": \"#b8bb26\" },"
    else
        dat="[{ \"full_text\": \" $LG\", \"color\": \"#83a598\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
