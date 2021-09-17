#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libmagic'
dsc='Image metadata library and tools'
lic=''
vrs='5.39'
src="http://ftp.debian.org/debian/pool/main/f/file/file_${vrs}.orig.tar.gz"
sty='tgz'
cfg='ac'
pkg='libmagic'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1"

_buildSrc(){
	pushd $SOURCES >/dev/null
	log download
	wget -O- $src 2>>$LOGFILE | tar -xz >>$LOGFILE 2>&1 || err
	mv file_*.tar.gz $lib
	logok
	popd >/dev/null
}

start

# Filelist
# --------

# include/magic.h
# share/man/man4/magic.4
# share/man/man3/libmagic.3
# share/man/man1/file.1
# share/misc/magic.mgc
# lib/libmagic.la
# lib/pkgconfig/libmagic.pc
# lib/libmagic.so
# lib/libmagic.a
# bin/file
