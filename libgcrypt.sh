#!/bin/bash
# test-ok: win64
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libgcrypt'
apt='libgcrypt20-dev'
dsc='The GNU crypto library'
lic='LGPL-2.1'
src='https://dev.gnupg.org/source/libgcrypt.git'
sty='git'
cfg='ag'
eta='60'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-doc"

case $arch in
    aarch64*|arm*) CFG="$CFG --disable-aesni-support --disable-shaext-support --disable-pclmul-support --disable-sse41-support --disable-drng-support --disable-avx-support --disable-avx2-support";;
esac

start