
## https://wiki.archlinux.org/index.php/bash

## Modified commands ## {{{
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias dmesg='dmesg -HL'
# }}}

## New commands ## {{{
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep'         # requires an argument
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias pgg='ps -Af | grep'           # requires an argument
alias ..='cd ..'
# }}}

# Privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudoedit'
    alias root='sudo -s'
    alias reboot='sudo systemctl reboot'
    alias poweroff='sudo systemctl poweroff'
    alias update='sudo pacman -Su'
    alias netctl='sudo netctl'
fi

## ls ## {{{
alias ls='ls -hF --color=auto'
alias lr='ls -R'                    # recursive ls
alias ll='ls -l'
alias la='ll -A'
alias lx='ll -BX'                   # sort by extension
alias lz='ll -rS'                   # sort by size
alias lt='ll -rt'                   # sort by date
alias lm='la | more'
alias tree='tree -Csu'          # альтернатива 'ls'
# }}}

## Safety features ## {{{
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
# safer alternative w/ timeout, not stored in history
alias rm=' timeout 3 rm -Iv --one-file-system'
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'
alias cls=' echo -ne "\033c"'       # clear screen for real (it does not work in Terminology)
# }}}

## Make Bash error tolerant ## {{{
alias :q=' exit'
alias :Q=' exit'
alias :x=' exit'
alias cd..='cd ..'
alias ..='cd ..'
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'
# }}}

# pacman aliases (if applicable, replace 'pacman' with your favorite AUR helper) ## {{{
alias pac="pacman -S"      # default action     - install one or more packages
alias pacu="pacman -Syu"   # '[u]pdate'         - upgrade all packages to their newest version
alias pacs="pacman -Ss"    # '[s]earch'         - search for a package using one or more keywords
alias paci="pacman -Si"    # '[i]nfo'           - show information about a package
alias pacr="pacman -R"     # '[r]emove'         - uninstall one or more packages
alias pacl="pacman -Sl"    # '[l]ist'           - list all packages of a repository
alias pacll="pacman -Qqm"  # '[l]ist [l]ocal'   - list all packages which were locally installed (e.g. AUR packages)
alias paclo="pacman -Qdt"  # '[l]ist [o]rphans' - list all packages which are orphaned
alias paco="pacman -Qo"    # '[o]wner'          - determine which package owns a given file
alias pacf="pacman -Ql"    # '[f]iles'          - list all files installed by a given package
alias pacc="pacman -Sc"    # '[c]lean cache'    - delete all not currently installed package files
alias pacm="makepkg -fci"  # '[m]ake'           - make package from PKGBUILD file in current directory
# }}}

# postgres
alias pgsize='psql -c "SELECT pg_database.datname, pg_database_size(pg_database.datname), pg_size_pretty(pg_database_size(pg_database.datname)) FROM pg_database ORDER BY pg_database_size DESC;"'

# skype
# https://wiki.archlinux.org/index.php/Skype#Use_Skype_with_special_user
# yaourt -S lib32-apulse
alias skype='xhost +local: && sudo -u skype apulse32 /usr/bin/skype'

# ssh channels
alias channels='pkill -f "ssh -fN"; ssh -fN -D 12021 -o ControlMaster=no n3 & ssh -fN git@github.com & ssh -fN git@bitbucket.org & ssh -fN hg@bitbucket.org &'

# secrets generator
alias mksecret='cat /dev/urandom | tr -dc "a-zA-Z0-9" | fold -w 128 | head -n 1'

# kanobu
# alias kanobu='pon kanobu && sleep 5 && ip route add default dev ppp0'
alias kranobu='chromium --no-proxy-server --user-data-dir="${HOME}/.config/chromium.at.kanobu/"'
alias kopera='opera-developer --no-proxy-server --user-data-dir="${HOME}/.config/opera.at.kanobu/"'

# dotprom
alias dpwifi='sudo netctl start dotpromwifi'
alias dpchrome='chromium --no-proxy-server --user-data-dir="${HOME}/.config/chromium.at.dotprom/"'
alias dpopera='opera-developer --no-proxy-server --user-data-dir="${HOME}/.config/opera.at.dotprom/"'

# backup
alias backup='rsync -a -v --delete --exclude=_music --exclude=_movies --exclude=Downloads -e ssh . nas:/mnt/rd3/_archiv/asuspro'

# vim: syn=sh
