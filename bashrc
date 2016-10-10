# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Get full path
function get_path() {
  f=$@
  if [ -d "${f}" ]; then
    base=""
    dir="${f}"
  else
    base="/$(basename "${f}")"
    dir=$(dirname "${f}")
  fi
  dir=$(builtin cd "${dir}" && /bin/pwd)
  echo "${dir}${base}"
}

# Is git repository
function is_repository() {
  local result=false
  local readonly dirorg=`pwd`
  while [ `pwd` != '/' ] ; do
    if [ -e './.git' ]; then
      result=true
      break
    else
      builtin cd ../
    fi
  done
  builtin cd ${dirorg}
  echo ${result}
}

# Show the git status
function git_status() {

  if $(is_repository) && type git > /dev/null 2>&1 ; then
    # Colors
    local readonly BRANCH_NAME_COLOR='\033[00;36m'
    local readonly ADD_STATUS_COLOR='\033[01;33m'
    local readonly DEL_STATUS_COLOR='\033[01;31m'
    local readonly COM_STATUS_COLOR='\033[01;32m'
    local readonly NEW_STATUS_COLOR='\033[01;35m'
    local readonly RESET='\033[00m'
    # Git information
    local readonly BRANCH_NAME=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
    local readonly GIT_STATUS=`git status --porcelain 2> /dev/null`
    local readonly GIT_ADD_WAITS="`echo "${GIT_STATUS}" | grep '^[AD ]M' | wc -l`"
    local readonly GIT_DEL_WAITS="`echo "${GIT_STATUS}" | grep '^[MA ]D' | wc -l`"
    local readonly GIT_COM_WAITS="`echo "${GIT_STATUS}" | grep '^[MADR]' | wc -l`"
    local readonly GIT_NEW_WAITS="`echo "${GIT_STATUS}" | grep '^??' | wc -l`"

    local stat=${BRANCH_NAME_COLOR}
    [ "${BRANCH_NAME}" = "" ] && stat=${stat}'master' || stat=${stat}${BRANCH_NAME}
    if [ ${GIT_ADD_WAITS} -gt 0 ]; then
      stat=${stat}${ADD_STATUS_COLOR}' +:'${GIT_ADD_WAITS}
    fi
    if [ ${GIT_COM_WAITS} -gt 0 ]; then
      stat=${stat}${COM_STATUS_COLOR}' *:'${GIT_COM_WAITS}
    fi
    if [ ${GIT_NEW_WAITS} -gt 0 ]; then
      stat=${stat}${NEW_STATUS_COLOR}' !:'${GIT_NEW_WAITS}
    fi
    if [ ${GIT_DEL_WAITS} -gt 0 ]; then
      stat=${stat}${DEL_STATUS_COLOR}' -:'${GIT_DEL_WAITS}
    fi
    stat=${stat}${RESET}

    echo -e ' ('${stat}')'
  else
    echo ''
  fi
}

# put prompt message
function prompt() {
  # Colors
  local readonly USER_COLOR='\033[00;35m'
  local readonly HOST_COLOR='\033[00;33m'
  local readonly PWD_COLOR='\033[00;32m'
  local readonly GIT_COLOR='\033[00;36m'
  local readonly RESET='\033[00m'

  local ps=''
  ps=${ps}${USER_COLOR}"\u"
  ps=${ps}${RESET}" at "
  ps=${ps}${HOST_COLOR}"\h"
  ps=${ps}${RESET}" in "
  ps=${ps}${PWD_COLOR}"\w"
  ps=${ps}${RESET}'$(git_status)'
  ps=${ps}${RESET}

  echo -e ${ps}
}

# If not running interactively, don't do anything
case $- in
  *i*) ;;
  *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  export PS1="\n${debian_chroot:+($debian_chroot)}[\t] $(prompt)\n\$ "
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

if [ "$(uname)" == 'Darwin' ]; then
  export LSCOLORS=gxfxcxdxbxegedabagacad
  # export LSCOLORS=xbfxcxdxbxegedabagacad
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
elif [ -f ~/.bash/bash_aliases ]; then
  . ~/.bash/bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  elif [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
  fi
fi

# inputrc
if [ -f ~/.inputrc ]; then
  . ~/.inputrc
# elif [ -f ~/.bash/inputrc ]; then
else
  . ~/.bash/inputrc
fi

# Default editor
export EDITOR=vim
# Locale
export LANG=ja_JP.UTF-8

# Start tmux
if [[ -z "$TMUX" && -z "$WINDOW" && ! -z "$PS1" ]] && `who | awk '{print $2;}' | grep tty > /dev/null 2>&1` ; then
  if $(tmux has-session 2> /dev/null); then
    tmux attach -d
  else
    tmux
  fi
fi
