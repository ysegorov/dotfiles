#!/bin/sh

i3status --config ~/.i3/i3status.conf | while :
do
    read line
    LG=`xkblayout-state print %s`
    if [ $LG == "us" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
