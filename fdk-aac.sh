#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU  .  +++  .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='fdk-aac'
apt='fdkaac'
dsc='A standalone library of the Fraunhofer FDK AAC code from Android'
lic='Other'
src='https://github.com/mstorsjo/fdk-aac.git'
cfg='ag'
eta='180'
cb1="--enable-example"

lst_inc=' fdk-aac/FDK_audio.h
	fdk-aac/genericStds.h
	fdk-aac/aacdecoder_lib.h
	fdk-aac/aacenc_lib.h
	fdk-aac/syslib_channelMapDescr.h
	fdk-aac/machine_type.h'
lst_lib='libfdk-aac'
lst_bin='aac-enc'

. xbuilder.sh
  
case $build_tool in
  cmake) cbk="BUILD_PROGRAMS";;
esac

source_patch(){
	local logd="${SRCDIR}/libSBRdec/include/log"
	if [ ! -f "${logd}/log.h" ];then
		mkdir -p ${logd}
		curl "https://android.googlesource.com/platform/system/bt/+/master/linux_include/log/log.h?format=TEXT" | base64 --decode | sed 's/OS_GENERIC/__ANDROID__/' >${logd}/log.h
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
