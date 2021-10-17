#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libxbc'
dsc='C interface to the X Window System protocol, which replaces the traditional Xlib interface.'
lic='GLP-2.0'
src='https://gitlab.freedesktop.org/xorg/lib/libxcb.git'
sty='git'
cfg='ag'
eta='0'
CFG='--enable-devel-docs'
#cshk=''
#cstk=''
#cbk=''
# XCBPROTO_LIBS XCBPROTO_CFLAGS NEEDED_CFLAGS NEEDED_LIBS XDMCP_CFLAGS XDMCP_LIBS CHECK_CFLAGS CHECK_LIBS
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start