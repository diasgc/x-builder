#!/bin/bash

lib='libnuma'
apt="${lib}-dev"
dsc='Library for tuning for Non Uniform Memory Access machines (linux)'
lic='GPL-2.0'
src='https://github.com/numactl/numactl.git'
sty='git'
cfg='ac'
eta='90'
pkg='numa'
eta='30'
mki='install-strip'
mkc='distclean'
API=26 # min api necessary for declaration of functions like 'shmget'

. xbuilder.sh $@ --ndkLrt

case ${PLATFORM} in
  Windows) doErr "Non-posix OS cannot use LUMA. Exiting...\n";;
esac

CFG="--with-sysroot=${SYSROOT}"

source_config(){
  pushdir $SRCDIR
  NOCONFIGURE=1 ./autogen.sh
  autoconf -i
  popdir
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   +   X   +   +   X   X   .  static
#  +   +   +   +   .   X   +   +   .   X   .  shared
#  +   +   +   +   .   X   +   +   .   X   .  bin
# NUMA is not available for windows

# Filelist
# --------
# include/numa.h
# include/numaif.h
# include/numacompat1.h
# lib/pkgconfig/numa.pc
# lib/libnuma.a
# lib/libnuma.la
# lib/libnuma.so
# share/man/man3/numa.3
# share/man/man8/numastat.8
# share/man/man8/migspeed.8
# share/man/man8/migratepages.8
# share/man/man8/numactl.8
# share/man/man8/memhog.8
# share/man/man2/move_pages.2
# bin/numademo
# bin/memhog
# bin/migspeed
# bin/numastat
# bin/numactl
# bin/migratepages
