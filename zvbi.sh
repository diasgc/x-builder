#!/bin/bash
# HEADER-----------------------------------
lib='zvbi'
dsc='VBI Capturing and Decoding Library'
lic='BSD 2-clause'
src='git://git.opendreambox.org/git/zvbi.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta=''
pkg='zvbi-0.2'
lsz=
# -----------------------------------------
cs0="--enable-static --disable-shared --with-pic=1"
cs1="--enable-static --enable-shared --with-pic=1"
cb0=
cb1=
CFG="--without-doxygen"
CSH=$cs0

# enable main toolchain util
. tcutils.sh

# requided line 
dbld=$SRCDIR
# HEADER-----------------------------------

loadToolchain
[ "$arch" != "x86_64-linux-gnu" ] && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

buildSrc(){
	gitClone $src $lib
    doAutoreconf $SRCDIR
}

start