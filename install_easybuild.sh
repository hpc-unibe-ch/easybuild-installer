#!/bin/bash

set -e

# Source settings file
workdir=$(dirname -- $(readlink -f $0))
source $workdir/settings.sh

#
# EasyBuild installation
#
# download script
rm -f bootstrap_eb.py
curl -O https://raw.githubusercontent.com/hpcugent/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py

# bootstrap EasyBuild
export EASYBUILD_INSTALLPATH_SOFTWARE=${EB_PREFIX}/apps
export EASYBUILD_INSTALLPATH_MODULES=${EB_PREFIX}/modules
export EASYBUILD_BUILDPATH=/dev/shm
python bootstrap_eb.py $EB_PREFIX

mkdir -p $HOME/.config/easybuild
ln -sf $workdir/eb-config.cfg $HOME/.config/easybuild/config.cfg

# Maybe update by:
# eb --install-latest-eb-release
