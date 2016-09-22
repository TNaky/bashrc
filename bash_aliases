#! /bin/bash
if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -G'
  alias ll='ls -alFG'
  alias la='ls -AG'
  alias l='ls -CFG'
fi

cd() {
  if [ $# -gt 0 ]; then
    current=(`pwd | tr -s '/' ' '`)
    current=${current[((${#current[@]}-1))]}
    destination=(`echo "$1" | tr -s '/' ' '`)
    destination=${destination[((${#destination[@]}-1))]}
    if [ "${current}" != "${destination}" ] || [[ `echo $1` =~ ^\+[0-9]+$ ]]; then
      pushd $1 > /dev/null
    fi
  elif [ `pwd` != "${HOME}" ]; then
    pushd "${HOME}" > /dev/null
  fi
}

alias dirs='dirs -v'
