#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='expat'
dsc='Fast streaming XML parser written in C'
lic=''
src='https://github.com/libexpat/libexpat.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='expat'

eta='77'
lsz=336
psz=
ets=(20 0 0 40 46 69 18 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static --disable-shared"
cs1="--enable-shared"
cb0=
cb1=
CSH=
CBN=
# -----------------------------------------
#  --without-xmlwf         do not build xmlwf
#  --without-examples      do not build examples [default=included]
#  --without-tests         do not build tests [default=included]
#  --with-libbsd           utilize libbsd (for arc4random_buf)
#  --with-getrandom        enforce the use of getrandom function in the system
#                          [default=check]
#  --without-getrandom     skip auto detect of getrandom [default=check]
#  --with-sys-getrandom    enforce the use of syscall SYS_getrandom function in
#                          the system [default=check]
#  --without-sys-getrandom skip auto detect of syscall SYS_getrandom
#                          [default=check]
#  --with-docbook          enforce XML to man page compilation [default=check]
#  --without-docbook       skip XML to man page compilation [default=check]

mkclean=distclean
. tcutils.sh
SRCDIR=$SRCDIR/expat
loadToolchain

if test $cfg = 'cm'; then
    cs0="-DEXPAT_SHARED_LIBS=OFF"
    cs1="-DEXPAT_SHARED_LIBS=ON"
    cb0="-DEXPAT_BUILD_TOOLS=OFF"
    cb1="-DEXPAT_BUILD_TOOLS=ON"
    dbld=$SRCDIR/build_${arch}
    CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -DEXPAT_BUILD_EXAMPLES=OFF -DEXPAT_BUILD_TESTS=OFF"
else
    dbld=$SRCDIR
    CFG="--without-docbook --without-xmlwf --disable-fast-install --with-pic"
    test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"
fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
    pushd $SRCDIR >/dev/null
    doLog 'buildconf' ./buildconf.sh
    popd >/dev/null
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start