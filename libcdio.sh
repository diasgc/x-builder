#!/bin/bash
# HEADER-----------------------------------
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
CFG="--disable-vcd-info --enable-cpp-progs --disable-rpath --without-cdda-player --disable-example-progs"
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
case $arch in
  *-android|*-androideabi ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  x86_64-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    ;;
  i686-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG"
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
  gitClone $src $lib
  sed -i 's|$(LIBCDIOPP_LIBS) $(LTLIBICONV)|$(LIBCDIOPP_LIBS) $(LIBCDIO_LIBS) $(LTLIBICONV)|g' $SRCDIR/example/C++/OO/Makefile.in
  doAutoreconf $SRCDIR
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >>$LOGFILE 2>&1

  setPkgConfigDir $PKGDIR libcddb libiconv
  
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}

start