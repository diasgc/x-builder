#!/bin/bash
# cpu av8 av7 x86 x64
# NDK PP+  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libssh'
dsc='The SSH library'
lic='GLP-2.0'
src='https://git.libssh.org/projects/libssh.git'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/libssh/sftp.h
# include/libssh/libssh_version.h
# include/libssh/server.h
# include/libssh/libssh.h
# include/libssh/ssh2.h
# include/libssh/legacy.h
# include/libssh/callbacks.h
# include/libssh/libsshpp.hpp
# lib/pkgconfig/libssh.pc
# lib/cmake/libssh/libssh-config-release.cmake
# lib/cmake/libssh/libssh-config.cmake
# lib/cmake/libssh/libssh-config-version.cmake
# lib/libssh.so
