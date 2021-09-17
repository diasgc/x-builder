#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='liblzma'
dsc='General purpose data compression library'
lic='GPL-3 LGPL-2.1'
src='https://git.tukaani.org/xz.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='liblzma'

eta='110'
lsz=
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--enable-static" # default yes
cs1="--enable-shared" # default yes
cb0=
cb1=
CSH=
CBN=

# cmake flags
# TUKLIB_FAST_UNALIGNED_ACCESS:BOOL=ON
# TUKLIB_USE_UNSAFE_TYPE_PUNNING:BOOL=OFF
#
# automake flags
#  --enable-debug             Enable debugging code.
#  --enable-encoders=LIST     Comma-separated list of encoders to build. Default=all. Available encoders: lzma1 lzma2 delta x86 powerpc ia64 arm armthumb sparc
#  --enable-decoders=LIST     Comma-separated list of decoders to build. Default=all. Available decoders are the same as available encoders.
#  --enable-match-finders=LIST  Comma-separated list of match finders to build. Default=all. At least one match finder is required for encoding with the LZMA1 and LZMA2 filters. Available match finders: hc3 hc4 bt2 bt3 bt4
#  --enable-checks=LIST       Comma-separated list of integrity checks to build. Default=all. Available integrity checks: crc32 crc64 sha256
#  --enable-external-sha256   INSTALL for possible subtle problems.
#  --disable-assembler        Do not use assembler optimizations even if such exist for the architecture.
#  --enable-small             Make liblzma smaller and a little slower. This is disabled by default to optimize for speed.
#  --enable-threads=METHOD    Supported METHODS are `yes', `no', `posix', `win95',and `vista'. The default is `yes'. Using `no' together with --enable-small makes liblzma thread unsafe.
#  --enable-assume-ram=SIZE   If and only if the real amount of RAM cannot be determined, assume SIZE MiB. The default is 128 MiB. This affects the default memory usage limit.
#  --disable-xz               do not build the xz tool
#  --disable-xzdec            do not build xzdec
#  --disable-lzmadec          do not build lzmadec (compatibility)
#  --disable-lzmainfo         do not build lzmainfo (compatibility)
#  --disable-lzma-links       do not create symlinks (compatibility)
#  --disable-scripts          do not install the scripts xzdiff, xzgrep, xzless, xzmore, and their symlinks
#  --disable-doc              do not install documentation files to docdir (man pages will still be installed)
#  --enable-symbol-versions   Use symbol versioning for liblzma. Enabled by default on GNU/Linux, other GNU-based systems, and FreeBSD.
#  --enable-sandbox=METHOD    Sandboxing METHOD can be `auto', `no', or `capsicum'. The default is `auto' which enables sandboxing if a supported sandboxing method is found.
#  --enable-path-for-scripts=PREFIX   If PREFIX isn't empty, PATH=PREFIX:$PATH will be set in the beginning of the scripts (xzgrep and others). The default is empty except on Solaris the default is /usr/xpg4/bin.

. tcutils.sh
CFG="--with-pic=1"
dbld=$SRCDIR
loadToolchain
test $arch != x86_64-linux-gnu && CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  doAutogen $SRCDIR --noerr
}
# Use function beforeBuild to execute extra code before buildLib
# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file

start