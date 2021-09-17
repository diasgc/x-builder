#!/bin/bash
# test-ok: linux win64 aarch64-android
# HEADER-----------------------------------
lib='bzip2'
dsc='Lossless, block-sorting data compression'
lic='BSD 2-clause'
src='https://sourceware.org/git/bzip2.git'
sty='git'
cfg='mk'
vrs='1.0.8'
tls=''
dep=''
eta='60'
pkg='bzip2'
# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    --pkgdl ) upk=1;;
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
dbld=$SRCDIR

# HEADER-----------------------------------
loadToolchain

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1
  
  doLog 'make' ${MAKE_EXECUTABLE} PREFIX=${INSTALL_DIR} -i CC=$CC AR=$AR RANLIB=$RANLIB -j${HOST_NPROC}

  doLog 'install' ${MAKE_EXECUTABLE} install PREFIX=${INSTALL_DIR} -i CC=$CC AR=$AR RANLIB=$RANLIB

}

# Use function buildPC to manually build pkg-config .pc file
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