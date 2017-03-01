#! /bin/bash

alias dirs='dirs -v'

if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -hG'
  alias ll='ls -alhFG'
  alias la='ls -hAG'
  alias l='ls -hCFG'
fi

if type tig > /dev/null 2>&1 ; then
  alias tig='tig status'
fi

get_dirs() {
  local dirsList="$(builtin dirs -p -l)"
  [ $# -gt 0 ] && local destination="$(get_path $1)" || local destination="${HOME}"
  local num=$(echo "${dirsList}" | grep -x -n "${destination}" | sed -e 's/:.*//g')
  if [ "${num}" != "" ]; then
    local num=$(expr ${num} - 1)
    echo ${num}
  fi
}

cd() {
  local num=$(get_dirs $1)
  if [ "${num}" != "" ]; then
    pushd "+${num}" > /dev/null
  elif [ $# -gt 0 ]; then
    pushd "$1" > /dev/null
  else
    pushd "${HOME}" > /dev/null
  fi
}
