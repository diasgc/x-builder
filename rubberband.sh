#!/bin/bash
# Aa8 Aa7 A86 A64 L64 L86 W64 W86 (static/shared)
#  +   .   .   .   .   .   +   .
#
# HEADER-----------------------------------
lib='librubberband'
dsc='An audio time-stretching and pitch-shifting library and utility program.'
lic='GPL-2.0'
cfg='ac'
src='https://github.com/breakfastquay/rubberband.git'
sty='git'
tls=''
dep='sndfile samplerate fftw'
pkg='rubberband'
# STATS------------------------------------
eta='172'
lsz=
psz=
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-programs"
cb1="--enable-programs"
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--with-pic=1 --disable-vamp --disable-ladspa"
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch}"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    doAutogen $SRCDIR
}

# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  
  doLog 'clean' make clean >/dev/null 2>&1
  
  export FFTW_CFLAGS="-I$LIBSDIR/fftw/include"
  export FFTW_LIBS="-L$LIBSDIR/fftw/lib -lfftw3"
  export PKG_CONFIG=$(which pkg-config)
  #setPkgConfigDir $PKGDIR fftw
  
  doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  [ "$arch" == "*mingw32" ] && sed -i 's,:= bin/rubberband,:= bin/rubberband.exe,' Makefile
  doLog 'install' ${MAKE_EXECUTABLE} install
  [ "$arch" == "*mingw32" ] && sed -i 's,:= bin/rubberband.exe,:= bin/rubberband,' Makefile

  #cp rubberband.pc $PKGDIR
  echo -e "\nRequires: sndfile, samplerate, fftw3" >>$PKGDIR/rubberband.pc
}

# Use function buildPC to manually build pkg-config .pc file

start
