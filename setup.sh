#!/bin/bash

set -e

if [[ -d ~/.vim/bundle/ctrlp-cmatcher ]]; then
  echo "Compiling C ext for ctrlp-cmatcher"
  cd ~/.vim/bundle/ctrlp-cmatcher
  ./install.sh
  cd -
fi
