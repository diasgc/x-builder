#!/bin/bash
# test-ok: linux64 win64 aarch64-android
# HEADER-----------------------------------
lib='libbs2b'
dsc='Bauer stereophonic-to-binaural DSP'
lic='MIT'
src='https://github.com/alexmarsev/libbs2b'
sty='bit'
cfg='ac'
tls=''
dep='sndfile'
eta='10'
pkg='libbs2b'
# -----------------------------------------
# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH="--enable-static --disable-shared --with-pic=1"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------
case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    # hack for xcompile undefined reference to `rpl_realloc'
    export ac_cv_func_malloc_0_nonnull=yes
    export ac_cv_func_realloc_0_nonnull=yes
    ;;
  x86_64-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    # do not use *-w64-mingw32-pkg-config
    export PKG_CONFIG=pkg-config
    ;;
  i686-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    # hack for xcompile undefined reference to `rpl_realloc'
    export PKG_CONFIG=pkg-config
    export ac_cv_func_malloc_0_nonnull=yes
    export ac_cv_func_realloc_0_nonnull=yes
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
  doAutogen $SRCDIR
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1

  setPkgConfigDir $PKGDIR sndfile
  
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN LIBS="$LIBS -lm"
  sed -i -e 's/ -shared / -Wl,-O1,--as-needed\0/g' $SRCDIR/libtool

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start