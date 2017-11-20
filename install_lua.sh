#!/bin/bash

set -e

# Source settings file
source $(dirname $0)/settings.sh

#
# Lua installation
#
rm -rf lua-${LUA_VERSION}
if [ ! -f lua-${LUA_VERSION}.tar.gz ]
then
  curl -L http://sourceforge.net/projects/lmod/files/lua-${LUA_VERSION}.tar.gz/download -o lua-${LUA_VERSION}.tar.gz
fi
tar xf lua-${LUA_VERSION}.tar.gz
cd lua-${LUA_VERSION}
./configure --with-static=yes --prefix=${LUA_PREFIX} && make && make install
cd ..
export PATH=$LMOD_PREFIX/lua/bin:$PATH
echo $PATH

