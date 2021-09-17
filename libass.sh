#!/bin/bash
# test-ok: linux64
# test-fail: win64
# HEADER-----------------------------------
lib='libass'
dsc='LibASS is an SSA/ASS subtitles rendering library'
lic='ISC'
src='https://github.com/libass/libass.git'
sty='git'
cfg='ac'
tls=''
dep='freetype fontconfig fribidi libpng harfbuzz'
eta='60'
pkg='libass'
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
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG" #CC_FOR_BUILD=cc 
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

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN \
  FREETYPE_CFLAGS="-I$LIBSDIR/freetype/include" FREETYPE_LIBS="-L$LIBSDIR/freetype/lib" \
  FONTCONFIG_CFLAGS="-I$LIBSDIR/fontconfig/include" FONTCONFIG_LIBS="-L$LIBSDIR/fontconfig/lib" \
  FRIBIDI_CFLAGS="-I$LIBSDIR/fribidi/include" FRIBIDI_LIBS="-L$LIBSDIR/fribidi/lib" \
  HARFBUZZ_CFLAGS="-I$LIBSDIR/fribidi/include" HARFBUZZ_LIBS="-L$LIBSDIR/fribidi/lib" \
  LIBPNG_CFLAGS="-I$LIBSDIR/libpng/include" LIBPNG_LIBS="-L$LIBSDIR/libpng/lib"



  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}



start