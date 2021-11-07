#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   F   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='icu'
apt='libicu-dev'
dsc='International Components for Unicode'
lic='Other'
src='https://github.com/unicode-org/icu.git'
sty='git'
cfg='ac'
eta='80'
#pc_llib=''

. xbuilder.sh

SRCDIR=$SRCDIR/icu4c/source
CFG="--with-cross-build=${SRCDIR}"
start