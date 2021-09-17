#!/bin/bash
# fail to build plugins
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   .   .   .   .   .  static
#  F   .   .   .   .   .   .   .   .   .   .  shared
#  F   .   .   .   .   .   .   .   .   .   .  bin

lib='ladspa'
apt='ladspa-sdk'
dsc='Linux Audio Developers Simple Plugin API'
lic='LGPL'
vrs='1.16'
src="http://www.ladspa.org/download/ladspa_sdk_${vrs}.tgz"
sty='tgz'
cfg='mk'
dep='sndfile'
eta='60'

. xbuilder.sh

SRCDIR=$SRCDIR/src
dbld=$SRCDIR

build_patch_config(){
	CFG=("CC=$CC" "CPP=$CXX" \
	"INSTALL_PLUGINS_DIR=${INSTALL_DIR}/lib" \
	"INSTALL_INCLUDE_DIR=${INSTALL_DIR}/include" \
	"INSTALL_BINARY_DIR=${INSTALL_DIR}/bin")
	#doLog 'clean' make clean
	#sed '/pattern1/,/pattern2/s//& INSERT THIS TEXT/g' inputFile
	sed -i "s|-I.$|-I. -I$LIBSDIR/include|g" Makefile
	sed -i "s|-ldl -lm -lsndfile|-ldl -lm -L$LIBSDIR/lib -lsndfile|g" Makefile
	sed -i "s|-Werror|-Wno-error|g" Makefile
}

build_pkgconfig_file(){
  cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: ${lib}
		Description: ${dsc}
		Requires:
		Version: ${vrs}
		Libs: -L${libdir} -lladspa
		Libs.private:
		Cflags: -I${includedir}/
		EOF
}

start