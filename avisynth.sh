#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  P   P   F   P  clang
# GNU  P   P   .   .  gcc
# WIN  .   .   .   F  clang/gcc

lib='avisynth'
dsc='A powerful nonlinear scripting language for video'
lic='GPL'
src='https://github.com/AviSynth/AviSynthPlus.git'
cfg='cmake'
eta=240
cbk="ENABLE_PLUGINS"
CFG="-DHEADERS_ONLY=OFF"

lst_inc='avisynth/avisynth_c.h
	avisynth/avs/capi.h
	avisynth/avs/config.h
	avisynth/avs/minmax.h
	avisynth/avs/alignment.h
	avisynth/avs/types.h
	avisynth/avs/cpuid.h
	avisynth/avs/win.h
	avisynth/avs/filesystem.h
	avisynth/avs/posix.h
	avisynth/avisynth.h'
lst_lib='libavisynth.so.3.7.0
    avisynth/libconvertstacked
    avisynth/libshibatch
    avisynth/libtimestretch'
lst_bin=''

. xbuilder.sh

# dont pass LT_SYS_LIBRARY_PATH to avoid redefinition error
$host_mingw && unset PKG_CONFIG_LIBDIR

start

# Filelist
# --------
# include/avisynth/avisynth_c.h
# include/avisynth/avs/capi.h
# include/avisynth/avs/config.h
# include/avisynth/avs/minmax.h
# include/avisynth/avs/alignment.h
# include/avisynth/avs/types.h
# include/avisynth/avs/cpuid.h
# include/avisynth/avs/win.h
# include/avisynth/avs/filesystem.h
# include/avisynth/avs/posix.h
# include/avisynth/avisynth.h
# lib/pkgconfig/avisynth.pc
# lib/avisynth/libconvertstacked.so
# lib/avisynth/libshibatch.so
# lib/avisynth/libtimestretch.so
# lib/libavisynth.so.3.7.0