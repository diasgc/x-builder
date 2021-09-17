#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   .   +   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin
# Issues: automake wont work

lib='fribidi'
apt='libfribidi0'
dsc='Unicode Bidirectional Algorithm Library'
lic='LGPL-2.1'
src='https://github.com/fribidi/fribidi.git'
sty='git'
cfg='meson'
eta='60'

. xbuilder.sh

CSH="-Ddefault_library=both"
CFG="-Db_pie=true -Db_lto=true -Ddocs=false"
MAKE_EXECUTABLE=ninja
case $PLATFORM in Windows) LD="bfd";; esac

start

# Filelist
# --------
# include/fribidi/fribidi-types.h
# include/fribidi/fribidi-flags.h
# include/fribidi/fribidi-bidi-types-list.h
# include/fribidi/fribidi-brackets.h
# include/fribidi/fribidi-bidi-types.h
# include/fribidi/fribidi-common.h
# include/fribidi/fribidi-enddecls.h
# include/fribidi/fribidi-char-sets-list.h
# include/fribidi/fribidi-config.h
# include/fribidi/fribidi-bidi.h
# include/fribidi/fribidi-shape.h
# include/fribidi/fribidi-begindecls.h
# include/fribidi/fribidi-mirroring.h
# include/fribidi/fribidi-unicode-version.h
# include/fribidi/fribidi-char-sets.h
# include/fribidi/fribidi-joining-types.h
# include/fribidi/fribidi-joining-types-list.h
# include/fribidi/fribidi-deprecated.h
# include/fribidi/fribidi-unicode.h
# include/fribidi/fribidi-arabic.h
# include/fribidi/fribidi-joining.h
# include/fribidi/fribidi.h
# lib/pkgconfig/fribidi.pc
# lib/libfribidi.a
# lib/libfribidi.so
# bin/fribidi
