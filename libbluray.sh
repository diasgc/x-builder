#!/bin/bash
# test-ok:
# HEADER-----------------------------------
lib='libbluray'
dsc='Library to access Blu-Ray disks'
lic='LGPL-2.1'
src='https://code.videolan.org/videolan/libbluray.git'
sty='git'
cfg='ac'
tls=''
dep='libxml2 freetype fontconfig'
pkg='libbluray'
# STATS------------------------------------
eta='60'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--disable-bdjava-jar --disable-examples "
CSH=$cs0
CBN=$cb0
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutoreconf $SRCDIR
}

# Use function buildLib to custom build
buildLib(){
    ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
    export FT2_CFLAGS="-I$LIBSDIR/freetype/include/freetype2"
    export FT2_LIBS="-L$LIBSDIR/freetype/lib -lfreetype"
    export FONTCONFIG_CFLAGS="-I$LIBSDIR/fontconfig/include"
    export FONTCONFIG_LIBS="-I$LIBSDIR/fontconfig/lib -lfontconfig"
    doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
    doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
    doLog 'install' ${MAKE_EXECUTABLE} install
}
# Use function buildPC to manually build pkg-config .pc file

start