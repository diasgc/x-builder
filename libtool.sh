#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libtool'
dsc='A library for reading and writing audio files'
lic='LGPL-3.0'
src='git://git.savannah.gnu.org/libtool.git'
cfg='ac'
tls='help2man'
eta='35'
pc_llib="-ltdl"
pc_url="https://savannah.gnu.org/git/?group=libtool"

. xbuilder.sh

source_config(){
    pushdir $SRCDIR
    ./bootstrap
    popdir
}

start

# Filelist
# --------

# include/ltdl.h
# include/libltdl/lt_error.h
# include/libltdl/lt_dlloader.h
# include/libltdl/lt_system.h
# lib/libltdl.a
# lib/libltdl.la
# lib/libltdl.so
# share/man/man1/libtoolize.1
# share/man/man1/libtool.1
# share/aclocal/ltoptions.m4
# share/aclocal/ltsugar.m4
# share/aclocal/libtool.m4
# share/aclocal/ltversion.m4
# share/aclocal/ltargz.m4
# share/aclocal/ltdl.m4
# share/aclocal/lt~obsolete.m4
# share/libtool/lt_error.c
# share/libtool/COPYING.LIB
# share/libtool/ltdl.h
# share/libtool/slist.c
# share/libtool/lt__alloc.c
# share/libtool/lt__argz.c
# share/libtool/configure.ac
# share/libtool/config-h.in
# share/libtool/lt_dlloader.c
# share/libtool/Makefile.in
# share/libtool/lt__strl.c
# share/libtool/ltdl.c
# share/libtool/build-aux/config.sub
# share/libtool/build-aux/missing
# share/libtool/build-aux/depcomp
# share/libtool/build-aux/config.guess
# share/libtool/build-aux/compile
# share/libtool/build-aux/ltmain.sh
# share/libtool/build-aux/install-sh
# share/libtool/lt__dirent.c
# share/libtool/libltdl/lt__strl.h
# share/libtool/libltdl/lt__argz_.h
# share/libtool/libltdl/lt__dirent.h
# share/libtool/libltdl/slist.h
# share/libtool/libltdl/lt_error.h
# share/libtool/libltdl/lt__alloc.h
# share/libtool/libltdl/lt__glibc.h
# share/libtool/libltdl/lt_dlloader.h
# share/libtool/libltdl/lt_system.h
# share/libtool/libltdl/lt__private.h
# share/libtool/ltdl.mk
# share/libtool/configure
# share/libtool/aclocal.m4
# share/libtool/Makefile.am
# share/libtool/loaders/preopen.c
# share/libtool/loaders/dlopen.c
# share/libtool/loaders/dld_link.c
# share/libtool/loaders/load_add_on.c
# share/libtool/loaders/dyld.c
# share/libtool/loaders/loadlibrary.c
# share/libtool/loaders/shl_load.c
# share/libtool/README
# share/info/libtool.info-1
# share/info/libtool.info-2
# share/info/dir
# share/info/libtool.info
# bin/libtoolize
# bin/libtool
