#!/bin/bash
# HEADER-----------------------------------
lib='libbpg'
dsc='Better Portable Graphics'
lic='BSD'
src='https://github.com/mirrorer/libbpg.git'
sty='git'
cfg='mk'
vrs=''
tls=''
dep=''
eta='60'
pkg='libbpg'
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
CFG="prefix=${INSTALL_DIR} USE_BPGVIEW=n USE_EMCC=n"
CSH=
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH=
  [[ $bshared -eq 0 ]] && CSH=
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain;; #&& DEF="android_ndk_defconfig"
  *-w64-mingw32 ) setMinGWToolchain && CFG="CONFIG_WIN32=y $CFG";; #&& DEF="cygwin_defconfig"
  *-linux-gnu ) setGnuToolchain;;
esac
CFG="-i CC=$CC CXX=$CXX AR=$AR CFLAGS=-I$LIBSDIR/libpng/include LDFLAGS=-L$LIBSDIR/libpng/lib $CFG"

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){


  log clean
  logme ${MAKE_EXECUTABLE} clean
  log make
  logme ${MAKE_EXECUTABLE} $CFG -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  log pkgcfg
  logme installPkgConfig

}

installPkgConfig(){
  cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		bindir=\${exec_prefix}/bin
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: ${lib}
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L${libdir}
		Cflags: -I${includedir}
		EOF
}

start