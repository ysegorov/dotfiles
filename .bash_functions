
function makepass() { dd if=/dev/urandom count=1 2> /dev/null | uuencode -m - | sed -ne 2p | cut -c-10; }

# Find file by name pattern
function ff() { find . -type f -iname '*'$*'*' -ls ; }
# Find file by pattern in $1 and execute $2 on it
function fe() { find . -type f -iname '*'$1'*' -exec "${2:-file}" {} \;  ; }
function fs() { find . -type f -iname "$1" -exec grep -i -n -H -T --color=auto -C 2 -e "$2" {} \; ; }

parse_git_branch () {
  git name-rev HEAD 2> /dev/null | sed 's#HEAD\ \(.*\)# (git::\1)#'
}
parse_svn_branch() {
  # parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk '{print " (svn::"$1")" }'
  parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches|branches/releases|branches/merged|branches/trash|branches/stable)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print " ("$1")" }'
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
        echo -n "hg:"
        if [ -f  "$curdir/.hg/branch" ]
        then
            cat "$curdir/.hg/branch"
        else
            echo "default"
        fi
        return 0
    elif [ -d "$curdir/.git" ]
    then
        echo -n "git:$(__git_ps1 %s)"
        # git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
    elif [ -d "$curdir/.svn" ]
    then
        echo -n "svn:"
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

hgcmd()
{
    local dirs=`find . -maxdepth 1 -type d`
    for x in $dirs
    do
        if [ $x != '.' ]
        then
            if [ -d "$x/.hg" ]
            then
                echo $x && cd $x
                for cmd in `seq 1 $#`; do hg ${!cmd}; done
                cd ..
            fi
        fi
    done
}
hgchanges()
{
    hgcmd stat
}
alias hgch='hgchanges'

hgbranches()
{
    hgcmd branch
}
alias hgbr='hgbranches'

hgpullupdate()
{
    hgcmd "pull -u"
}
alias hgpull='hgpullupdate'

hgmergedefault()
{
    hgcmd "pull -u" "merge default"
}
alias hgmd='hgmergedefault'


# function setting prompt string
bash_prompt() {
    # some colors
    local color_reset="\033[00m"
    local red="\033[00;31m"
    local green="\033[00;32m"
    local yellow="\033[00;33m"
    local blue="\033[00;34m"
    local magenta="\033[00;35m"
    local neutro="\033[01;32m"

    # red for root, green for others
    local host_color=$(if [[ $UID == 0 ]]; then echo "$red"; else echo "$neutro"; fi)

    # colorized return value of last command
    local ret="\$(if [[ \$? != 0 ]]; then echo \"\[$red\][!] \"; fi)"

    # blue for writable directories, yellow for non-writable directories
    local dir="\$(if [[ -w \$PWD ]]; then echo \"\[$blue\]\"; else echo \"\[$yellow\]\"; fi)\w"

    # configuration for __git_ps1 function
    GIT_PS1_SHOWDIRTYSTATE=1
    GIT_PS1_SHOWSTASHSTATE=1
    GIT_PS1_SHOWUPSTREAM="auto"

    # put it all together
    PS1="$ret\[$yellow\][$PS1_NAME] \[$host_color\][\u@\h \t]\[$color_reset\]:$dir\[$magenta\] \$(print_branch_name) \[$color_reset\]\$ "
}

assignProxy(){
    PROXY_ENV="http_proxy ftp_proxy https_proxy all_proxy no_proxy HTTP_PROXY HTTPS_PROXY FTP_PROXY NO_PROXY ALL_PROXY"
    for envar in $PROXY_ENV
    do
        export $envar=$1
    done
}

clrProxy(){
    assignProxy "" # This is what 'unset' does.
}

assignSocks(){
    export SOCKS_SERVER=$1
    export SOCKS_VERSION=$2
}
clrSocks(){
    assignSocks "" ""
}

# setProxy(){
#     user=YourUserName
#     read -p "Password: " -s pass &&  echo -e " "
#     proxy_value="http://$user:$pass@ProxyServerAddress:Port"
#     assignProxy $proxy_value
# }
# vim: syn=sh
