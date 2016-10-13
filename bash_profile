if [ -f ~/.bash/checkUpdate.sh ]; then
  bash ~/.bash/checkUpdate.sh
fi
if [ -f ~/.bashrc ] ; then
  . ~/.bashrc
elif [ -f ~/.bash/bashrc ]; then
  . ~/.bash/bashrc
fi
