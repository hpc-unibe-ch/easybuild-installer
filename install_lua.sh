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
./configure --with-static=yes --prefix=${LUA_PREFIX}/${LUA_VERSION} && make && make install
cd $LUA_PREFIX
ln -s ${LUA_VERSION} lua

echo "Lua installed in ${LUA_PREFIX}/${LUA_VERSION} and linked to ${LUA_PREFIX}/lua"

