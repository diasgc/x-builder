#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  -   -   -   -   .   .   .   .   .   .   .  static
#  -   -   -   -   .   .   .   .   .   .   .  shared
#  +   +   +   +   .   .   .   .   .   .   .  bin

lib='file-signature'
dsc='-'
lic='MIT'
src='https://github.com/jinhr9801/filename-extension-signature.git'
sty='git'
cfg=''
eta='30'


. xbuilder.sh

[[ "$arch" == *"mingw32" ]] && ext='.exe'
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
    pushdir $SRCDIR
    $CC -o file-signature${ext} ff_file_formats.c main.c
    mkdir -p $INSTALL_DIR/include $INSTALL_DIR/lib $INSTALL_DIR/bin
    mv file-signature${ext} $INSTALL_DIR/bin
    cp ff_file_formats.h $INSTALL_DIR/include
    popd >/dev/null
}
# Use function buildPC to manually build pkg-config .pc file
distPackage(){
    pushdir $INSTALL_DIR
    tar -czvf "${1}.tar.gz" include/ff_file_formats.h bin/file-signature${ext}
}
start
