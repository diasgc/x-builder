#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='sqlite3'
dsc='SQLite database engine'
lic='Other'
src='https://github.com/sqlite/sqlite.git'
cfg='ac'
eta='0'
tls='tcl'

lst_inc='sqlite3ext.h sqlite3.h'
lst_lib='libsqlite3'
lst_bin='sqlite3'

. xbuilder.sh

start

# Filelist
# --------
# include/sqlite3ext.h
# include/sqlite3.h
# lib/pkgconfig/sqlite3.pc
# lib/libsqlite3.a
# lib/libsqlite3.so.0.8.6
# lib/libsqlite3.la
# bin/sqlite3