#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='openal'
dsc='OpenAL Soft with Android support'
lic='GLP-2.0'
src='https://github.com/AerialX/openal-soft-android.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
cbk='UTILS'

lst_inc=''
lst_lib=''
lst_bin=''

CFG="-DEXAMPLES=OFF"

. xbuilder.sh

case $host_os in
    android) CFG+=" -DANDROID_LOW_LATENCY=ON";;
    mingw32) CFG+=" -DALSA=OFF";;
esac

start

# Filelist
# --------
# include/AL/al.h
# include/AL/efx-creative.h
# include/AL/alext.h
# include/AL/alc.h
# include/AL/efx.h
# include/AL/efx-presets.h
# lib/pkgconfig/openal.pc
# lib/libopenal.so
