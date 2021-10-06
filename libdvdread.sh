#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++o ++o ++o ++o
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ++o

lib='libdvdread'
apt="${lib}-dev"
pkg='dvdread'
dsc='Library to read DVD disks'
lic='GPL-2.0'
src='https://code.videolan.org/videolan/libdvdread.git'
cfg='ar'
eta='10'
mki='install-strip'
mkc='distclean'

lst_inc='dvdread/nav_types.h \
	dvdread/ifo_print.h \
	dvdread/bitreader.h \
	dvdread/ifo_types.h \
	dvdread/dvd_udf.h \
	dvdread/version.h \
	dvdread/nav_read.h \
	dvdread/dvd_reader.h \
	dvdread/nav_print.h \
	dvdread/ifo_read.h'
lst_lib='libdvdread'

. xbuilder.sh

CFG="--disable-apidoc"

start

# Filelist
# --------
# include/dvdread/nav_types.h
# include/dvdread/ifo_print.h
# include/dvdread/bitreader.h
# include/dvdread/ifo_types.h
# include/dvdread/dvd_udf.h
# include/dvdread/version.h
# include/dvdread/nav_read.h
# include/dvdread/dvd_reader.h
# include/dvdread/nav_print.h
# include/dvdread/ifo_read.h
# lib/pkgconfig/dvdread.pc
# lib/libdvdread.la
# lib/libdvdread.a
# lib/libdvdread.so
# share/doc/libdvdread/NEWS
# share/doc/libdvdread/AUTHORS
# share/doc/libdvdread/README.md
# share/doc/libdvdread/ChangeLog
# share/doc/libdvdread/COPYING
# share/doc/libdvdread/TODO
