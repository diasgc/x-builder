#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   PP. ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libmediainfo'
apt="${lib}-dev"
dsc='Convenient unified display of the most relevant technical and tag data for video and audio files.'
lic='BSD-2c'
src='https://github.com/MediaArea/MediaInfoLib.git'
cfg='cmake'
eta='10'

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

CONFIG_DIR="$SRCDIR/Project/CMake"

start

# Filelist
# --------
# include/MediaInfo/MediaInfoList.h
# include/MediaInfo/MediaInfo_Events.h
# include/MediaInfo/MediaInfo.h
# include/MediaInfo/MediaInfo_Const.h
# include/MediaInfoDLL/MediaInfoDLL_Static.h
# include/MediaInfoDLL/MediaInfoDLL.h
# lib/pkgconfig/libmediainfo.pc
# lib/cmake/mediainfolib/MediaInfoLibConfigVersion.cmake
# lib/cmake/mediainfolib/MediaInfoLibConfig.cmake
# lib/cmake/mediainfolib/MediaInfoLibTargets.cmake
# lib/cmake/mediainfolib/MediaInfoLibTargets-release.cmake
# lib/libmediainfo.so
