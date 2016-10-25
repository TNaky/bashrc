#!/bin/bash
if [ "$(uname)" == "Darwin" ]; then
  echo "Please use bash and git of brew"
  echo -e '  \033[00;33m'brew install bash bash-completion git'\033[00m'
  echo "How to install Homebrew"
  echo -e '  \033[00;34m'http://brew.sh/index_ja.html'\033[00m'
fi

if [[ $(type git 2> /dev/null) ]]; then
  if [ -d ${HOME} ]; then
    git -C ${HOME}/.bash/.git pull
  else
    git clone https://github.com/TNaky/bashrc.git ${HOME}/.bash
  fi
  
  if [ -f "${HOME}/.bashrc" ]; then
    mv ${HOME}/.bashrc ${HOME}/.bash/bashrc.orig
    ln -s ${HOME}/.bash/bashrc ${HOME}/.bashrc
    echo "Original .bashrc file has been moved to"
    echo -e '  \033[01;33m'\"${HOME}/.bash/bashrc.orig\"'\033[00m'
  else
    ln -s ${HOME}/.bash/bashrc ${HOME}/.bashrc
  fi
  
  if [ "$(uname)" == "Darwin" ]; then
    if [ -f "${HOME}/.bash_profile" ]; then
      mv ${HOME}/.bash_profile ${HOME}/.bash/bash_profile.orig
      ln -s ${HOME}/.bash/bash_profile ${HOME}/.bash_profile
      echo "Original .bash_profile file has been moved to"
      echo -e '  \033[01;33m'\"${HOME}/.bash/bash_profile.orig\"'\033[00m'
    else
      ln -s ${HOME}/.bash/bash_profile ${HOME}/.bash_profile
    fi
  elif [ "$(uname)" == "Linux" ]; then
    if [ -f "${HOME}/.profile" ]; then
      mv "${HOME}/.profile" "${HOME}/.bash/profile.orig"
      ln -s "${HOME}/.bash/bash_profile" "${HOME}/.profile"
      echo "Original .profile file has been moved to"
      echo -e '  \033[01;33m'\"${HOME}/.bash/profile.orig\"'\033[00m'
    else
      ln -s "${HOME}/.bash/bash_profile" "${HOME}/.profile"
    fi
  fi
  
  if [ -f "${HOME}/.inputrc " ]; then
    mv ${HOME}/.inputrc ${HOME}/.bash/inputrc.orig
    ln -s ${HOME}/.bash/inputrc ${HOME}/.inputrc
    echo "Original .inputrc file has been moved to"
    echo -e '  \033[01;33m'\"${HOME}/.bash/inputrc.orig\"'\033[00m'
  else
    ln -s ${HOME}/.bash/inputrc ${HOME}/.inputrc
  fi
else
  echo -e '\033[00;31m'"Git is not installed.\nPlease git install"'\033[00m'
  echo -e "  MacOSX: "'\033[00;33m'"brew install git"'\033[00m'
  echo -e "  Ubuntu: "'\033[00;33m'"sudo aptitude install git"'\033[00m'
fi
