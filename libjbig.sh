#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libjbig'
dsc='JBIG1 data compression standard (ITU-T T.82) lossless image compression'
lic='GPL'
src='https://www.cl.cam.ac.uk/~mgk25/git/jbigkit'
sty='git'
cfg=''
tls=''
dep=''
pkg='libjbig'

eta='17'
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

. tcutils.sh
dbld=$SRCDIR
exe=
loadToolchain
[[ $arch = *mingw32* ]] && exe=".exe"
CFG="CC=$CC CFLAGS=-I$SRCDIR/libjbig LDFLAGS=-L$SRCDIR/libjbig -ljbig -ljbig85"
export ar=$AR ranlib=$RANLIB

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
  doLog 'clean' cleanBuild
  doLog 'make' ${MAKE_EXECUTABLE} $CFG -j${HOST_NPROC}
  doLog 'install' copyInstall 
}

cleanBuild(){
  rm -rf  ${INSTALL_DIR}/bin ${INSTALL_DIR}/include 
  mkdir -p ${INSTALL_DIR}/bin ${INSTALL_DIR}/include
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
}

copyInstall(){
	cp $SRCDIR/$lib/*.a ${INSTALL_DIR}/lib
	cp $SRCDIR/$lib/*.h ${INSTALL_DIR}/include
	cp $SRCDIR/$lib/tstcodec${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstcodec85${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstjoint${exe} ${INSTALL_DIR}/bin
}

# Use function buildPC to manually build pkg-config .pc file
buildPC(){
  cat <<-EOF >>$PKGDIR/$pkg.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: ${lib}
		Description: ${dsc}
		Version: 2.1
		Requires:
		Libs: -L\${libdir} -ljbig -ljbig85
		Cflags: -I\${includedir}
		EOF
}

start