#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='glslang'
dsc='OpenGL and OpenGL ES shader front end and validator'
lic='BSD-3c'
src='https://github.com/KhronosGroup/glslang.git'
sty='git'
cfg='cm'
tls=''
dep=''
pkg='glslang'

eta='60'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb1
# -----------------------------------------

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake \
  -DBUILD_TESTING=OFF \
  -DENABLE_OPT=OFF \
  -DINSTALL_GTEST=OFF"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
  [ $vrs ] || setGitVrs
  cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: ${lib}
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L${libdir} -lglslang -lOSDependent -lHLSL -lOGLCompiler -lSPVRemapper
		Cflags: -I${includedir}
		EOF
}

start