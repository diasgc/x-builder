#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   +   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='exhale'
apt=''
dsc='an open-source ISO/IEC 23003-3 (USAC, xHE-AAC) encoder'
lic='Copyright'
src='https://gitlab.com/ecodis/exhale.git'
sty='git'
cfg='cm'
eta='150'
pc_llib="-lexhale"

. xbuilder.sh

CFG="-DBUILD_TESTS=OFF"

source_patch(){
	# path-sep format for linux
  sed -i 's|\\|\/|g' $SRCDIR/src/app/exhaleApp.rc
}

build_install(){
	${MAKE_EXECUTABLE} ${mki}
	mkdir -p $INSTALL_DIR/include $INSTALL_DIR/share/licenses/exhale
	install -Dm644 $SRCDIR/include/{exhaleDecl.h,version.h} -t $INSTALL_DIR/include
	install -Dm644 $SRCDIR/include/{License.htm,Release.htm,styles.css} -t $INSTALL_DIR/share/licenses/exhale
}

start

# Filelist
# --------
# todo: add includes and licences
# lib/libexhale.so
# bin/exhale
