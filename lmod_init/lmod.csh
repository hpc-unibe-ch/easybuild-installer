if ( -f  /gpfs/software/lua_lmod/lmod/lmod/init/csh  ) then
  source /gpfs/software/lua_lmod/lmod/lmod/init/csh
endif

setenv LMOD_DISABLE_SAME_NAME_AUTOSWAP "yes"
setenv LMOD_SITE_MSG_FILE "/gpfs/software/lua_lmod/lmod/ubelix/site_msgs.lua"
setenv MODULEPATH="/gpfs/software/el7/modulefiles/all"
