#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc
# latest: 2.3.0

lib='vmaf'
pkg='libvmaf'
dsc='Perceptual video quality assessment based on multi-method fusion'
lic='BSD-2c Patent'
src='https://github.com/Netflix/vmaf.git'
cfg='meson'
eta='52'
config_dir="libvmaf"
CFG='-Denable_docs=false -Denable_tests=false'
lst_inc='libvmaf/model.h libvmaf/feature.h libvmaf/picture.h
    libvmaf/libvmaf.h libvmaf/version.h libvmaf/compute_vmaf.h'
lst_lib='libvmaf'
lst_bin='vmaf'

. xbuilder.sh

$host_arm || CFG+=' -enable_avx512=true'

start

# Filelist
# --------
# include/libvmaf/model.h
# include/libvmaf/feature.h
# include/libvmaf/picture.h
# include/libvmaf/libvmaf.h
# include/libvmaf/version.h
# include/libvmaf/compute_vmaf.h
# lib/pkgconfig/libvmaf.pc
# lib/libvmaf.a
# bin/vmaf
