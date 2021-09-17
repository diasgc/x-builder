#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libjbig'
dsc='JBIG1 data compression standard (ITU-T T.82) lossless image compression'
lic='GPL'
src='https://www.cl.cam.ac.uk/~mgk25/git/jbigkit'
sty='git'
cfg='mk'
eta='17'

. xbuilder.sh

exe=
[[ $arch = *mingw32* ]] && exe=".exe"
CFG="CC=$CC CFLAGS=-I$SRCDIR/libjbig LDFLAGS=-L$SRCDIR/libjbig -ljbig -ljbig85"
export ar=$AR ranlib=$RANLIB

build_install(){
	cp $SRCDIR/$lib/*.a ${INSTALL_DIR}/lib
	cp $SRCDIR/$lib/*.h ${INSTALL_DIR}/include
	cp $SRCDIR/$lib/tstcodec${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstcodec85${exe} ${INSTALL_DIR}/bin
	cp $SRCDIR/$lib/tstjoint${exe} ${INSTALL_DIR}/bin
}

create_package(){
	mkdir -p tmp/lib/pkgconfig tmp/include tmp/bin
	pushdir tmp
	copyInstall $(pwd)
	cp ${PKGDIR}/${pkg}.pc ./lib/pkgconfig
	build_packages_filelist
	tar -czvf "${1}.tar.gz" *
	popdir
	rm -rf tmp
}

build_pkgconfig_file(){
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

# Filelist
# --------

# include/jbig_ar.h
# include/jbig85.h
# include/jbig.h
# lib/pkgconfig/libjbig.pc
# lib/libjbig.a
# lib/libjbig85.a
# bin/tstcodec
# bin/tstjoint
# bin/tstcodec85
