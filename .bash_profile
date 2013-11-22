### Bind commands
## Auto completion
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

### Exports
## History control
export HISTCONTROL=erasedups
export HISTSIZE=10000
export HISTIGNORE="ls:exit:df:w:h:ll:apollo:top"
shopt -s histappend
## General stuff
export EDITOR="vim"
# Use Vim as man viewer
export PAGER="col -b | vim -R -c 'set ft=man nomod nolist' -"
export PATH=$PATH:/opt/local/bin:/opt/local:/opt/local/sbin
export MANPATH=$MANPATH:/opt/local/share/man
export IGNOREEOF=1
## Colours
export CLICOLOR=true
export LSCOLORS='cxfxcxdxbxegedabagacad'

### Functions

# Change Directory to the active Finder window (else ~/Desktop)
function cdf()
   {
      local fPath=`osascript -e '
      tell app "finder"
         try
            set folderPath to (folder of the front window as alias)
         on error
            set folderPath to (path to desktop folder as alias)
         end try
         POSIX path of folderPath
      end tell'
      `;
      echo "cd $fPath";
      cd "$fPath" > /dev/null
   }

#ip shows ip addresses for eth0, eth1 and external
function ip()
   {
      echo -e "Ethernet:\t `ipconfig getifaddr en0 2> /dev/null`"
      echo -e "WiFi:\t\t `ipconfig getifaddr en1 2> /dev/null`"
      echo -e "External:\t `curl -s http://checkip.dyndns.org/` | `grep -o '[0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*.[0-9]*'`"
      echo ""
   }

## Prompt

## Prompt
# 30m - Black
# 31m - Red
# 32m - Green
# 33m - Yellow
# 34m - Blue
# 35m - Purple
# 36m - Cyan
# 37m - White
#   0 - Normal
#   1 - Bold
function prompt {
  local BLACK="\[\033[0;30m\]"
  local BLACKBOLD="\[\033[1;30m\]"
  local RED="\[\033[0;31m\]"
  local REDBOLD="\[\033[1;31m\]"
  local GREEN="\[\033[0;32m\]"
  local GREENBOLD="\[\033[1;32m\]"
  local YELLOW="\[\033[0;33m\]"
  local YELLOWBOLD="\[\033[1;33m\]"
  local BLUE="\[\033[0;34m\]"
  local BLUEBOLD="\[\033[1;34m\]"
  local PURPLE="\[\033[0;35m\]"
  local PURPLEBOLD="\[\033[1;35m\]"
  local CYAN="\[\033[0;36m\]"
  local CYANBOLD="\[\033[1;36m\]"
  local WHITE="\[\033[0;37m\]"
  local WHITEBOLD="\[\033[1;37m\]"
  local NORMAL="\[\033[0;0m\]"
#  local USER="if [ `id -u` == "0" ]; then echo \"${RED}\"; else echo \"${CYAN}\"; fi"
  local SMILEY="${GREEN}:)${NORMAL}"
  local FROWNY="${RED}:(${NORMAL}"
  local SELECT="if [ $? = 0 ]; then echo \"${SMILEY}\"; else echo \"${FROWNY}\"; fi"
  local SELECT2="${SELECT}"
export PS1="${NORMAL}[${CYAN}\u${NORMAL}@${YELLOW}\h${NORMAL}]  ${WHITEBOLD}\w${NORMAL}  \\$ "
}

prompt


## Filelisting
alias ls='ls -hlAG'
alias ll='ls -hlAG'

## Processes
alias tu='top -o cpu' #cpu
alias tm='top -o vsize' #memory

## Finds
alias findn='find . -name '"${1}"''

## Various
alias df='df -h'
alias h='history'
alias cdd='cd -'
alias claer='clear'
alias ip='ipconfig getifaddr en0' #internal IP
alias count='du -a | cut -d/ -f2 | sort | uniq -c | sort -nr'
alias grep='grep --colour'
alias psaux='ps aux | grep -v grep | grep -i'
#alias mytree='find . -type d | sed -e 1d -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|-/''
alias bak='cp "${1}" "${1}.bak"'
alias routeprint='netstat -r'
# Also always useful - external IP address
alias ipext='curl -s http://checkip.dyndns.org/ | grep -o [0-9][0-9]*.[0-9][0-9]*.[0-9][0-9]*.[0-9]*'



### Startup messages
clear
echo "Welcome to "`scutil --get ComputerName`"/"`ipconfig getifaddr en0` "["`sw_vers -productName`"@"`sw_vers -productVersion`"]"
df -hl | grep 'disk0s2' | awk '{print $4"/"$2" free ("$5" used)"}'
w