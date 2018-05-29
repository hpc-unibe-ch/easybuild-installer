#!/bin/bash

set -e

# Source settings file
workdir=$(dirname -- $(readlink -f $0))
source $workdir/settings.sh

# Check for python-setuptools, which is required for EB
if ! type easy_install >/dev/null 2>&1
then
  echo "Cannot find python-setuptools. These are required for EasyBuild."
  exit 1
fi

if [[ "$MODULEPATH" =~ el7-broadwell ]]
then
  EB_PREFIX=${BASE}/el7-broadwell
elif [[ "$MODULEPATH" =~ el7-ivy ]]
then
  EB_PREFIX=${BASE}/el7-ivy
elif [[ "$MODULEPATH" =~ el7-sandy ]]
then
  EB_PREFIX=${BASE}/el7-sandy
else
  echo "ATTENTION!!! EASYBUILD PLATFORM NOT SET!!"
  exit
fi

#
# EasyBuild installation
#
# download script

# Place config
#for configdir in $workdir/config/*
#do
#  ln -s $configdir $HOME/.$(basename $configdir)
#done

curl -O https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py

# bootstrap EasyBuild
export EASYBUILD_SUBDIR_SOFTWARE=${EB_SUBDIR_SOFTWARE}
export EASYBUILD_SUBDIR_MODULES=${EB_SUBDIR_MODULES}
export EASYBUILD_BUILDPATH=/dev/shm
python bootstrap_eb.py $EB_PREFIX
rm -f bootstrap_eb.py

# Maybe update by:
# eb --install-latest-eb-release
