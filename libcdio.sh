#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='libcdio'
dsc='Portable CD-ROM I/O library'
lic='GPL-3.0'
src='git://git.sv.gnu.org/libcdio.git'
sty='git'
cfg='ac'
tls=''
dep='libcddb libiconv'
eta='10'
pkg='libcdio'

eta='80'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-static --enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
CFG="--disable-vcd-info --enable-cpp-progs --disable-rpath --without-cdda-player --disable-example-progs --with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch !=  && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  sed -i 's|$(LIBCDIOPP_LIBS) $(LTLIBICONV)|$(LIBCDIOPP_LIBS) $(LIBCDIO_LIBS) $(LTLIBICONV)|g' $SRCDIR/example/C++/OO/Makefile.in
  doAutoreconf $SRCDIR
}
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start