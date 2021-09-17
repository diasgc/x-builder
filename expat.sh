#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   +   +   +   .   .   +  static
#  +   +   +   +   +   +   +   +   .   .   +  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='expat'
apt='expat'
dsc='Fast streaming XML parser written in C'
lic=''
src='https://github.com/libexpat/libexpat.git'
sty='git'
cfg='ac'
eta='77'
mkc=distclean
# -----------------------------------------
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


. xbuilder.sh

SRCDIR=$SRCDIR/expat

if test $cfg = 'cm'; then
    csh0="-DEXPAT_SHARED_LIBS=OFF"
    csh1="-DEXPAT_SHARED_LIBS=ON"
    cb0="-DEXPAT_BUILD_TOOLS=OFF"
    cb1="-DEXPAT_BUILD_TOOLS=ON"
    CFG="-DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF"
else
    cb0="--without-examples"
    CFG="--with-sysroot=${SYSROOT} --without-tests --without-docbook --without-xmlwf --disable-fast-install --with-pic"
fi

source_patch(){
    pushdir $SRCDIR
    doLog 'buildconf' ./buildconf.sh
    popdir
}

start

# Filelist
# --------

# include/expat.h
# include/expat_config.h
# include/expat_external.h
# lib/pkgconfig/expat.pc
# lib/libexpat.la
# lib/cmake/expat-2.4.1/expat-config-version.cmake
# lib/cmake/expat-2.4.1/expat-config.cmake
# lib/cmake/expat-2.4.1/expat-noconfig.cmake
# lib/cmake/expat-2.4.1/expat.cmake
# lib/libexpat.a
# lib/libexpat.so
# share/doc/expat/changelog
# share/doc/expat/AUTHORS
