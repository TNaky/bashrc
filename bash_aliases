#! /bin/bash
if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -hG'
  alias ll='ls -alhFG'
  alias la='ls -hAG'
  alias l='ls -hCFG'
fi

if type tig > /dev/null 2>&1 ; then
  alias tig='tig status'
fi

if type nvim > /dev/null 2>&1 ; then
  alias vim='nvim'
fi

cd() {
  if [ $# -gt 0 ]; then
    current=`pwd`
    destination=$(get_path $1)
    if [ "${current}" != "${destination}" ] || [[ `echo $1` =~ ^\+[0-9]+$ ]]; then
      pushd $1 > /dev/null
    fi
  elif [ `pwd` != "${HOME}" ]; then
    pushd "${HOME}" > /dev/null
  fi
}

alias dirs='dirs -v'
