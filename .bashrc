
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
test -r ~/.config/nord-dircolors/src/dir_colors && eval $(dircolors ~/.config/nord-dircolors/src/dir_colors)


### stardict: yaourt -S sdcv
export STARDICT_DATA_DIR="${XDG_CONFIG_HOME}/stardict"


# Change the window title of X terminals
case ${TERM} in
    xterm*|rxvt*|Eterm|aterm|kterm|gnome*|interix|alacritty)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
        ;;
    screen)
        PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
        ;;
esac


### bash prompt
# gruvbox colors for terminal supporting 24 bit colors
color_reset="\033[0m"
color_prefix="\033[38;2;"

# gruvbox_dark
# red="${color_prefix}251;73;52m"
# green="${color_prefix}184;187;38m"
# aqua="${color_prefix}142;192;124m"
# yellow="${color_prefix}250;189;47m"
# blue="${color_prefix}131;165;152m"
# magenta="${color_prefix}211;134;155m"
# orange="${color_prefix}254;128;25m"
# neutro="${color_prefix}235;219;178m"

# nord
red="${color_prefix}191;97;106m"
green="${color_prefix}163;190;140m"
yellow="${color_prefix}235;203;139m"
aqua="${color_prefix}129;161;193m"
blue="${color_prefix}94;129;172m"
magenta="${color_prefix}180;142;173m"
orange="${color_prefix}208;135;112m"
neutro="${color_prefix}136;192;208m"

vcs_status() {
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"
    GIT_PS1_SHOWCOLORHINTS=1

    if [ -z "$1" ]; then curdir="$(pwd)"; else curdir="$1"; fi
    if [ -d "$curdir/.git" ]; then echo "g:$(__git_ps1 %s)"; return 0; fi
    if [ "$curdir" != '/' ]; then vcs_status $(dirname "$curdir"); fi
}

retval() {
    if [[ $? != 0 ]]; then printf "$red[!] "; else printf ""; fi
}

# function setting prompt string
bash_prompt() {
    local host_color=$(if [[ $UID == 0 ]]; then echo "$red"; else echo "$neutro"; fi)
    local dir="\$(if [[ -w \$PWD ]]; then echo \"\[$aqua\]\"; else echo \"\[$yellow\]\"; fi)\w"

    PS1="\$(retval)\[$host_color\][\u@\h \t]\[$color_reset\]:$dir\[$magenta\] \[\$(vcs_status)\] \[$color_reset\]\$ "
}

[[ -f /usr/share/git/completion/git-prompt.sh ]] && source /usr/share/git/completion/git-prompt.sh
bash_prompt
unset -f bash_prompt

[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"


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
###        git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.local/pyenv/plugins/
export PYENV_ROOT="${HOME}/.local/pyenv"

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
            activate|deactivate|rehash|shell)
                eval "$(pyenv "sh-$command" "$@")";;
            *)
                command pyenv "$command" "$@";;
        esac
    }

    # pyenv-virtualenv plugin
    export PATH="${PYENV_ROOT}/plugins/pyenv-virtualenv/shims:${PATH}";
    export PYENV_VIRTUALENV_INIT=1;
    _pyenv_virtualenv_hook() {
        local ret=$?
        if [ -n "$VIRTUAL_ENV" ]; then
            eval "$(pyenv sh-activate --quiet || pyenv sh-deactivate --quiet || true)" || true
        else
            eval "$(pyenv sh-activate --quiet || true)" || true
        fi
        return $ret
    };
    if ! [[ "${PROMPT_COMMAND}" =~ _pyenv_virtualenv_hook ]]; then
        PROMPT_COMMAND="_pyenv_virtualenv_hook;${PROMPT_COMMAND}";
    fi
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
