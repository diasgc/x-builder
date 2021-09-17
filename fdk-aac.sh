#!/bin/bash
# HEADER-----------------------------------
lib='fdk-aac'
dsc='A standalone library of the Fraunhofer FDK AAC code from Android'
lic='Fraunhofer'
src='https://github.com/mstorsjo/fdk-aac.git'
sty='git'
cfg='ag'
tls=''
dep=''
pkg='fdk-aac'

eta='180'
lsz=11232
psz=11480
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain

if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  CSH=$cs0
  CBN=$cb1
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
	if [ ! -d $SRCDIR/libSBRdec/include/log ];then
		mkdir -p $SRCDIR/libSBRdec/include/log
		printf "#pragma once\n#include <cstdint>\ninline int android_errorWriteLog(int, const char*) { return 0; };\ninline int android_errorWriteWithInfoLog(int tag, const char* subTag, int32_t uid, const char* data, uint32_t dataLen) { return 0; };" >> $SRCDIR/libSBRdec/include/log/log.h
	fi
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start