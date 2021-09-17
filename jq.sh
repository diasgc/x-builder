#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='jq'
pkg='jq'
apt='jq'
dsc='Lightweight and flexible command-line JSON processor'
lic=''
src='https://github.com/stedolan/jq.git'
sty='git'
cfg='ar'
tls=''
dep=''
eta='22'
mkclean='distclean'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-oniguruma=builtin --disable-maintainer-mode "
CSH=0

source_patch(){
    pushdir $SRCDIR
    doLog 'git2' git submodule update --init # if building from git to get oniguruma
    popdir
}

start