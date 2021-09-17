#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='fastlz'
dsc='Small & portable byte-aligned LZ77 compression'
lic='MIT'
src='https://github.com/ariya/FastLZ.git'
sty='git'
cfg='mk'
eta='30'

. xbuilder.sh

build_all(){
    pushdir $SRCDIR
    rm *.o *.a *.so 2>/dev/null
    CFLAGS="-O3 -flto -fPIC -fPIE  -I. $CFLAGS"
    $CC $CFLAGS -c fastlz.c
    $AR rc libfastlz.a fastlz.o
    $LD --shared fastlz.o -o libfastlz.so
    popdir
}

start