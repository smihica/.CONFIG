#
# LANG
#
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

case "${OSTYPE}" in
netbsd*)
    ;;
freebsd*)
    # export C_INCLUDE_PATH=/usr/local/include/:${C_INCLUDE_PATH}
    # export CPLUS_INCLUDE_PATH=/usr/local/include/:${CPLUS_INCLUDE_PATH}
    export PATH="/usr/opt/bin:$PATH" # manual install binaries
    export PATH="$HOME/.roswell/bin/:$PATH"
    ;;
darwin*)
    export PATH="/usr/local/bin/:$PATH" # brew
    # Java
    export PATH=$PATH:"/usr/local/apache-maven-3.2.5/bin"
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_77.jdk/Contents/Home"
    # android
    export PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"
    # nodebrew
    export PATH=$PATH:"$HOME/.nodebrew/current/bin"
    # gcc-arm-none-eabi
    export PATH=$PATH:"/usr/local/gcc-arm/gcc-arm-none-eabi-5_4-2016q3/bin"
    # rust
    source $HOME/.cargo/env
    # esp32
    export IDF_PATH="/opt/esp/esp-idf"
    export PATH=$PATH:"/opt/esp/xtensa-esp32-elf/bin"
    export PYTHONPATH="/Users/smihica/Library/Python/2.7/"
    export C_INCLUDE_PATH="/usr/local/include"
    export CPLUS_INCLUDE_PATH="/usr/local/include"
    # go
    export GOPATH="/opt/go"
    export PATH="$GOPATH/bin:$PATH"
    ;;
linux*)
    INCLUDEDIR="/usr/include -I$INCLUDEDIR"
    LIBDIR="/usr/lib -L$LIBDIR"
    # for rubygems
    PATH="/var/lib/gems/1.8/bin/:$PATH"
    ;;
esac

# roswell
PATH="$HOME/.roswell/bin:$PATH"

#
# TERM
#
export TERM="xterm-256color"
export PATH="$HOME/.cargo/bin:$PATH"
