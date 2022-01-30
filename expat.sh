#!/bin/bash

lib='expat'
dsc='Fast streaming XML parser written in C'
lic=''
src='https://github.com/libexpat/libexpat.git'
cfg='ac'
eta='77'
config_dir="expat"
case $cfg in
    a*) cb0="--without-examples" CFG="--without-tests --without-docbook --without-xmlwf --disable-fast-install";;
    c*) cshk="EXPAT_SHARED_LIBS" cbk="EXPAT_BUILD_TOOLS" CFG="-DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF";;
esac

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='expat/COPYING expat/AUTHORS'
lst_pc=''

. xbuilder.sh

source_config(){
    ./buildconf.sh
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   +   .   .   +  static
#  +   +   +   +   +   +   +   +   .   .   +  shared

# Automake options
# --------
#  --without-xmlwf         do not build xmlwf
#  --without-examples      do not build examples [default=included]
#  --without-tests         do not build tests [default=included]
#  --with-libbsd           utilize libbsd (for arc4random_buf)
#  --with-getrandom        enforce the use of getrandom function in the system
#                          [default=check]
#  --without-getrandom     skip auto detect of getrandom [default=check]
#  --with-sys-getrandom    enforce the use of syscall SYS_getrandom function in
#                          the system [default=check]
#  --without-sys-getrandom skip auto detect of syscall SYS_getrandom
#                          [default=check]
#  --with-docbook          enforce XML to man page compilation [default=check]
#  --without-docbook       skip XML to man page compilation [default=check]

# Filelist
# --------
# include/expat_config.h
# include/expat.h
# include/expat_external.h
# share/doc/expat/COPYING
# share/doc/expat/changelog
# share/doc/expat/AUTHORS
# lib/libexpat.a
# lib/cmake/expat-2.4.3/expat-noconfig.cmake
# lib/cmake/expat-2.4.3/expat.cmake
# lib/cmake/expat-2.4.3/expat-config-version.cmake
# lib/cmake/expat-2.4.3/expat-config.cmake
# lib/libexpat.so
# lib/pkgconfig/expat.pc
# lib/libexpat.la
