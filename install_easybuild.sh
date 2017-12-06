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

#
# EasyBuild installation
#
# download script

# Place config
mkdir -p $HOME/.config/easybuild
cp eb-config-${SITE_NAME} $HOME/.config/easybuild/config.cfg

curl -O https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py

# bootstrap EasyBuild
#export EASYBUILD_INSTALLPATH_SOFTWARE=${EB_PREFIX}/apps
#export EASYBUILD_INSTALLPATH_MODULES=${MODULE_ROOT_PATH}
export EASYBUILD_SUBDIR_MODULES=${EB_SUBDIR_MODULES}
export EASYBUILD_BUILDPATH=/dev/shm
python bootstrap_eb.py $EB_PREFIX
rm -f bootstrap_eb.py

# Maybe update by:
# eb --install-latest-eb-release
