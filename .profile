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
    export PATH="/usr/local/bin:/usr/local/sbin:$PATH" # brew
    # Java
    export PATH=$PATH:"/usr/local/apache-maven-3.2.5/bin"
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-11.0.5.jdk/Contents/Home"
    # android
    export PATH=$PATH:"$HOME/Library/Android/sdk/platform-tools"
    export PATH=$PATH:"$HOME/Library/Android/sdk/tools/bin"
    export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk-bundle"
    export PATH=$PATH:"$ANDROID_NDK_HOME"
    # nodebrew
    export PATH=$PATH:"$HOME/.nodebrew/current/bin"
    # rust
    source $HOME/.cargo/env
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/library"
    # esp32
    alias activate_esp='. /opt/esp/esp-idf/export.sh'
    # esp32-old
    # export IDF_PATH="/opt/esp/esp-idf"
    # export PATH=$PATH:"/opt/esp/xtensa-esp32-elf/bin"
    # export PYTHONPATH="/Users/smihica/Library/Python/2.7/"
    # export C_INCLUDE_PATH="/usr/local/include:$C_INCLUDE_PATH"
    # export CPLUS_INCLUDE_PATH="/usr/local/include:$CPLUS_INCLUDE_PATH"
    # go
    export GOPATH="/opt/go"
    export PATH="$GOPATH/bin:$PATH"
    # gettext
    export PATH="/usr/local/opt/gettext/bin:$PATH"
    # flutter
    export PATH="/opt/flutter/bin:$PATH"
    # ros
    export PATH="~/.roswell/bin:$PATH"
    # llvm
    export PATH="/usr/local/Cellar/llvm/10.0.0_3/bin:$PATH"
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

# emacs
alias emacs='emacs -nw'

#
# TERM
#
export TERM="xterm-256color"
export PATH="$HOME/.cargo/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh
