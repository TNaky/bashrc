#!/bin/bash
git clone https://github.com/TNaky/bashrc.git ${HOME}/.bash
if [ -f "${HOME}/.bashrc" ]; then
  mv ${HOME}/.bashrc ${HOME}/.bash/bashrc.orig
  ln -s ${HOME}/.bash/bashrc ${HOME}/.bashrc
  echo "Original .bashrc file has been moved to"
  echo -e '  \033[01;33m'\"${HOME}/.bash/bashrc.orig\"'\033[00m'
else
  ln -s ${HOME}/.bash/bashrc ${HOME}/.bashrc
fi

if [ -f "${HOME}/.bash_profile" ]; then
  mv ${HOME}/.bash_profile ${HOME}/.bash/bash_profile.orig
  ln -s ${HOME}/.bash/bash_profile ${HOME}/.bash_profile
  echo "Original .bash_profile file has been moved to"
  echo -e '  \033[01;33m'\"${HOME}/.bash/bash_profile.orig\"'\033[00m'
else
  ln -s ${HOME}/.bash/bash_profile ${HOME}/.bash_profile
fi

if [ -f "${HOME}/.inputrc " ]; then
  mv ${HOME}/.inputrc ${HOME}/.bash/inputrc.orig
  ln -s ${HOME}/.bash/inputrc ${HOME}/.inputrc
  echo "Original .inputrc file has been moved to"
  echo -e '  \033[01;33m'\"${HOME}/.bash/inputrc.orig\"'\033[00m'
else
  ln -s ${HOME}/.bash/inputrc ${HOME}/.inputrc
fi
