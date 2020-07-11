#!/usr/bin/env bash
set -euo pipefail

mkdir -p EXTOOLS
cd EXTOOLS
git init
git remote add origin https://github.com/Putnam3145/extools.git
git fetch --depth 1 origin
git checkout just-monstermos

cmake ./byond-extools 
make

ln -sf $PWD/libbyond-extools.so ../libbyond-extools.so
