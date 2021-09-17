#!/bin/bash
# HEADER-----------------------------------
lib='fdk-aac'
dsc='A standalone library of the Fraunhofer FDK AAC code from Android'
lic='Fraunhofer'
src='https://github.com/mstorsjo/fdk-aac.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='fdk-aac'
# STATS------------------------------------
eta='180'
lsz=11232
psz=11480
# FLAGS------------------------------------
cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------
# enable main toolchain util
. tcutils.sh
# DEFS-------------------------------------
CFG="--with-pic=1"
dbld=$SRCDIR
# END--------------------------------------

loadToolchain
if test $cfg = 'cm'; then
  cs0="-DBUILD_SHARED_LIBS=OFF"
  cs1="-DBUILD_SHARED_LIBS=ON"
  cb0=
  cb1=
  setBuildOpts
  dbld=$SRCDIR/build_${arch}
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake"
else
  test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

patchSrc(){
	if [ ! -d $SRCDIR/libSBRdec/include/log ];then
		mkdir -p $SRCDIR/libSBRdec/include/log
		printf "#pragma once\n#include <cstdint>\ninline int android_errorWriteLog(int, const char*) { return 0; };\ninline int android_errorWriteWithInfoLog(int tag, const char* subTag, int32_t uid, const char* data, uint32_t dataLen) { return 0; };" >> $SRCDIR/libSBRdec/include/log/log.h
	fi
  doAutogen $SRCDIR
}

start