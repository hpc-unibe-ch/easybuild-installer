#!/bin/bash

set -e

# Source settings file
source $(dirname $0)/settings.sh

# Remove old stuff
rm -rf $LMOD_PREFIX
rm -rf /etc/modulefiles
rm -rf /gpfs/software/ubelix-el7/*
yum -y erase environment-modules

yum -y install git patch
yum -y install python-setuptools
#yum -y install lua-posix lua-filesystem lua-json lua-lpeg lua-term
#yum -y install ncurses-static readline-static

#ln -sf $LMOD_PREFIX/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh
#ln -sf $LMOD_PREFIX/lmod/lmod/init/cshrc   /etc/profile.d/z00_lmod.csh
mkdir -p $LMOD_PREFIX
chown $UNPRIV_USER:root $LMOD_PREFIX
