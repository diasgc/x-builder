#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='isobmff'
dsc='ISO Base Media File Format Reference Software'
lic='?'
src='https://github.com/MPEGGroup/isobmff.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='isobmff'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb1
# -----------------------------------------

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
dcf="linux"
[[ $arch = *mingw32 ]] && dcf="win32"
dcf="-I$SRCDIR/IsoLib/libisomediafile/$dcf"
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DCMAKE_C_FLAGS=$dcf -DCMAKE_CXX_FLAGS=$dcf"
MKF="libisoiff isoiff_tool"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
    doLog 'cmake' ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=Release $CFG $CSH $CBN
    [ $advcfg ] && inlineCcmake $SRCDIR
    doLog 'make' ${MAKE_EXECUTABLE} $MKF -j${HOST_NPROC}
    # no make rule for install, copy *.a *.h and bin manually?
}
# Use function buildPC to manually build pkg-config .pc file

start
