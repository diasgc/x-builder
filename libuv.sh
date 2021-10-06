#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++  ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libuv'
apt='libuv1-dev'
dsc='Cross-platform asynchronous I/O'
lic='Other'
src='https://github.com/libuv/libuv.git'
sty='git'
cfg='cm'
eta='40'

lst_inc='uv/stdint-msvc2008.h
	uv/android-ifaddrs.h
	uv/tree.h
	uv/sunos.h
	uv/aix.h
	uv/os390.h
	uv/win.h
	uv/errno.h
	uv/bsd.h
	uv/version.h
	uv/threadpool.h
	uv/posix.h
	uv/linux.h
	uv/unix.h
	uv/darw'
lst_lib='libuv'
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/uv/stdint-msvc2008.h
# include/uv/android-ifaddrs.h
# include/uv/tree.h
# include/uv/sunos.h
# include/uv/aix.h
# include/uv/os390.h
# include/uv/win.h
# include/uv/errno.h
# include/uv/bsd.h
# include/uv/version.h
# include/uv/threadpool.h
# include/uv/posix.h
# include/uv/linux.h
# include/uv/unix.h
# include/uv/darwin.h
# include/uv.h
# lib/pkgconfig/libuv-static.pc
# lib/pkgconfig/libuv.pc
# lib/libuv.so
# lib/libuv_a.a
# share/doc/libuv/LICENSE
