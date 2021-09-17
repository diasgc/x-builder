#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# test-ok: linux64 win64 aarch64-android
# PKGINFO-------------------------------------
lib='libbs2b'
dsc='Bauer stereophonic-to-binaural DSP'
lic='MIT'
src='https://github.com/alexmarsev/libbs2b'
sty='bit'
cfg='ag'
tls=''
dep='sndfile'
pkg='libbs2b'

eta='10'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch !=  && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
case $arch in
  *-android|*-androideabi ) # hack for xcompile undefined reference to `rpl_realloc'
    export ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes
    ;;
  x86_64-w64-mingw32 ) # do not use *-w64-mingw32-pkg-config
    export PKG_CONFIG=pkg-config
    ;;
  x86_64-linux-gnu ) CFG="--with-pic=1";;
  i686-w64-mingw32 ) # hack for xcompile undefined reference to `rpl_realloc'
    export PKG_CONFIG=pkg-config ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes
    ;;
esac

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
buildLib(){

  ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1
  setPkgConfigDir $PKGDIR sndfile
  
  doLog 'configure' $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN LIBS="$LIBS -lm"
  
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' $SRCDIR/libtool

  doLog 'make' ${MAKE_EXECUTABLE} -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install
}
# Use function buildPC to manually build pkg-config .pc file

start