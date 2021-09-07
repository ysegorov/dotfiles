
# NB. This file is sourced by all *interactive* bash shells on startup.
#     Make sure this doesn't display anything!
#

# NB. exit if shell is non-interactive
if [[ $- != *i* ]] ; then
    return
fi


# NB. set shell options, see man bash, shell builtin commands section
shopt -s \
    cdspell checkwinsize cmdhist histappend dotglob expand_aliases \
    extglob globstar progcomp hostcomplete nocaseglob

set bell-style visual

# NB. disable history
# set +o history  # this will disable in-memory shell history
unset HISTFILESIZE
unset HISTFILE
# HISTSIZE=100000
# HISTCONTROL=ignoredups:ignorespace


### lesspipe.sh: yaourt -S lesspipe
# make less more friendly for non-text input files, see lesspipe(1)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"


### nord-dircolors
# test -r ~/.config/nord-dircolors/src/dir_colors && eval $(dircolors ~/.config/nord-dircolors/src/dir_colors)

# yaourt -S lscolors-git
source /usr/share/LS_COLORS/dircolors.sh
# export LS_COLORS="di=36:fi=33:ln=33:ex=31:or=41;37"
# https://the.exa.website/docs/colour-themes
export EXA_COLORS="di=34:or=31:da=36:sn=36:sb=36:uu=32:gu=32:un=33:gn=33:ur=32:uw=32:ux=32:ue=32:gr=36:gw=36:gx=36:tr=33:tw=33:tx=33"

### stardict: yaourt -S sdcv
export STARDICT_DATA_DIR="${XDG_CONFIG_HOME}/stardict"


### bash prompt
# gruvbox colors for terminal supporting 24 bit colors
color_reset="\033[0m"
color_prefix="\033[38;2;"

# gruvbox_dark
red="${color_prefix}251;73;52m"
green="${color_prefix}184;187;38m"
aqua="${color_prefix}142;192;124m"
yellow="${color_prefix}250;189;47m"
blue="${color_prefix}131;165;152m"
magenta="${color_prefix}211;134;155m"
orange="${color_prefix}254;128;25m"
neutro="${color_prefix}235;219;178m"

# nord
# red="${color_prefix}191;97;106m"
# green="${color_prefix}163;190;140m"
# yellow="${color_prefix}235;203;139m"
# aqua="${color_prefix}129;161;193m"
# blue="${color_prefix}94;129;172m"
# magenta="${color_prefix}180;142;173m"
# orange="${color_prefix}208;135;112m"
# neutro="${color_prefix}136;192;208m"

vcs_status() {
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_SHOWCOLORHINTS=1

    if [ -z "$1" ]; then curdir="$(pwd)"; else curdir="$1"; fi
    if [ -d "$curdir/.git" ]; then printf " git:$(__git_ps1 %s)"; return 0; fi
    if [ "$curdir" != '/' ]; then vcs_status $(dirname "$curdir"); fi
}

# function setting prompt string
bash_prompt() {
    local ret=$?  # NB.  must be on the first line
    PS1=""

    if [[ $ret != 0 ]]; then local retval="\[${red}\][!] "; else local retval=""; fi
    if [[ $UID == 0 ]]; then local hostcolor="${red}"; else local hostcolor="${neutro}"; fi
    if [[ -w $PWD ]]; then local dircolor="${aqua}"; else local dircolor="${yellow}"; fi
    if [[ -z $VIRTUAL_ENV ]]; then
        local ve=""
    else
        local nm=$(basename "$VIRTUAL_ENV")
        if [[ ${nm} == 'env' ]]; then
            local ve="($(basename $(dirname \"$VIRTUAL_ENV\"))) "
        else
            local ve="(${nm}) "
        fi
    fi
    if [[ -z $NNNLVL ]]; then local nnnlvl=""; else local nnnlvl="N$NNNLVL "; fi

    PS1+="\n"
    PS1+="${nnnlvl}"
    PS1+="${ve}"
    PS1+="\[${hostcolor}\][\u@\h \t]"
    PS1+="\[${color_reset}\]:"
    PS1+="\[${dircolor}\]\w"
    PS1+="\[${magenta}\]$(vcs_status)"
    PS1+="\n"
    PS1+="${retval}"
    PS1+="\[${color_reset}\]\$ "
}

# Change the window title of X terminals
title() {
    case ${TERM} in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix|alacritty|foot)
            echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~} - bash\007"
            ;;
        screen)
            echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033"
            ;;
    esac
}
PROMPT_COMMAND="bash_prompt;title"


[[ -f /usr/share/git/completion/git-prompt.sh ]] && source /usr/share/git/completion/git-prompt.sh


### pgenv: git clone https://github.com/theory/pgenv.git ~/
pgenv_root="${HOME}/.pgenv"
if [ -d "${pgenv_root}" ]; then
    export PATH="${HOME}/.pgenv/bin:${HOME}/.pgenv/pgsql/bin:${PATH}"
fi
unset pgenv_root


### nodenv: git clone https://github.com/nodenv/nodenv.git ~/.local/
export NODENV_ROOT="$HOME/.local/nodenv"

if [ -d "${NODENV_ROOT}" ]; then
    export PATH="${NODENV_ROOT}/shims:${NODENV_ROOT}/bin:${PATH}"
    # eval "$(nodenv init -)"
    export NODENV_SHELL=bash
    source "${NODENV_ROOT}/completions/nodenv.bash"
    # command nodenv rehash 2>/dev/null
    nodenv() {
        local command
        command="${1:-}"
        if [ "$#" -gt 0 ]; then
            shift
        fi

        case "$command" in
            rehash|shell)
                eval "$(nodenv "sh-$command" "$@")";;
            *)
                command nodenv "$command" "$@";;
        esac
    }
fi


### pyenv: git clone https://github.com/pyenv/pyenv.git ~/.local/
export PYENV_ROOT="${HOME}/.local/pyenv"
export VENVS_ROOT="${HOME}/.local/venvs"

if [ -d "${PYENV_ROOT}" ]; then
    # export PATH="$PYENV_ROOT/bin:$PATH"
    # if command -v pyenv 1>/dev/null 2>&1; then
    #     eval "$(pyenv init -)"
    #     eval "$(pyenv virtualenv-init -)"
    # fi

    export PATH="${PYENV_ROOT}/shims:${PYENV_ROOT}/bin:${PATH}"
    export PYENV_SHELL=bash
    source "${PYENV_ROOT}/completions/pyenv.bash"
    # command pyenv rehash 2>/dev/null
    pyenv() {
        local command
        command="${1:-}"
        if [ "$#" -gt 0 ]; then
            shift
        fi

        case "$command" in
            rehash|shell)
                eval "$(pyenv "sh-$command" "$@")";;
            *)
                command pyenv "$command" "$@";;
        esac
    }

fi


### rust
export PATH="${HOME}/.cargo/bin:${PATH}"


### texlive
texlive_root="${HOME}/.texlive"
if [ -d "${texlive_root}" ]; then
    export PATH="${texlive_root}/bin/x86_64-linux:${PATH}"
fi
unset texlive_root


### .bash_aliases
[[ -f ${HOME}/.bash_aliases ]] && source ${HOME}/.bash_aliases


## source useful files
[[ -r /usr/share/bash-completion/bash_completion ]] && source /usr/share/bash-completion/bash_completion || true
[[ -f /usr/share/doc/pkgfile/command-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash || true
