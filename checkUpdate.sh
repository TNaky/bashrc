#!/bin/bash
tmpDir=`wpd`
cd ${HOME}/.bash
if [[ $(git remote show origin | tail -n 1) =~ "local out of date" ]]; then
  git pull 
fi
cd ${tmpDir}
