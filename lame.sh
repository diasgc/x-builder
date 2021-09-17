#!/bin/bash
# HEADER-----------------------------------
lib='lame'
dsc='LAME is a high quality MPEG Audio Layer III (MP3) encoder'
lic='LGPL'
src='https://sourceforge.net/projects/lame/files/lame/3.100/lame-3.100.tar.gz/download'
sty='tgz'
cfg='ac'
tls=''
dep='libiconv'
eta='180'
pkg='lame'
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
CFG="--with-libiconv-prefix=$LIBSDIR/libiconv --enable-decoder --without-vorbis --enable-analyzer=no --enable-brhist --disable-debug"
CSH="--enable-static --disable-shared --with-pic=1"
CBN="--disable-frontend"
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN="--enable-frontend"
  [[ $bbin -eq 0 ]] && CBN="--disable-frontend"
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch --enable-nasm $CFG" #CC_FOR_BUILD=cc 
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
	getTarGZ $src $lib
}

# Required function buildLib
buildLib(){
  
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  log pkgconfig
  logme createPkgConfig
}

createPkgConfig(){
cat <<EOF >>$PKGDIR/$lib.pc
prefix=${INSTALL_DIR}
exec_prefix=\${prefix}
libdir=\${exec_prefix}/lib
includedir=\${prefix}/include
Name: Lame
Description: LAME is a high quality MPEG Audio Layer III (MP3) encoder
Version: 3.100
Requires:
Libs: -L\${libdir} -lmp3lame
Cflags: -I\${includedir}
EOF
}

start