#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='openal'
dsc='OpenAL Soft is a software implementation of the OpenAL 3D audio API.'
lic='GLP-2.0'
src='https://github.com/kcat/openal-soft.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk='UTILS'

lst_inc=''
lst_lib=''
lst_bin=''

CFG="-DALSOFT_INSTALL_EXAMPLES=OFF -DALSOFT_EXAMPLES=OFF"

. xbuilder.sh

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
# lib/cmake/OpenAL/OpenALTargets.cmake
# lib/cmake/OpenAL/OpenALConfig.cmake
# lib/cmake/OpenAL/OpenALTargets-release.cmake
# lib/libopenal.so
# share/openal/alsoftrc.sample
# share/openal/presets/itu5.1.ambdec
# share/openal/presets/presets.txt
# share/openal/presets/rectangle.ambdec
# share/openal/presets/itu5.1-nocenter.ambdec
# share/openal/presets/hexagon.ambdec
# share/openal/presets/3D7.1.ambdec
# share/openal/presets/square.ambdec
# share/openal/hrtf/Default HRTF.mhr
