#!/bin/bash

set -e

# Source settings file
workdir=$(dirname -- $(readlink -f $0))
source $workdir/settings.sh

export PATH=$LUA_PREFIX/lua/bin:$PATH
echo "Lua used to link against: "`which lua`

#
# Lmod installation
#
if [ ! -f tmp/Lmod-${LMOD_VERSION}.tar.gz ]
then
  curl -L https://github.com/TACC/Lmod/archive/${LMOD_VERSION}.tar.gz -o tmp/Lmod-${LMOD_VERSION}.tar.gz
fi
tar xf tmp/Lmod-${LMOD_VERSION}.tar.gz
cd Lmod-${LMOD_VERSION}

# Configure Lmod witch certain defaults.
#    --with-disableNameAutoSwap=YES \  currently not used but here as a reminder
#
./configure \
    --with-lua-include=${LUA_PREFIX}/lua/include \
    --prefix=${LMOD_PREFIX} \
    --with-spiderCacheDir=${LMOD_PREFIX}/lmod/lmod_cache \
    --with-updateSystemFn=${LMOD_PREFIX}/lmod/lmod_cache/cache_updated \
    --with-mpathSearch=YES \
    --with-caseIndependentSorting=YES \
    --with-pinVersions=YES \
    --with-cachedLoads=YES \
    --with-siteName=$SITE_NAME \
    --with-siteMsgFile=${LMOD_PREFIX}/lmod/etc/ubelix_site_msgs.lua
make
make install
rm -rf Lmod-${LMOD_VERSION}

mkdir ${LMOD_PREFIX}/lmod/ubelix
cp lmod_init/lmod.sh ${LMOD_PREFIX}/lmod/ubelix/lmod.sh
cp lmod_init/lmod.csh ${LMOD_PREFIX}/lmod/ubelix/lmod.csh
cp lmod_init/site_msgs.lua ${LMOD_PREFIX}/lmod/ubelix/site_msgs.lua

exit 0
