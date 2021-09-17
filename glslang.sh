#!/bin/bash
# HEADER-----------------------------------
lib='glslang'
dsc='OpenGL and OpenGL ES shader front end and validator'
lic='BSD-3c'
src='https://github.com/KhronosGroup/glslang.git'
sty='git'
cfg='cm'
tls=''
dep=''
eta=''
pkg='glslang'
upk=
# -----------------------------------------
cs0="-DBUILD_SHARED_LIBS=OFF"
cs1="-DBUILD_SHARED_LIBS=ON"
cb0=
cb1=
CSH=$cs0
CBN=$cb1

# enable main toolchain util
. tcutils.sh
dbld=$SRCDIR/build_${arch}
loadToolchain
CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake \
  -DBUILD_TESTING=OFF \
  -DENABLE_OPT=OFF \
  -DINSTALL_GTEST=OFF"
  
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