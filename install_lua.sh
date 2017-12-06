#!/bin/bash

set -e

# Source settings file
workdir=$(dirname -- $(readlink -f $0))
source $workdir/settings.sh

#
# Lua installation
#
if [ ! -f tmp/lua-${LUA_VERSION}.tar.bz2 ]
then
  curl -L http://sourceforge.net/projects/lmod/files/lua-${LUA_VERSION}.tar.bz2/download -o tmp/lua-${LUA_VERSION}.tar.bz2
fi

tar xf tmp/lua-${LUA_VERSION}.tar.bz2
cd lua-${LUA_VERSION}
./configure --with-static=yes --prefix=${LUA_PREFIX}/${LUA_VERSION} && make && make install
cd $LUA_PREFIX
ln -s ${LUA_VERSION} lua
cd $workdir && rm -rf lua-${LUA_VERSION}


echo "Lua installed in ${LUA_PREFIX}/${LUA_VERSION} and linked to ${LUA_PREFIX}/lua"

exit 0
