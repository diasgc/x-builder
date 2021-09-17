#!/bin/bash

lib='avisynth'
dsc='A powerful nonlinear scripting language for video'
lic='GPL'
src='https://github.com/AviSynth/AviSynthPlus.git'
sty='git'
cfg='cm'
eta=240
cbk="ENABLE_PLUGINS"

. xbuilder.sh $@ --ndkLpthread --posix

CFG="-DHEADERS_ONLY=OFF -Wno-dev"

# dont pass LT_SYS_LIBRARY_PATH to avoid redefinition error
case $arch in *-mingw32) unset PKG_CONFIG_LIBDIR;; esac

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  P   P   .   +   .   F   +   +   -   .   .  static
#  P   P   F   +   .   F   +   +   -   .   .  shared
#  -   -   .   .   .   .   .   .   -   .   .  bin

# TODO: patch CMakeLists to build static+shared

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
