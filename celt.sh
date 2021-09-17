#!/bin/bash
# issues: configure: line 9590: syntax error near unexpected token `tools="tools",'
#         configure: line 9590: `  XIPH_PATH_OGG(tools="tools", tools="")'
# HEADER-----------------------------------
lib='celt'
dsc='CELT is a low-delay audio codec'
lic='BSD 2-clause'
src='https://gitlab.xiph.org/xiph/celt.git'
sty='git'
cfg='ac'
tls=''
dep='libogg'
eta='60'
pkg='celt'
# -----------------------------------------
# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH="--enable-static --disable-shared --with-pic=1"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutogen $SRCDIR
}

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start