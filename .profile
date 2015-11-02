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

export PATH=$PATH:"/Applications/microchip/xc8/v1.20/bin"
export PATH=$PATH:"/Applications/microchip/xc16/v1.23/bin"

# Java
export PATH=$PATH:"/usr/local/apache-maven-3.2.5/bin"
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home"

# android
export PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"
