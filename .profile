#
# LANG
#
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LANG=ja_JP.UTF-8
export LC_CTYPE=ja_JP.UTF-8

#
# DEV
#
INCLUDEDIR="$HOME/opt/include"
LIBDIR="$HOME/opt/lib"
ARC="-m64" #"-arch i386"

export ARCHFLAGS="$ARC"
export CFLAGS="-I$INCLUDEDIR $ARC"
export CXXFLAGS="-I$INCLUDEDIR $ARC"
export LDFLAGS="-L$LIBDIR $ARC"

#
# Android NDK
#
ANDROID_NDK_HOME="/Users/smihica/opt/sdk/android-ndk"
ANDROID_SDK_TOOLS="/Users/smihica/opt/sdk/android-sdk-macosx/tools"
ANDROID_SDK_PLATFORM_TOOLS="/Users/smihica/opt/sdk/android-sdk-macosx/platform-tools/"

#
# PATH
#
BINDIR="$HOME/opt/bin"
PATH="$HOME/opt/bin:$ANDROID_NDK_HOME:$ANDROID_SDK_TOOLS:$ANDROID_SDK_PLATFORM_TOOLS:$PATH"
PATH="$HOME/code/altair/env/bin/:$PATH"
PATH="/usr/local/mysql/bin/:$PATH"

# for mac
PATH="/opt/local/bin/:$PATH" # ports
PATH="/opt/local/lib/postgresql91/bin/:$PATH" # postgresql

#
# TERM
#
export TERM="xterm-color"
