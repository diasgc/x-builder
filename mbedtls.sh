#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  E   .   .   .   .   +   +   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   +   .   .   .   .   .  bin

#FAILS AT CONFIG LEVEL missing sources
lib='mbedtls'
apt="${lib}-dev"
dsc='An open source, portable, easy to use, readable and flexible SSL library.'
lic='Apache-2.0'
src='https://github.com/ARMmbed/mbedtls.git'
sty='git'
cfg='cm'
eta='22'
cshk="USE_SHARED_MBEDTLS_LIBRARY"
cbk="ENABLE_PROGRAMS"
# -----------------------------------------

. xbuilder.sh

_source_config(){
  pushdir $SRCDIR
  doLog 'prepare' git submodule update --init --recursive
  popdir
}

CFG="-DENABLE_TESTING=OFF -DUNSAFE_BUILD=OFF -DMBEDTLS_FATAL_WARNINGS=ON -DLINK_WITH_PTHREAD=OFF -DLINK_WITH_TRUSTED_STORAGE=OFF"

start