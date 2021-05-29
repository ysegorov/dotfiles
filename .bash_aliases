
alias e="$EDITOR"
alias grep='grep --color=auto'
alias more='less'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
alias openports='ss --all --numeric --processes --tcp --udp'
alias cp='cp -i'
alias cp='cp -r --reflink=auto'
alias mv='mv -i'
alias rm=' timeout 5 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)
alias ssh='TERM=xterm-256color ssh'
alias http-serve='python -m http.server'
alias htpasswd='openssl passwd -apr1'
alias ip='ip -color -brief'
alias sudo='sudo -E '
alias tree='tree -a -C -I .git --dirsfirst'
alias ll='ls -l'
alias utc='env TZ=UTC date'

# install colordiff package
command -v colordiff &>/dev/null && alias diff='colordiff'
command -v locate &>/dev/null && alias locate='locate -i'
command -v rsync &>/dev/null && alias rsync='rsync --verbose --archive --info=progress2 --human-readable --partial'
command -v dig &>/dev/null && alias d='dig +nocmd +multiline +noall +answer'

command -v bat  &> /dev/null && alias c='bat -p'                                           || alias c='cat'
command -v fd   &> /dev/null && alias fd='fd --hidden --follow'                            || alias fd='find . -name'
command -v rg   &> /dev/null && alias rg='rg --hidden --follow --smart-case 2>/dev/null'   || alias rg='grep --color=auto --exclude-dir=.git -R'
command -v exa  &> /dev/null && alias ls='exa --group --git --group-directories-first'     || alias ls='ls --color=auto --group-directories-first -h'
command -v exa  &> /dev/null && alias la='ll -a'                                           || alias la='ll -A'
command -v exa  &> /dev/null && alias lk='ll -s=size'                                      || alias lk='ll -r --sort=size'
command -v exa  &> /dev/null && alias lm='ll -s=modified'                                  || alias lm='ll -r --sort=time'

alias mksecret="cat /dev/urandom | tr -dc \"a-zA-Z0-9\" | fold -w 128 | head -n 1"
# yaourt -S sharutils
command -v uuencode &>/dev/null && alias mkpass="dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-40"

# virtualenv
alias cdsrc="cd ${VIRTUAL_ENV}/src"
alias cdsitepackages="cd ${VIRTUAL_ENV}/lib/python*/site-packages/"
alias cdproject="cd ${VIRTUAL_ENV:-~}"
#alias cdproject="cd ${DEV_ROOT:-VIRTUAL_ENV}; if [ $(basename ${PWD}) = \"env\" ]; then cd ..; fi"


# postgres
alias psql='psql -h localhost'
alias pgsize='psql -c "SELECT pg_database.datname, pg_database_size(pg_database.datname), pg_size_pretty(pg_database_size(pg_database.datname)) FROM pg_database ORDER BY pg_database_size DESC;"'


# haskell
alias ghci='ghci -v0 -ignore-dot-ghci -ghci-script $HOME/.local/ghc/ghci.conf'

# rust
_rr() {
    if [ -f "$1.rs" ] ; then
        rustc "$1.rs" && "./$1"
    else
        echo "'${1:-undef}' is not a valid rust file"
    fi
}

# NB. rr -> compile and run rust program
alias rr=_rr


# tolsha
alias tvpn="cd $HOME/work/igor/tolsha/yuri && sudo openvpn client.conf"


# # systemctl
# alias sys='systemctl'
# alias sysu='systemctl --user'
# alias status='sys status'
# alias statusu='sysu status'
# alias start='sys start'
# alias startu='sysu start'
# alias stop='sys stop'
# alias stopu='sysu stop'
# alias restart='sys restart'
# alias restartu='sysu restart'
# alias enable='sys enable'
# alias enableu='sysu enable'
# alias disable='sys disable'
# alias disableu='sysu disable'
# alias reload='sys daemon-reload'
# alias reloadu='sysu daemon-reload'
# alias timers='sys list-timers'
# alias timersu='sysu list-timers'


md() {
    [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1"
}
# compdef _directories md

e64() {
    [[ $# == 1 ]] && base64 -w0 <<<"$1" || base64 -w0
}
d64() {
    [[ $# == 1 ]] && base64 --decode <<<"$1" || base64 --decode
}

p() {
    ping "${1:-1.1.1.1}"
}

tmpd() {
    cd "$(mktemp -d -t "${1:-tmp}.XXXXXXXXXX")"
}


# dev
dev () {

    shopt -s nullglob globstar

    if [ "$#" -gt 0 ]; then q="-q $@"; else q=""; fi

    p1=$(fd -t d -d 1 -a . /home/dotprom/dev)
    p2=$(fd -t d -d 1 -a . "${HOME}/dev")

    folder=$(printf '%s\n' "${p1[@]}" "${p2[@]}" | fzf --select-1 --reverse --no-bold -d "/" -n -1 --with-nth=-1 $q)

    [[ -n $folder ]] || return 1

    cd ${folder}

}

# nnn
n() {

    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return 1
    fi

    LC_COLLATE="C"

    COLORS=4235
    FCOLORS='c1e2272e006033f7c6d6abc4'
    FIFO=${XDG_RUNTIME_DIR}/nnn.fifo
    OPENER=nuke

    BMS="d:~/dev;g:~/git;D:~/downloads"

    html='h:_w3m -dump $nnn'
    mupdf='p:-_mupdf $nnn*'
    leafpad='l:_|leafpad $nnn'
    chmod_x='x:_chmod u+x $nnn'
    preview='w:preview-tui'
    odt2txt='d:-_odt2txt $nnn'
    imv='i:-_imv $nnn*'
    bat=';:-_bat --paging always $nnn*'

    PLUG="${preview};${chmod_x};${mupdf};${leafpad};${html};${odt2txt};${imv};${bat}"

    env LC_COLLATE="C" \
        NNN_COLORS="${COLORS}" \
        NNN_FCOLORS="${FCOLORS}" \
        NNN_FIFO="${FIFO}" \
        NNN_OPENER="${OPENER}" \
        NNN_BMS="${BMS}" \
        NNN_PLUG="${PLUG}" \
        nnn -A -c -d -H
}


vim() {
    echo "oops, use 'e' or 'nvim'!"
    return 1
}

dig() {
    echo "oops, use 'drill'!"
    return 1
}

# vim: ft=sh:
