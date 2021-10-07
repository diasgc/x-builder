#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ... ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='curl'
pkg='libcurl'
dsc='A command line tool and library for transferring data with URL syntax'
lic='Other'
src='https://github.com/curl/curl.git'
cfg='ar'
eta='130'
dep='zlib libzstd brotli openssl'
mki='install-strip'
mkc='distclean'

lst_inc='curl/typecheck-gcc.h
	curl/multi.h
	curl/curl.h
	curl/urlapi.h
	curl/mprintf.h
	curl/stdcheaders.h
	curl/options.h
	curl/easy.h
	curl/curlver.h
	curl/system.h'
lst_lib='libcurl'
lst_bin='curl curl-config'

. xbuilder.sh

# todo remove manual
CFG="--with-openssl --disable-manual"

start


# Filelist
# --------
# include/curl/typecheck-gcc.h
# include/curl/multi.h
# include/curl/curl.h
# include/curl/urlapi.h
# include/curl/mprintf.h
# include/curl/stdcheaders.h
# include/curl/options.h
# include/curl/easy.h
# include/curl/curlver.h
# include/curl/system.h
# lib/pkgconfig/libcurl.pc
# lib/libcurl.la
# lib/libcurl.so
# lib/libcurl.a
# share/aclocal/libcurl.m4
# bin/curl-config
# bin/curl
