#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='openssl'
dsc='TLS/SSL and crypto library'
lic='Apache-2.0'
src='https://github.com/openssl/openssl.git'
sty='git'
cfg='TODO'
tls='nasm perl'
dep=''
pkg='openssl'

eta='780'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-static no-shared pic"
cs1="-static shared pic"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG=
dbld=$SRCDIR/build_${arch}
loadToolchain

case $arch in
  x86_64-w64-mingw32 )    CFG="no-idea no-mdc2 no-rc5 mingw64 --cross-compile-prefix=x86_64-w64-mingw32-";;
  i686-w64-mingw32 )      CFG="no-idea no-mdc2 no-rc5 mingw --cross-compile-prefix=i686-w64-mingw32-";;
  aarch64-linux-android ) CFG="android-arm64 -D__ANDROID_API__=$API";;
  arm-linux-androideabi ) CFG="android-arm -D__ANDROID_API__=$API";;
  i686-linux-android )    CFG="android-x86 -D__ANDROID_API__=$API";;
  x86_64-linux-android )  CFG="android-x86_64 -D__ANDROID_API__=$API";;
esac
export AS=nasm
export ANDROID_NDK_ROOT=$ANDROID_NDK_HOME


# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  doLog 'configure' $SRCDIR/Configure --prefix=${INSTALL_DIR} $CSH $CBN $CFG
  doLog 'make 1' ${MAKE_EXECUTABLE} depend
  doLog '2' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install_sw
}
# Use function buildPC to manually build pkg-config .pc file

start