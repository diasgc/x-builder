#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libbpg'
dsc='Better Portable Graphics'
lic='BSD'
src='https://github.com/mirrorer/libbpg.git'
sty='git'
cfg='mk'
dep='libjpeg libpng'
tls='yasm libsdl2-dev'
eta='60'

. xbuilder.sh

CFG="-i CC=$CC CXX=$CXX AR=$AR CFLAGS=$CPPFLAGS CXXFLAGS=$CPPFLAGS prefix=${INSTALL_DIR} USE_BPGVIEW=n USE_EMCC=n"
[[ $arch = *mingw32 ]] && CFG="$CFG CONFIG_WIN32=y"

patchSrc(){
	# ln -s /usr/include/libpng16/png.h $SRCDIR/png.h
	# ln -s /usr/include/libpng16/pnglibconf.h $SRCDIR/pnglibconf.h
	# ln -s /usr/include/jpeglib.h $SRCDIR/jpeglib.h
	ln -s /usr/include/SDL2 $SRCDIR/SDL2
}

# Required function buildLib
_buildLib(){
  doLog 'clean' ${MAKE_EXECUTABLE} clean
  doLog 'make' ${MAKE_EXECUTABLE} $CFG -j${HOST_NPROC}
  doLog 'install' ${MAKE_EXECUTABLE} install
}

build_pkgconfig_file(){
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