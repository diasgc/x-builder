#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='zlib'
dsc='zlib compression library'
lic=''
src='https://github.com/madler/zlib.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='zlib'

eta='22'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0="-DBUILD_TOOLS=OFF"
cb1="-DBUILD_TOOLS=ON"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="-DINSTALL_PKGCONFIG_DIR=${INSTALL_DIR}/lib/pkgconfig"
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
    [ -f $INSTALL_DIR/lib/libzlib.dll.a ] && ln -s $INSTALL_DIR/lib/libzlib.dll.a $INSTALL_DIR/lib/libz.a
    [ -f $INSTALL_DIR/lib/libzlibstatic.a ] && ln -s $INSTALL_DIR/lib/libzlibstatic.a $INSTALL_DIR/lib/libzstatic.a
    echo -ne " "
}

start