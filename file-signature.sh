#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='file-signature'
dsc=''
lic='MIT'
src='https://github.com/jinhr9801/filename-extension-signature.git'
sty='git'
cfg=''
tls=''
dep=''
pkg='file-signature'

eta='30'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(223 0 0 0 0 0 0 0 0 0 0)
ls1=(187 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
dbld=$SRCDIR
loadToolchain
[[ $arch = *mingw32 ]] && ext='.exe'
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
    pushd $SRCDIR >/dev/null
    $CC -o file-signature${ext} ff_file_formats.c main.c
    mkdir -p $INSTALL_DIR/include $INSTALL_DIR/lib $INSTALL_DIR/bin
    mv file-signature${ext} $INSTALL_DIR/bin
    cp ff_file_formats.h $INSTALL_DIR/include
    popd >/dev/null
}
# Use function buildPC to manually build pkg-config .pc file

start