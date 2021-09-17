#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='sdl2'
dsc='Simple DirectMedia Layer is a cross-platform development library designed to provide low level access to audio, keyboard, mouse, joystick, and graphics hardware via OpenGL and Direct3D'
lic='BSD'
src='https://github.com/garyservin/sdl2.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='sdl2'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------

. tcutils.sh
loadToolchain

case $cfg in
  cm|ccm|cmake|ccmake)
    cs0="-DBUILD_SHARED_LIBS=OFF"
    cs1="-DBUILD_SHARED_LIBS=ON"
    def="-DBUILD_SHARED_LIBS=OFF"
    dbld=$SRCDIR/build_${arch}
    CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
    ;;
  ac|ar|ag)
    cs0="--enable-static"
    cs1="--enable-shared"
    def="--enable-static --disable-shared"
    dbld=$SRCDIR
    CFG="--with-pic=1"
    test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start