#!/bin/bash

if [[ -d ~/.vim/bundle/ctrlp-cmatcher ]] && [[ ! -f ~/.vim/bundle/ctrlp-cmatcher/autoload/fuzzycompt.so ]]; then
  echo "Compiling C ext for ctrlp-cmatcher"
  ( cd ~/.vim/bundle/ctrlp-cmatcher && ./install.sh )
fi
