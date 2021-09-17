#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libcaca'
dsc='Colour AsCii Art library'
lic='GPL'
src='https://github.com/cacalabs/libcaca.git'
sty='git'
cfg='ac'
pkg='caca'
eta='80'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-doc --disable-imlib2 --disable-cppunit --disable-slang --disable-x11 --disable-gl \
  --disable-cocoa --disable-csharp --disable-java --disable-ruby --disable-zzuf --disable-python"
#--disable-cxx "

source_config(){
  pushd $SRCDIR
  ./bootstrap
  popd
}

start

# Filelist
# --------

# include/caca++.h
# include/caca.h
# include/caca0.h
# include/caca_types.h
# include/caca_conio.h
# lib/pkgconfig/caca++.pc
# lib/pkgconfig/caca.pc
# lib/libcaca.so
# lib/libcaca++.so
# lib/libcaca++.la
# lib/libcaca.a
# lib/libcaca.la
# lib/libcaca++.a
# share/man/man1/img2txt.1
# share/man/man1/cacaserver.1
# share/man/man1/cacaview.1
# share/man/man1/cacafire.1
# share/man/man1/caca-config.1
# share/man/man1/cacaplay.1
# share/libcaca/caca.txt
# bin/caca-config
# bin/cacafire
# bin/cacaserver
# bin/img2txt
# bin/cacaclock
# bin/cacademo
# bin/cacaview
# bin/cacaplay
