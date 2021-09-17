#!/bin/bash
# HEADER-----------------------------------
lib='libiconv'
vrs='1.16'
dsc='Character set conversion library '
lic='GPL'
src='https://ftp.gnu.org/gnu/libiconv/libiconv-'$vrs'.tar.gz'
sty='tgz'
cfg='ac'
tls=''
dep=''
eta='300'
pkg='libiconv'
upk=
# -----------------------------------------

# required extraopts
extraOpts(){
  case $1 in
    --pkgdl ) upk=1;;
    * ) usage && exit;;
  esac
}

# enable main toolchain util
. tcutils.sh

if [ $upk ];then
  case $arch in
    aarch64-linux-android ) upk='https://ftp.f3l.de/~martchus/ownstuff/os/x86_64/android-aarch64-libiconv-1.16-2-any.pkg.tar.zst';;
    arm-linux-androideabi ) upk='https://ftp.f3l.de/~martchus/ownstuff/os/x86_64/android-armv7a-eabi-libiconv-1.16-2-any.pkg.tar.zst';;
    i686-linux-android )    upk='https://ftp.f3l.de/~martchus/ownstuff/os/x86_64/android-x86-libiconv-1.16-2-any.pkg.tar.zst';;
    x86_64-linux-android )  upk='https://ftp.f3l.de/~martchus/ownstuff/os/x86_64/android-x86-64-libiconv-1.16-2-any.pkg.tar.zst';;
    i686-w64-mingw32 )      upk=;;
    x86_64-w64-mingw32 )    upk=;;
  esac

fi

# requided defs
CFG=
CSH="--enable-static --disable-shared --with-pic=1"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--enable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --with-pic=1"
fi

# HEADER-----------------------------------

case $arch in
  *-linux-android ) setNDKToolchain
    CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
    ;;
  *-w64-mingw32 ) setMinGWToolchain
    CFG="--host=${arch} --with-sysroot=/usr/$arch $CFG" #CC_FOR_BUILD=cc 
    ;;
  x86_64-linux-gnu ) setGnuToolchain
    ;; # no cross compile
  i686-linux-gnu ) setGnuToolchain
    CFG="--host=${arch} $CFG"
    ;;
esac

# Required function buildSrc
buildSrc(){
	# todo: unable to compile from git logme git clone https://git.savannah.gnu.org/git/libiconv.git
	getTarGZ $src $lib
}

# Required function buildLib
buildLib(){

  ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN

  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install

  log pkgcfg
  logme installPkgconfig
}

installPkgconfig(){
	cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: iconv
		Description: libiconv
		URL: https://www.gnu.org/software/libiconv/
		Version: $vrs
		Libs: -L\${libdir} -liconv
		Cflags: -I\${includedir}
		EOF
}

start