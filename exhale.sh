#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   +   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# HEADER-----------------------------------
lib='exhale'
dsc='an open-source ISO/IEC 23003-3 (USAC, xHE-AAC) encoder'
lic='Copyright'
src='https://gitlab.com/ecodis/exhale.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='exhale'

eta='150'
lsz=1384
psz=3936
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# ------------------------------------

. tcutils.sh
dbld=$SRCDIR/build_${arch}
CFG="-DBUILD_TESTS=OFF"
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake $CFG"
#export CFLAGS="-static-libgcc" CXXFLAGS="-static-libstdc++"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
	# path-sep format for linux
  sed -i 's|\\|\/|g' $SRCDIR/src/app/exhaleApp.rc
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
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
		Libs: -L\${libdir} -lexhale
		Libs.private:
		Cflags: -I\${includedir}/
		EOF
  mkdir -p $INSTALL_DIR/include $INSTALL_DIR/share/licenses/exhale
  install -Dm644 $SRCDIR/include/{exhaleDecl.h,version.h} -t $INSTALL_DIR/include
  install -Dm644 $SRCDIR/include/{License.htm,Release.htm,styles.css} -t $INSTALL_DIR/share/licenses/exhale
}

start