#!/bin/bash
# HEADER-----------------------------------
lib='tesseract'
dsc='An OCR Engine that was developed at HP Labs between 1985 and 1995... and now at Google'
lic='Apache-2.0'
src='https://github.com/tesseract-ocr/tesseract.git'
sty='git'
cfg='ac'
tls=''
dep='leptonica'
eta='60'
pkg='tesseract'
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
CFG="--disable-debug \
    --disable-graphics \
    --disable-cube \
    --disable-tessdata-prefix \
    --disable-largefile"
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
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
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
    LEPTONICA_CFLAGS="-I$LIBSDIR/leptonica/include" \
    LEPTONICA_LIBS="-L$LIBSDIR/leptonica/lib -llept"

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}
start