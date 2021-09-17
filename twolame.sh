#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='twolame'
dsc='MPEG Audio Layer 2 (MP2) encoder'
lic='LGPL-2.1'
src='https://github.com/njh/twolame.git'
sty='git'
cfg='ac'
dep='sndfile'
eta='225'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-maintainer-mode"

source_patch(){
  	pushdir $SRCDIR
	# Exclude 'doc' from SUBDIRS = .... list in Makefile.am , or build LibTwoLAME fails.
	sed -i.bak "/^SUBDIRS/s/ doc//" $SRCDIR/Makefile.am
	doAutoreconf $SRCDIR
	popdir
}

start



# Filelist
# --------
# include/twolame.h
# lib/pkgconfig/twolame.pc
# lib/libtwolame.so
# lib/libtwolame.la
# lib/libtwolame.a
# share/doc/twolame/NEWS
# share/doc/twolame/AUTHORS
# share/doc/twolame/COPYING
# share/doc/twolame/README
# bin/twolame
