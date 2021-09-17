#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  o   .   .   .   .   o   .   .   .   .   .  shared
#  o   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO--------------------------------
lib='bzip2'
dsc='Lossless, block-sorting data compression'
lic='BSD 2-clause'
src='https://sourceware.org/git/bzip2.git'
sty='git'
cfg='mk'
vrs='1.0.8'
tls=''
dep=''
pkg='bzip2'

eta='60'
lsz=
psz=
ets=(8 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# -----------------------------------------
cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
loadToolchain
CFG="PREFIX=${INSTALL_DIR} -i CC=$CC AR=$AR RANLIB=$RANLIB"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

buildLib(){
  doLog 'clean' ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1
  doLog 'make' ${MAKE_EXECUTABLE} $CFG -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install $CFG
}

buildPC(){
  cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		bindir=\${exec_prefix}/bin
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: bzip2
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lbz2
		Cflags: -I\${includedir}
		EOF
}

start