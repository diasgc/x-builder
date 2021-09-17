#!/bin/bash
# HINFO-----------------------------------
lib='libnuma'
dsc='Library for tuning for Non Uniform Memory Access machines (linux)'
lic='GPL-2.0'
src='https://github.com/numactl/numactl.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='90'
pkg='numa'
# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

# requided defs
CFG=
CSH="--enable-static --disable-shared --with-pic"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic"
fi

# HEADER-----------------------------------
case $arch in
  *-linux-android* ) setNDKToolchain
	  CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG";;
  *-linux-gnu ) setGnuToolchain
	  CFG="--host=${arch} $CFG";;&
  x86_64-linux-gnu ) CFG="";;  
  *-w64-mingw32 ) setMinGWToolchain
    echo -e "$CR1 Cannot compile LUMA for non-posix systems. Exiting...\n\n$C0" && exit
	  # CFG="--host=${arch} $CFG"
    # CFLAGS="$CFLAGS -I$(pwd)/sources/mairix"
    # CXXFLAGS="$CXXFLAGS -I$(pwd)/sources/mairix"
    # checkMairix || err
    ;;
  * ) errUnknownTarget;;
esac

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
  doAutogen $SRCDIR
}

# Required function buildLib
buildLib(){
    log configure
    logme ./configure --prefix=${INSTALL_DIR} $CFG $CSHR
    
    #patch makefile for ndk
    [ "$arch"=="*android*" ] && sed -i 's/-lrt//g' $SRCDIR/Makefile

    log make
    logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}
    
    log install
    logme ${MAKE_EXECUTABLE} install
    mv $PKGDIR/numa.pc $PKGDIR/libnuma.pc
}

start