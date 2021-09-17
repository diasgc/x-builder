#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='gmp'
apt='libgmp-dev'
dsc='GNU Multiple Precision Arithmetic Library'
lic='LGPL-3.0 License'
src='https://gmplib.org/repo/gmp/'
sty='hg'
tls='mercurial'
cfg='ac'
eta='272'
mkc='distclean'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 CC_FOR_BUILD=cc"
unset ABI
case $arch in *-mingw32) CFG="$CFG --enable-fat";; esac

source_config(){
  # from bootstrap:
  pushdir $SRCDIR
  rm -rf autom4te.cache
  autoreconf -i -s >/dev/null 2>&1
  cat >doc/version.texi <<-EOF
  @set UPDATED 19 January 2038
  @set UPDATED-MONTH January 2038
  @set EDITION 12.35
  @set VERSION 12.35
	EOF
  popdir
}

start

# Filelist
# --------

# include/gmp.h
# lib/pkgconfig/gmp.pc
# lib/libgmp.la
# lib/libgmp.so
# lib/libgmp.a
# share/info/gmp.info
# share/info/gmp.info-2
# share/info/gmp.info-1
# share/info/dir
