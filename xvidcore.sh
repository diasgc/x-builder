#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='xvidcore'
dsc='Xvid decoder/encoder library'
lic=''
url='https://labs.xvid.com/source/'
# TODO: find git/svn repo
vrs="1.3.7"
src="https://downloads.xvid.com/downloads/xvidcore-${vrs}.tar.gz"
sty='tgz'
vrs='1.3.7'
cfg='ac'
tls=''
dep=''
pkg='xvidcore'

eta='36'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)
# TODO: set static/shared/bin options
cs0=
cs1=
cb0=
cb1=
CSH=$cs0
CBN=$cb1

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
  cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: ${lib}
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lxvidcore
		Cflags: -I\${includedir}
		EOF
}
start