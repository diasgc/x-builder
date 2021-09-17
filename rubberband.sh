#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='librubberband'
dsc='An audio time-stretching and pitch-shifting library and utility program.'
lic='GPL-2.0'
src='https://github.com/breakfastquay/rubberband.git'
sty='git'
cfg='ag'
tls=''
dep='sndfile samplerate fftw'
pkg='rubberband'

eta='172'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0="--disable-programs"
cb1="--enable-programs"
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh

CFG="--with-pic=1 --disable-vamp --disable-ladspa"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch}"
export FFTW_CFLAGS="-I$LIBSDIR/fftw/include" \
  FFTW_LIBS="-L$LIBSDIR/fftw/lib -lfftw3" \
  PKG_CONFIG=$(which pkg-config)

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
  echo -e "\nRequires: sndfile, samplerate, fftw3" >>$PKGDIR/rubberband.pc
  test $arch = *mingw32 -a -f $INSTALL_DIR/bin/rubberband && mv $INSTALL_DIR/bin/rubberband $INSTALL_DIR/bin/rubberband.exe
}

start
