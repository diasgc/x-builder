#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

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
lst_inc='gmp.h'
lst_lib='libgmp'
lst_bin=''
. xbuilder.sh

CFG="CC_FOR_BUILD=cc"
unset ABI
$host_mingw && CFG+=" --enable-fat"

source_config(){
  # from bootstrap:
  cd $SRCDIR
  rm -rf autom4te.cache
  autoreconf -i -s >/dev/null 2>&1
  cat >doc/version.texi <<-EOF
  @set UPDATED 19 January 2038
  @set UPDATED-MONTH January 2038
  @set EDITION 12.35
  @set VERSION 12.35
	EOF
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