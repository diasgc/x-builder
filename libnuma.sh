#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   +   X   +   .   X   X   X  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# NUMA is not available for windows
# PKGINFO-------------------------------------
lib='libnuma'
dsc='Library for tuning for Non Uniform Memory Access machines (linux)'
lic='GPL-2.0'
src='https://github.com/numactl/numactl.git'
sty='git'
cfg='ag'
tls=''
dep=''
eta='90'
pkg='numa'

eta='110'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --with-pic=1"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=

. tcutils.sh
CFG=
dbld=$SRCDIR
loadToolchain
case $arch in
  *-w64-mingw32 ) echo -e "$CR1  Windows not supported.\n  Cannot compile LUMA for non-posix systems.\n  Exiting...\n\n$C0" && exit;;
  x86_64-linux-gnu ) ;;
  * ) CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG";;
esac
#export CFLAGS="$CFLAGS  -Wno-implicit-function-declaration" CXXFLAGS="$CXXFLAGS -Wno-implicit-function-declaration"
    
# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function patchMakefile to patch Makefile
patchMakefile(){
  [[ $arch = *android* ]] && sed -i 's/-lrt//g' $SRCDIR/Makefile
  # do not remove this line
  echo
}
# Use function buildPC to manually build pkg-config .pc file

start