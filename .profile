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
    PATH="/opt/local/bin/:$PATH" # ports
    PATH="/opt/local/lib/postgresql91/bin/:$PATH" # postgresql
    # for Android
    ANDROID_NDK_HOME="/Users/smihica/opt/sdk/android-ndk"
    ANDROID_SDK_TOOLS="/Users/smihica/opt/sdk/android-sdk-macosx/tools"
    ANDROID_SDK_PLATFORM_TOOLS="/Users/smihica/opt/sdk/android-sdk-macosx/platform-tools/"
    # for mysql
    MYSQL_BIN="/usr/local/mysql/bin/"
    PATH="$ANDROID_NDK_HOME:$ANDROID_SDK_TOOLS:$ANDROID_SDK_PLATFORM_TOOLS:$MYSQL_BIN:$PATH"
    # for go
    PATH="/usr/local/go/bin:$PATH"
    # for llvm
    PATH="/opt/local/libexec/llvm-3.2/bin:$PATH"
    # macports include and lib
    INCLUDEDIR="/opt/local/include -I$INCLUDEDIR"
    LIBDIR="/opt/local/lib -L$LIBDIR"
    # llvm
    INCLUDEDIR="/opt/local/libexec/llvm-3.2/include -I$INCLUDEDIR"
    LIBDIR="/opt/local/libexec/llvm-3.2/lib -L$LIBDIR"
    ;;
linux*)
    INCLUDEDIR="/usr/include -I$INCLUDEDIR"
    LIBDIR="/usr/lib -L$LIBDIR"
    # for rubygems
    PATH="/var/lib/gems/1.8/bin/:$PATH"
    ;;
esac

export ARCHFLAGS="$ARC"
export CFLAGS="-I$INCLUDEDIR $ARC"
export CXXFLAGS="-I$INCLUDEDIR $ARC"
export LDFLAGS="-L$LIBDIR $ARC"

#
# PATH
#
BINDIR="$HOME/opt/bin"
PATH="$BINDIR:$PATH"

#
# TERM
#
export TERM="xterm-color"
