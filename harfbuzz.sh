#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='harfbuzz'
dsc='HarfBuzz text shaping engine'
lic='Old MIT'
src='https://github.com/harfbuzz/harfbuzz.git'
sty='git'
cfg='cm'
tls=''
dep='freetype'
eta=''
pkg='harfbuzz'

eta='690'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

sh0=
sh1=
cb0=
cb1=
CSH=$sh0
CBN=$cb0
# -----------------------------------------

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"

buildPC(){
  cat <<-EOF >>$PKGDIR/${pkg}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: harfbuzz
		Description: HarfBuzz text shaping engine
		Version: ${vrs}
		Requires:
		Libs: -L\${libdir} -lharfbuzz
		Cflags: -I\${includedir}
		EOF
}

start