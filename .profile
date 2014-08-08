#
# LANG
#
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

#
# DEV
#
INCLUDEDIR="$HOME/opt/include"
LIBDIR="$HOME/opt/lib"
ARC="-m64" #"-arch i386"

case "${OSTYPE}" in
freebsd*)
    ;;
darwin*)
    PATH="/usr/local/bin/:$PATH" # brew
    ;;
linux*)
    INCLUDEDIR="/usr/include -I$INCLUDEDIR"
    LIBDIR="/usr/lib -L$LIBDIR"
    # for rubygems
    PATH="/var/lib/gems/1.8/bin/:$PATH"
    ;;
esac

#export ARCHFLAGS="$ARC"
#export CFLAGS="-I$INCLUDEDIR $ARC"
#export CXXFLAGS="-I$INCLUDEDIR $ARC"
#export LDFLAGS="-L$LIBDIR $ARC"

#
# PATH
#
BINDIR="$HOME/opt/bin"
PATH="$BINDIR:$PATH"

#
# TERM
#
export TERM="xterm-color"

export PATH="/Applications/microchip/xc8/v1.20/bin":$PATH
