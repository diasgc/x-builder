#!/bin/bash

lib='binutils'
dsc='GNU assembler, linker and binary utilities'
lic='MIT'
src='git://sourceware.org/git/binutils-gdb.git'
cfg='ac'
eta='60'
mkc='distclean'
spp=true
API=26 #nl_langinfo requires ndk api 26+

. xbuilder.sh

source_patch(){
    sed -i 's/&& WITH_TRACE_/\& WITH_TRACE_/g; s/_P && WITH_TRACE_/_P \& WITH_TRACE_/g' $SRCDIR/sim/common/sim-trace.c
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
