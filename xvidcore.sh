#!/bin/bash
# HEADER-----------------------------------
lib='xvidcore'
dsc='Xvid decoder/encoder library'
lic=''
url='https://labs.xvid.com/source/'
src='https://downloads.xvid.com/downloads/xvidcore-1.3.7.tar.gz'
sty='tgz'
vrs='1.3.7'
cfg='ac'
tls=''
dep=''
eta='36'
pkg='xvidcore'
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
CSH=
CBN=
dbld=$SRCDIR

# HEADER-----------------------------------

#loadToolchain $arch
case $arch in
  *-linux-android ) setNDKToolchain
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
	getTarGZ $src $lib
}

# Required function buildLib
buildLib(){

  pushd $SRCDIR/build/generic >/dev/null
  log configure
  logme ./configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  log pkgconfig
  logme createPkgConfig
  popd >/dev/null
}

createPkgConfig(){
  cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: xvidcore
		Description: xvidcore library
		Version: 1.3.7
		Requires:
		Libs: -L\${libdir} -lxvidcore
		Cflags: -I\${includedir}
		EOF
}

start