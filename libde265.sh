#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK +++ +++  .   .  clang
# GNU +++  .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libde265'
apt='libde265-dev'
dsc='Open h.265 video codec implementation.'
lic='LGPL-3.0'
src='https://github.com/strukturag/libde265.git'
sty='git'
cfg='ag'
eta='140'
# don't use "--desable-shared"
csh0=' '
f_win_posix=true

. xbuilder.sh

$host_arm && CFG+=" --disable-sse --disable-arm"
# remove '--disable-shared' to prevent 'multiple definitions' error in libstdc++.a and libstdc++.dll.a
  # see similar https://github.com/opencv/opencv/pull/9052
$host_mingw && CSH=${CSH/"--disable-shared "}

start

# Filelist
# --------
# include/libde265/de265.h
# include/libde265/de265-version.h
# lib/pkgconfig/libde265.pc
# lib/libde265.la
# lib/libde265.so
# lib/libde265.a
# bin/acceleration_speed
# bin/rd-curves
# bin/enc265
# bin/hdrcopy
# bin/bjoentegaard
# bin/tests
# bin/yuv-distortion
# bin/block-rate-estim
# bin/dec265
# bin/gen-enc-table