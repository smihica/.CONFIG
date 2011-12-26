#
# LANG
#
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

INCLUDEDIR="$HOME/opt/include"
LIBDIR="$HOME/opt/lib"
ARC= # "-arch i386" #-arch X86_64

export ARCHFLAGS="$ARC"
export CFLAGS="-I$INCLUDEDIR $ARC"
export CXXFLAGS="-I$INCLUDEDIR $ARC"
export LDFLAGS="-L$LIBDIR $ARC"

