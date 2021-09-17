#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='tree'
dsc='Tree is a recursive directory listing command'
lic='GPL-2'
vrs='1.8.0'
src="http://mama.indstate.edu/users/ice/tree/src/tree-${vrs}.tgz"
sty='tgz'
cfg='mk'
tls=''
dep=''
pkg='tree'

eta='45'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

. tcutils.sh
# todo clean & simplify
dbld=$SRCDIR
API=26 loadToolchain
OBJS="tree.o unix.o html.o xml.o json.o hash.o color.o file.o"
case $arch in
  *-android* ) CFLAGS="-std=c11 -O3 -Wall -D__ANDROID"
    LDFLAGS="-s -lc"
    OBJS="$OBJS strverscmp.o";;&
  aarch64-linux-android|x86_64-linux-android )
     CFLAGS="$CFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64";;
  arm-*android*|i686-*android );;
  *-linux-gnu* ) CFLAGS="-ggdb -pedantic -Wall -DLINUX"
    LDFLAGS="-s";;&
  aarch64-linux-gnu|x86_64-linux-gnu )
    CFLAGS="$CFLAGS -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64";;
  arm-linux-gnu*|i686-linux-gnu );;
  * ) doErr "  $arch is unsupported";;
esac

CFG="prefix=$INSTALL_DIR CC=$CC"
mkinstall="prefix=$INSTALL_DIR install"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    # clear defaults
    sed -i "s,OBJS=tree.o,#OBJS=tree.o," $SRCDIR/Makefile
    sed -i "s,CFLAGS=-ggdb,#CFLAGS=-ggdb," $SRCDIR/Makefile
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
    pushd $SRCDIR >/dev/null
    doLog 'clean' make clean
    log 'make '
    LDFLAGS=$LDFLAGS CFLAGS=$CFLAGS OBJS=$OBJS make $CFG -j4 >>"$LOGFILE" || err
    logok
    doLog 'install' make $mkinstall
    popd >/dev/null 
}
# Use function buildPC to manually build pkg-config .pc file

start