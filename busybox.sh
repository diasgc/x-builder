#!/bin/bash
# test-ok: linux win64 aarch64-android
# HEADER-----------------------------------
lib='busybox'
dsc=''
lic='BSD'
src='https://git.busybox.net/busybox'
sty='git'
cfg='mk'
vrs=''
tls=''
dep=''
eta='360'
pkg='busybox'
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
DEF="defconfig"
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
  *-w64-mingw32 ) setMinGWToolchain;; #&& DEF="cygwin_defconfig"
  *-linux-gnu ) setGnuToolchain;;
esac
CFG="-i CC=$CC AS=$AS NM=$NM STRIP=$STRIP OBJCOPY=$OBJCOPY OBJDUMP=$OBJDUMP RANLIB=$RANLIB $CFG"

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){


  log clean
  logme ${MAKE_EXECUTABLE} clean
  log makedef
  logme ${MAKE_EXECUTABLE} $DEF
  log make
  logme ${MAKE_EXECUTABLE} PREFIX=${INSTALL_DIR} $CFG -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install PREFIX=${INSTALL_DIR} $CFG

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