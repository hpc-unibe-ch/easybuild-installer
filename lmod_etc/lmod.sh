# If MANPATH is empty, Lmod is adding a trailing ":" so that the system MANPATH will be found
export MANPATH=":$MANPATH"

shell=`/bin/basename $(/bin/readlink /proc/$$/exe)`

if [ -f /software.el7/lmod/lmod/init/$shell ]
then

    export PATH=/software.el7/lmod/lmod/libexec:$PATH
    . /software.el7/lmod/lmod/init/$shell
    #export LMOD_DISABLE_SAME_NAME_AUTOSWAP=yes
    # Avoid user spider cache generation
    export LMOD_SITE_MSG_FILE="/software.el7/lmod/etc/site_msgs.lua"
    export MODULEPATH="/software.el7/modulefiles/all"
fi
