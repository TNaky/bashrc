#! /bin/bash
if [ "$(uname)" == 'Darwin' ]; then
  alias ls='ls -G'
  alias ll='ls -alFG'
  alias la='ls -AG'
  alias l='ls -CFG'
fi
