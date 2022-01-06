#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   PP  ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libzen'
apt="${lib}-dev"
dsc='Zenlib for MediaInfo'
lic='Zlib'
src='https://github.com/MediaArea/ZenLib.git'
cfg='cmake'
eta='10'
dir_config='Project/CMake'
lst_inc='ZenLib/BitStream_LE.h
	ZenLib/int128u.h
	ZenLib/Translation.h
	ZenLib/Dir.h
	ZenLib/ZtringListList.h
	ZenLib/BitStream.h
	ZenLib/Trace.h
	ZenLib/int128s.h
	ZenLib/Format/Html/Html_Handler.h
	ZenLib/Format/Html/Html_Request.h
	ZenLib/Format/Http/Http_Cookies.h
	ZenLib/Format/Http/Http_Request.h
	ZenLib/Format/Http/Http_Utils.h
	ZenLib/Format/Http/Http_Handler.h
	ZenLib/File.h
	ZenLib/Ztring.h
	ZenLib/CriticalSection.h
	ZenLib/ZtringList.h
	ZenLib/MemoryDebug.h
	ZenLib/Utils.h
	ZenLib/OS_Utils.h
	ZenLib/InfoMap.h
	ZenLib/Conf_Internal.h
	ZenLib/ZtringListListF.h
	ZenLib/Conf.h
	ZenLib/BitStream_Fast.h
	ZenLib/Thread.h
	ZenLib/FileName.h
	ZenLib/PreComp.h'
lst_lib='libzen'
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/ZenLib/BitStream_LE.h
# include/ZenLib/int128u.h
# include/ZenLib/Translation.h
# include/ZenLib/Dir.h
# include/ZenLib/ZtringListList.h
# include/ZenLib/BitStream.h
# include/ZenLib/Trace.h
# include/ZenLib/int128s.h
# include/ZenLib/Format/Html/Html_Handler.h
# include/ZenLib/Format/Html/Html_Request.h
# include/ZenLib/Format/Http/Http_Cookies.h
# include/ZenLib/Format/Http/Http_Request.h
# include/ZenLib/Format/Http/Http_Utils.h
# include/ZenLib/Format/Http/Http_Handler.h
# include/ZenLib/File.h
# include/ZenLib/Ztring.h
# include/ZenLib/CriticalSection.h
# include/ZenLib/ZtringList.h
# include/ZenLib/MemoryDebug.h
# include/ZenLib/Utils.h
# include/ZenLib/OS_Utils.h
# include/ZenLib/InfoMap.h
# include/ZenLib/Conf_Internal.h
# include/ZenLib/ZtringListListF.h
# include/ZenLib/Conf.h
# include/ZenLib/BitStream_Fast.h
# include/ZenLib/Thread.h
# include/ZenLib/FileName.h
# include/ZenLib/PreComp.h
# lib/libzen.so
# lib/pkgconfig/libzen.pc
# lib/cmake/zenlib/ZenLibTargets-release.cmake
# lib/cmake/zenlib/ZenLibConfig.cmake
# lib/cmake/zenlib/ZenLibTargets.cmake
# lib/cmake/zenlib/ZenLibConfigVersion.cmake
