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
    --with-module-root-path=${EB_PREFIX}/${EB_SUBDIR_MODULES} \
    --with-spiderCacheDir=${LMOD_PREFIX}/lmod/lmod_cache \
    --with-updateSystemFn=${LMOD_PREFIX}/lmod/lmod_cache/cache_updated \
    --with-mpathSearch=YES \
    --with-caseIndependentSorting=YES \
    --with-pinVersions=YES \
    --with-cachedLoads=YES \
    --with-siteName=$SITE_NAME \
    --with-siteMsgFile=${EB_PREFIX}/lmod/site_msgs.lua
make
make install
cd ..
rm -rf Lmod-${LMOD_VERSION}

# This shouldn't be here probalby...
mkdir -p ${EB_PREFIX}/lmod
cp $workdir/lmod_init/lmod.sh ${EB_PREFIX}/lmod/lmod.sh
cp $workdir/lmod_init/lmod.csh ${EB_PREFIX}/lmod/lmod.csh
cp $workdir/lmod_init/site_msgs.lua ${EB_PREFIX}/lmod/site_msgs.lua

echo "You now have to make the module function available by sourcing lmod.sh."

exit 0
