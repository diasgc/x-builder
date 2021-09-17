#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='libressl'
pkg='libssl'
apt="${pkg}-dev"
dsc='Secure Sockets Layer and cryptography libraries'
lic='GPL'
src='https://github.com/libressl-portable/portable.git'
sty='git'
cfg='cm'
eta='120'
cbk="LIBRESSL_APPS"

. xbuilder.sh
CFG="-DLIBRESSL_TESTS=OFF -DENABLE_NC=ON -DENABLE_EXTRATESTS=OFF"

source_patch(){
  doAutogen $SRCDIR # do not remove
}

start