#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libbs2b'
apt='libbs2b-dev'
dsc='Bauer stereophonic-to-binaural DSP'
lic='MIT'
src='https://github.com/alexmarsev/libbs2b'
sty='git'
cfg='ag'
dep='sndfile'
eta='30'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

start

# Filelist
# --------

# include/bs2b/bs2btypes.h
# include/bs2b/bs2b.h
# include/bs2b/bs2bversion.h
# include/bs2b/bs2bclass.h
# lib/pkgconfig/libbs2b.pc
# lib/libbs2b.so
# lib/libbs2b.a
# lib/libbs2b.la
# bin/bs2bstream
# bin/bs2bconvert
