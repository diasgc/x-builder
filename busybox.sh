#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='busybox'
dsc=''
lic='BSD'
src='https://git.busybox.net/busybox'
sty='git'
cfg='mk'
vrs=''
tls=''
dep=''
pkg='busybox'

eta='360'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1
# -----------------------------------------

. tcutils.sh
loadToolchain
CFG="-i CC=$CC AS=$AS NM=$NM STRIP=$STRIP OBJCOPY=$OBJCOPY OBJDUMP=$OBJDUMP RANLIB=$RANLIB"
DEF="defconfig"
dbld=$SRCDIR

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  doLog 'clean' ${MAKE_EXECUTABLE} clean
  doLog 'makedef' ${MAKE_EXECUTABLE} $DEF
  doLog 'make' ${MAKE_EXECUTABLE} PREFIX=${INSTALL_DIR} $CFG -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install PREFIX=${INSTALL_DIR} $CFG
}

# Use function buildPC to manually build pkg-config .pc file
buildPC(){
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