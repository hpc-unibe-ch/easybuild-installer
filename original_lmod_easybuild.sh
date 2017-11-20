#!/bin/bash

set -e

UNPRIV_USER=`whoami`
LMOD_VERSION=7.4.17
LMOD_PREFIX=/gpfs/software/ubelix-el7
EASYBUILD_PREFIX=$HOME/.local/easybuild

# Remove old stuff
rm -rf /etc/modulefiles
yum -y erase environment-modules

#sudo yum -y install epel-release git patch
sudo yum makecache
sudo yum -y install lua lua-devel lua-posix lua-filesystem lua-json lua-lpeg lua-term tcl

#
# Lmod installation
#
curl -L https://github.com/TACC/Lmod/archive/${LMOD_VERSION}.tar.gz -o Lmod-${LMOD_VERSION}.tar.gz
tar xf Lmod-${LMOD_VERSION}.tar.gz
cd Lmod-${LMOD_VERSION}
./configure --prefix=$LMOD_PREFIX --with-siteName="UBELIX"
sudo make install
sudo ln -sf $LMOD_PREFIX/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh
sudo ln -sf $LMOD_PREFIX/lmod/lmod/init/cshrc   /etc/profile.d/z00_lmod.csh
#sudo patch $LMOD_PREFIX/lmod/lmod/init/profile < /vagrant/lmod-profile.diff

#
# EasyBuild installation
#
#sudo chown ${UNPRIV_USER}:root $LMOD_PREFIX
# download script
#curl -O https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py
# bootstrap EasyBuild
#python bootstrap_eb.py $EASYBUILD_PREFIX
#module use $EASYBUILD_PREFIX/modules/all

#mkdir -p /opt/{modules,software}
#chmod 777 /opt/{modules,software}
