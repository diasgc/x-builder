#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='jq'
dsc='Lightweight and flexible command-line JSON processor'
lic='Other'
vrs='jq-1.6' # latest
src='https://github.com/stedolan/jq.git'
sty='git'
cfg='ar'
dep='oniguruma'
eta='22'
mkc='distclean'
mki='install-strip'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --disable-maintainer-mode --disable-docs --with-oniguruma=$LIBSDIR"
CSH=0

_source_patch(){
    pushdir $SRCDIR
    doLog 'git2' git submodule update --init # if building from git to get oniguruma
    popdir
}

start