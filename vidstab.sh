#!/bin/bash

lib='vidstab'
apt='libvidstab-dev'
dsc='Vidstab is a video stabilization library which can be plugged-in with Ffmpeg and Transcode'
lic='GPL-2+'
src='https://github.com/georgmartius/vid.stab.git'
sty='git'
cfg='cm'
eta='80'

. xbuilder.sh

case $arch in
  aarch64*|arm* ) CFG="$CFG -DSSE2_FOUND=OFF";;
esac

source_patch(){
  # make static + shared
  sed -i 's/add_library (vidstab \${SOURCES})/add_library (vidstab SHARED \${SOURCES})\nadd_library (vidstab_static STATIC \${SOURCES})\nset_target_properties(vidstab vidstab_static PROPERTIES OUTPUT_NAME vidstab)/' $SRCDIR/CMakeLists.txt
  sed -i 's/INSTALL(TARGETS vidstab/INSTALL(TARGETS vidstab vidstab_static/' $SRCDIR/CMakeLists.txt
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +  .   .   +   +   +   +   .   .   .   .  static
#  +  .   .   +   +   +   +   .   .   .   .  shared
#  -  .   .   .   .   .   .   .   .   .   .  bin

# Filelist
# --------
# include/vid.stab/vidstabdefines.h
# include/vid.stab/motiondetect_opt.h
# include/vid.stab/transformtype.h
# include/vid.stab/libvidstab.h
# include/vid.stab/vsvector.h
# include/vid.stab/motiondetect.h
# include/vid.stab/transform_internal.h
# include/vid.stab/transform.h
# include/vid.stab/transformtype_operations.h
# include/vid.stab/frameinfo.h
# include/vid.stab/motiondetect_internal.h
# include/vid.stab/serialize.h
# include/vid.stab/transformfixedpoint.h
# include/vid.stab/transformfloat.h
# include/vid.stab/localmotion2transform.h
# include/vid.stab/boxblur.h
# lib/pkgconfig/vidstab.pc
# lib/libvidstab.a
# lib/libvidstab.so
