#! /bin/bash
if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -G'
  alias ll='ls -alFG'
  alias la='ls -AG'
  alias l='ls -CFG'
fi

if type tig > /dev/null 2>&1 ; then
  alias tig='tig status'
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
