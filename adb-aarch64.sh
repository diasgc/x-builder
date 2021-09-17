#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='adb'
dsc='A standalone-built version of android adb'
lic='BSD'
# https://github.com/qhuyduong/arm_adb
src='https://android.googlesource.com/platform/system/adb'
sty='git'
cfg='mk'
tls=''
dep=''
pkg='adb'

eta=''
lsz=
psz=(2840)
ets=(64 0 0 0 0 0 0 0 0 0 0)
ls0=(2660 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  cd $SRCDIR
  make -f $SRCDIR/Android.mk CC=$CC LD=$LD -j16
  
}
# Use function buildPC to manually build pkg-config .pc file

start
