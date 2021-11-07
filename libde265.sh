#!/bin/bash
# cpu  av8 av7 x86 x64  cc
# NDK  P+. P+.  .   .   clang
# GNU  P+.  .   .   .   gcc
# WIN  P+.  .   .  P++  clang

lib='libde265'
apt='libde265-dev'
dsc='Open h.265 video codec implementation.'
lic='LGPL-3.0'
src='https://github.com/strukturag/libde265.git'
cfg='cmake'
eta='140'

lst_inc='libde265/motion.h libde265/fallback-dct.h
  libde265/cabac.h libde265/deblock.h
  libde265/pps.h libde265/en265.h
  libde265/fallback-motion.h libde265/sei.h
  libde265/fallback.h libde265/image-io.h
  libde265/scan.h libde265/threads.h
  libde265/contextmodel.h libde265/transform.h
  libde265/bitstream.h libde265/sps.h
  libde265/vps.h libde265/slice.h
  libde265/md5.h libde265/alloc_pool.h
  libde265/image.h libde265/sao.h
  libde265/vui.h libde265/decctx.h
  libde265/refpic.h libde265/de265.h
  libde265/configparam.h libde265/quality.h
  libde265/de265-version.h libde265/nal.h
  libde265/nal-parser.h libde265/intrapred.h
  libde265/visualize.h libde265/acceleration.h
  libde265/dpb.h libde265/util.h'
lst_lib='liblibde265'
lst_bin='enc265 hdrcopy dec265'

. xbuilder.sh

case $cfg in
  cmake) CFG='-DENABLE_SDL=OFF'
         $host_arm && CFG+=' -DDISABLE_SSE=ON' || CFG+=' -DDISABLE_SSE=OFF'
         pc_llib='-lde265' pc_libsprivate='-lpthread  -lstdc++'
         ;;
  ag)    $host_arm && CFG+=" --disable-sse --disable-arm"
         $host_mingw && CSH=${CSH/"--disable-shared "} #see similar https://github.com/opencv/opencv/pull/9052
         ;;
esac

start

# Filelist
# --------
# include/libde265/motion.h
# include/libde265/fallback-dct.h
# include/libde265/cabac.h
# include/libde265/deblock.h
# include/libde265/pps.h
# include/libde265/en265.h
# include/libde265/fallback-motion.h
# include/libde265/sei.h
# include/libde265/fallback.h
# include/libde265/image-io.h
# include/libde265/scan.h
# include/libde265/threads.h
# include/libde265/contextmodel.h
# include/libde265/transform.h
# include/libde265/bitstream.h
# include/libde265/sps.h
# include/libde265/vps.h
# include/libde265/slice.h
# include/libde265/md5.h
# include/libde265/alloc_pool.h
# include/libde265/image.h
# include/libde265/sao.h
# include/libde265/vui.h
# include/libde265/decctx.h
# include/libde265/refpic.h
# include/libde265/de265.h
# include/libde265/configparam.h
# include/libde265/quality.h
# include/libde265/de265-version.h
# include/libde265/nal.h
# include/libde265/nal-parser.h
# include/libde265/intrapred.h
# include/libde265/visualize.h
# include/libde265/acceleration.h
# include/libde265/dpb.h
# include/libde265/util.h
# lib/pkgconfig/libde265.pc
# lib/cmake/libde265/libde265ConfigVersion.cmake
# lib/cmake/libde265/libde265Config-release.cmake
# lib/cmake/libde265/libde265Config.cmake
# lib/liblibde265.a
# bin/enc265
# bin/hdrcopy
# bin/dec265
