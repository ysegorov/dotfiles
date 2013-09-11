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

#command cowsay $(fortune)

#PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[00m\]\[\033[01;33m\]$(__git_ps1 " (%s)")\[\033[00m\] \$ '
#PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w
#$(hg_branch)$(hg_dirty)\
#$(git_branch)$(git_dirty) \$ '


parse_svn_branch() {
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches|branches/releases)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print " ("$1")" }'
}
parse_svn_url() {
  svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
  svn info 2>/dev/null | sed -ne 's#^Repository Root: ##p'
}

# Prints " $branchname" if in a hg or git repo, otherwise nothing.
print_branch_name() {
    if [ -z "$1" ]
    then
        curdir=`pwd`
    else
        curdir=$1
    fi
    if [ -d "$curdir/.hg" ]
    then
        echo -n " hg:"
        if [ -f  "$curdir/.hg/branch" ]
        then
            cat "$curdir/.hg/branch"
        else
            echo "default"
        fi
        return 0
    elif [ -d "$curdir/.git" ]
    then
        echo -n " git:"
        git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
    elif [ -d "$curdir/.svn" ]
    then
		echo -n " svn:"
		parse_svn_branch
    fi
    # Recurse upwards
    if [ "$curdir" == '/' ]
    then
        return 1
    else
        print_branch_name `dirname "$curdir"`
    fi
}

e=\\\033
export PS1="\[$e[1;32m\][\u@\h \t]\[$e[1;33m\]\$(print_branch_name) \[$e[1;34m\]\w \[$e[1;37m\]$ \[$e[0m\]"

# modified commands
alias diff='colordiff'              # requires colordiff package
alias grep='grep --color=auto'
alias more='less'
alias df='df -h'
alias du='du -c -h'
alias mkdir='mkdir -p -v'
alias nano='nano -w'
alias ping='ping -c 5'
alias ..='cd ..'

# new commands
alias da='date "+%A, %B %d, %Y [%T]"'
alias du1='du --max-depth=1'
alias hist='history | grep $1'      # requires an argument
alias openports='netstat --all --numeric --programs --inet --inet6'
alias pg='ps -Af | grep $1'         # requires an argument (note: /usr/bin/pg is installed by the util-linux package; maybe a different alias name should be used)

# privileged access
if [ $UID -ne 0 ]; then
    alias sudo='sudo '
    alias scat='sudo cat'
    alias svim='sudo vim'
    alias root='sudo su'
    alias reboot='sudo reboot'
    alias halt='sudo halt'
    alias update='sudo pacman -Su'
    alias netcfg='sudo netcfg2'
fi

# ls
alias la='ls -Al'               # показать скрытые файлы
alias ls='ls -hF --color'       # выделить различные типы файлов цветом
alias lx='ls -lXB'              # сортировка по расширению
alias lk='ls -lSr'              # сортировка по размеру
alias lc='ls -lcr'              # сортировка по времени изменения
alias lu='ls -lur'              # сортировка по времени последнего обращения
alias lr='ls -lR'               # рекурсивный обход подкаталогов
alias lt='ls -ltr'              # сортировка по дате
alias ll='ls -l'
alias lm='ls -al |more'         # вывод через 'more'
alias tree='tree -Csu'          # альтернатива 'ls'


# safety features
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -I'                    # 'rm -i' prompts for every file
alias ln='ln -i'
alias chown='chown --preserve-root'
alias chmod='chmod --preserve-root'
alias chgrp='chgrp --preserve-root'

# pacman aliases (if applicable, replace 'pacman' with your favorite AUR helper)
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

alias h='history'
alias j='jobs -l'
alias r='rlogin'
alias which='type -all'
alias path='echo -e ${PATH//:/\\n}'
# alias du='du -kh'
# alias df='df -kTh'


# проверка правописания - настоятельно рекомендую :-)
alias xs='cd'
alias vf='cd'
alias moer='more'
alias moew='more'
alias kk='ll'

function makepass() { dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-10; }

#-----------------------------------
# Функции для работы с файлами и строками:
#-----------------------------------

# Поиск файла по шаблону:
function ff() { find . -type f -iname '*'$*'*' -ls ; }
# Поиск файла по шаблону в $1 и запуск команды в $2 с ним:
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }

if [ "$COLORTERM" == "gnome-terminal" ]; then
	export TERM=xterm-256color
#	alias vim='gvim -v'
fi
#export PYTHONDOCS=/usr/share/doc/python2/html/
#alias vim='TERM="xterm-256color" gvim -v'

#export GEM_HOME=~/.gem/ruby/1.9.1
