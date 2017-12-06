# If MANPATH is empty, Lmod is adding a trailing ":" so that the system MANPATH will be found
export MANPATH=":$MANPATH"

shell=`/bin/basename $(/bin/readlink /proc/$$/exe)`

if [ -f /gpfs/software/lua_lmod/lmod/lmod/init/$shell ]
then

    export PATH=/gpfs/software/lua_lmod/lmod/lmod/libexec:$PATH
    . /gpfs/software/lua_lmod/lmod/lmod/init/$shell
    export LMOD_DISABLE_SAME_NAME_AUTOSWAP=yes
    export LMOD_SITE_MSG_FILE="/gpfs/software/lua_lmod/lmod/ubelix/site_msgs.lua"
    export MODULEPATH="/gpfs/software/el7/modulefiles/all"
fi
