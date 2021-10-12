#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN +++  .   .   .  clang/gcc

lib='jq'
dsc='Lightweight and flexible command-line JSON processor'
lic='Other'
vrs='jq-1.6' # latest
src='https://github.com/stedolan/jq.git'
cfg='ar'
dep='oniguruma'
eta='575'
pc_llib='-ljq'
lst_inc='jv.h jq.h'
lst_lib='libjq'
lst_bin='jq'
lst_lic='share/doc/jq/COPYING'

. xbuilder.sh

CFG="--disable-maintainer-mode --disable-docs --with-oniguruma=$LIBSDIR"
unset CSH

_source_patch(){
    pushdir $SRCDIR
    doLog 'git2' git submodule update --init # if building from git to get oniguruma
    popdir
}

start

# Filelist
# --------
# include/jv.h
# include/jq.h
# lib/libjq.so
# lib/libjq.la
# lib/libjq.a
# share/man/man1/jq.1
# share/doc/jq/AUTHORS
# share/doc/jq/README.md
# share/doc/jq/COPYING
# share/doc/jq/README
# bin/jq