if ( -f /software.el7/lmod/lmod/init/csh  ) then
  source /software.el7/lmod/lmod/init/csh
endif

#setenv LMOD_DISABLE_SAME_NAME_AUTOSWAP "yes"
# Avoid user spider cache generation
setenv LMOD_SITE_MSG_FILE "/software.el7/lmod/eth/site_msgs.lua"
setenv MODULEPATH="/software.el7/modulefiles/all"
