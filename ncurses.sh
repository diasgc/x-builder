#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='ncurses'
dsc='New Curses, free software emulation of curses in System V Release 4.0'
lic='BSD'
src='https://github.com/mirror/ncurses.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='ncurses'

eta='208'
lsz=
psz=(2840)
ets=(64 0 0 0 0 0 0 0 0 0 0)
ls0=(2660 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--with-normal --without-debug"
cs1="--with-shared --without-debug"
cb0="--without-progs"
cb1=
CSH=$cs0
CBN=$cb0

. tcutils.sh
CFG="--without-ada --enable-pc-files --with-pkg-config-libdir=$INSTALL_DIR/lib/pkgconfig"
dbld=$SRCDIR
loadToolchain

[ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutoreconf $SRCDIR
case $arch in
  *android* ) src='https://github.com/LineageOS/android_external_libncurses.git';;
esac
test $arch != x86_64-linux-gnu && CFG="--host=${arch} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
#buildLib(){
  # doLog 'clean' ${MAKE_EXECUTABLE} clean
#  doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} --with-install-prefix=$INSTALL_DIR $CSH $CBN $CFG
#  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
#  doLog 'install' ${MAKE_EXECUTABLE} make install.includes install.libs
#}
# Use function buildPC to manually build pkg-config .pc file

start