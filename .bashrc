# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# name to be used in PS1 prompt
PS1_NAME="local"


# bash options ------------------------------------
#set -o vi                   # Vi mode
#set -o noclobber            # do not overwrite files
#shopt -s autocd             # change to named directory
#shopt -s cdable_vars        # if cd arg is not valid, assumes its a var defining a dir
shopt -s cdspell            # autocorrects cd misspellings
shopt -s checkwinsize       # update the value of LINES and COLUMNS after each command if altered
shopt -s cmdhist            # save multi-line commands in history as single line
shopt -s histappend         # do not overwrite history
shopt -s dotglob            # include dotfiles in pathname expansion
shopt -s expand_aliases     # expand aliases
shopt -s extglob            # enable extended pattern-matching features
shopt -s globstar           # recursive globbing
shopt -s progcomp           # programmable completion
shopt -s hostcomplete       # attempt hostname expansion when @ is at the beginning of a word
shopt -s nocaseglob         # pathname expansion will be treated as case-insensitive

set bell-style visual       # visual bell

# set history variables
unset HISTFILESIZE
HISTSIZE=100000
HISTCONTROL=ignoredups:ignorespace

# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
        ;;
esac

if type -P dircolors >/dev/null ; then
    if [[ -f ~/.dircolors ]]; then
        eval $(dircolors -b ~/.dircolors)
    elif [[ -f ~/.dir_colors ]] ; then
        eval $(dircolors -b ~/.dir_colors)
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval $(dircolors -b /etc/DIR_COLORS)
    fi
fi

## source useful files
[[ -r /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
[[ -f ~/.bash_functions ]] && source ~/.bash_functions
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash

source /usr/share/git/completion/git-prompt.sh
bash_prompt


# http://blog.zoomeranalytics.com/pip-install-t/
export PYTHONPATH=./.pip:$PYTHONPATH

#export MC_SKIN=${HOME}/.config/mc/solarized.ini
export NODE_PATH=${HOME}/_npm/lib/node_modules:${NODE_PATH}:/usr/lib/node_modules

export PATH=$HOME/mongodb/bin:$HOME/bin:$HOME/.gem/ruby/2.3.0/bin:$HOME/_npm/bin:$PATH
