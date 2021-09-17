#!/bin/bash
# HEADER-----------------------------------
lib='libjbig'
dsc='JBIG1 data compression standard (ITU-T T.82) lossless image compression'
lic='GPL'
src='https://www.cl.cam.ac.uk/~mgk25/git/jbigkit'
sty='git'
cfg=''
tls=''
dep=''
eta='17'
pkg='libjbig'
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
exe=

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH=
  [[ $bshared -eq 0 ]] && CSH=
fi

# HEADER-----------------------------------

case $arch in
  *-android|*-androideabi ) setNDKToolchain;;
  *-w64-mingw32 ) setMinGWToolchain && exe='.exe';;
  *-linux-gnu ) setGnuToolchain;;
esac

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
  cp $SRCDIR/Makefile $SRCDIR/Makefile.bk
}

# Required function buildLib
buildLib(){

  cleanBuild >/dev/null 2>&1
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme copyInstall
  
  log pkgconfig
  logme createPkgConfig
}

cleanBuild(){
  rm -rf  ${INSTALL_DIR}/bin ${INSTALL_DIR}/include 
  mkdir -p ${INSTALL_DIR}/bin ${INSTALL_DIR}/include
  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  rm $SRCDIR/Makefile && cp $SRCDIR/Makefile.bk $SRCDIR/Makefile
  sed -i 's|CC = gcc|CC = '$CC'|g' $SRCDIR/Makefile
  sed -i 's|ar rc|'$AR' rc|g' $SRCDIR/Makefile
  sed -i 's|-ranlib|-'$RANLIB'|g' $SRCDIR/Makefile
}

copyInstall(){
	cp $SRCDIR/$lib/*.a ${INSTALL_DIR}/lib
	cp $SRCDIR/$lib/*.h ${INSTALL_DIR}/include
	cp $SRCDIR/$lib/tstcodec${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstcodec85${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstjoint${exe} ${INSTALL_DIR}/bin
}

createPkgConfig(){
  cat <<-EOF >>$PKGDIR/$pkg.pc
	prefix=${INSTALL_DIR}
	exec_prefix=\${prefix}
	libdir=\${exec_prefix}/lib
	includedir=\${prefix}/include
	Name: libjbig
	Description: JBIG1 data compression standard (ITU-T T.82) lossless image compression
	Version: 2.1
	Requires:
	Libs: -L\${libdir} -ljbig -ljbig85
	Cflags: -I\${includedir}
	EOF
}

start