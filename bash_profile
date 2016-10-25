if [ -n "${BASH_VERSION}" ]; then
  if [ -f "${HOME}/.bashrc" ] ; then
    . "${HOME}/.bashrc"
  elif [ -f "${HOME}/.bash/bashrc" ]; then
    . "${HOME}/.bash/bashrc"
  fi
fi
