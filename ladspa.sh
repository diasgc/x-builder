#!/bin/bash
# fail to build plugins
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# HEADER-----------------------------------
lib='ladspa'
dsc='Linux Audio Developers Simple Plugin API'
lic='LGPL'
vrs='1.15'
src="http://www.ladspa.org/download/ladspa_sdk_$vrs.tgz"
sty='tgz'
cfg='mk'
tls=''
dep=''
pkg='ladspa'

eta='60'
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
CBN=$cb0
# ------------------------------------

. tcutils.sh
SRCDIR=$SRCDIR/src
dbld=$SRCDIR
loadToolchain
CFG="CC=$CC CPP=$CXX \
	INSTALL_PLUGINS_DIR=${INSTALL_DIR}/lib \
	INSTALL_INCLUDE_DIR=${INSTALL_DIR}/include \
	INSTALL_BINARY_DIR=${INSTALL_DIR}/bin"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
buildLib(){
	doLog 'clean' make clean
	doLog 'make' make $CFG -j4
	doLog 'install' make install
}
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
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
  #mkdir -p $INSTALL_DIR/include $INSTALL_DIR/share/licenses/exhale
  #install -Dm644 $SRCDIR/include/{exhaleDecl.h,version.h} -t $INSTALL_DIR/include
  #install -Dm644 $SRCDIR/include/{License.htm,Release.htm,styles.css} -t $INSTALL_DIR/share/licenses/exhale
}

start