#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='adb'
dsc='A standalone-built version of android adb'
lic='BSD'
src='https://github.com/karfield/adb.git'
sty='git'
cfg='ar'
tls=''
dep='ncurses'
pkg='adb'

eta='208'
lsz=
psz=(2840)
ets=(64 0 0 0 0 0 0 0 0 0 0)
ls0=(2660 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain --ndkLpthread --ndkLrt

[ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutoreconf $SRCDIR

test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start
