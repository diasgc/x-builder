#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  +   +   +   +   .   .   .   .   .   .   .  bin

lib='fdk-aac'
apt='fdkaac'
dsc='A standalone library of the Fraunhofer FDK AAC code from Android'
lic='Fraunhofer'
src='https://github.com/mstorsjo/fdk-aac.git'
sty='git'
cfg='ag'
eta='180'
cb1="--enable-example"

. xbuilder.sh
  
case $build_tool in
  cmake) cbk="BUILD_PROGRAMS";;
esac

source_patch(){
	if [ ! -d $SRCDIR/libSBRdec/include/log ];then
		mkdir -p $SRCDIR/libSBRdec/include/log
		printf "#pragma once\n#include <cstdint>\ninline int android_errorWriteLog(int, const char*) { return 0; };\ninline int android_errorWriteWithInfoLog(int tag, const char* subTag, int32_t uid, const char* data, uint32_t dataLen) { return 0; };" >> $SRCDIR/libSBRdec/include/log/log.h
	fi
}

start

# Filelist
# --------

# include/fdk-aac/FDK_audio.h
# include/fdk-aac/genericStds.h
# include/fdk-aac/aacdecoder_lib.h
# include/fdk-aac/aacenc_lib.h
# include/fdk-aac/syslib_channelMapDescr.h
# include/fdk-aac/machine_type.h
# lib/pkgconfig/fdk-aac.pc
# lib/libfdk-aac.la
# lib/libfdk-aac.a
# lib/libfdk-aac.so
# bin/aac-enc
