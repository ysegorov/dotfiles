#!/bin/sh

# frontend for:            cuetools, shntool, mp3splt
# optional dependencies:    flac, mac, wavpack

SDIR=`pwd`

if [ "$1" = "" ]
  then
    DIR=$SDIR
else
    case $1 in
        -h | --help )
            echo "Usage: cuesplit [Path]"
            echo "       The default path is the current directory."
            exit
            ;;
        * )
        DIR=$1
    esac
fi

echo -e "\

Directory: $DIR
________________________________________
"
cd "$DIR"
TYPE=`ls -t1`

case $TYPE in
    *.ape*)
        cuebreakpoints *.cue | shnsplit -a track -o flac *.ape
        cuetag.sh *.cue track*.flac
        exit
        ;;

    *.flac*)
        cuebreakpoints *.cue | shnsplit -a track -o flac *.flac
        cuetag.sh *.cue track*.flac
        exit
        ;;

    *.mp3*)
        mp3splt -no "@n @p - @t (split)" -c *.cue *.mp3
        cuetag.sh *.cue *split\).mp3
        exit
        ;;

    *.ogg*)
        mp3splt -no "@n @p - @t (split)" -c *.cue *.ogg
        cuetag.sh *.cue *split\).ogg
        exit
        ;;

    *.wv*)
        cuebreakpoints *.cue | shnsplit -a track -o flac *.wv
        cuetag.sh *.cue track*.flac
        exit
        ;;

    *.wav*)
        cuebreakpoints *.cue | shnsplit -a track -o flac *.wav
        cuetag.sh *.cue track*.flac
        exit
        ;;

    * )
    echo "Error: Found no files to split!"
    echo "       --> APE, FLAC, MP3, OGG, WV, WAV"
esac
exit