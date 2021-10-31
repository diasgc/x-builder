#!/bin/bash
# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU ++   .   .  ++  gcc
# WIN ++   .   .  ++  clang/gcc

lib='libplacebo'
dsc='Reusable library for GPU-accelerated image/video processing primitives and shaders'
lic='LGLP-2.1'
src='https://code.videolan.org/videolan/libplacebo.git'
cfg='meson'
eta='0'
tls='python3-mako'

#cshk=''
#cstk=''
#cbk=''

lst_inc='libplacebo/config.h libplacebo/swapchain.h
    libplacebo/dither.h libplacebo/filters.h
    libplacebo/shaders.h libplacebo/log.h
    libplacebo/dispatch.h libplacebo/shaders/custom.h
    libplacebo/shaders/film_grain.h
    libplacebo/shaders/colorspace.h
    libplacebo/shaders/lut.h
    libplacebo/shaders/sampling.h
    libplacebo/vulkan.h libplacebo/gpu.h
    libplacebo/renderer.h libplacebo/common.h
    libplacebo/dummy.h libplacebo/context.h
    libplacebo/utils/libav_internal.h
    libplacebo/utils/dav1d.h
    libplacebo/utils/libav.h
    libplacebo/utils/upload.h
    libplacebo/utils/frame_queue.h
    libplacebo/utils/dav1d_internal.h
    libplacebo/colorspace.h'
lst_lib='libplacebo'
lst_bin=''

. xbuilder.sh
CFG="-Ddemos=false"
case $host_os in
    android) dep='glslang vulkan' CFG+=" -Dvulkan-registry=$LIBSDIR/share/vulkan/registry/vk.xml";;
    gnu) LD="bfd";;
esac
start

# Filelist
# --------
# include/libplacebo/config.h
# include/libplacebo/swapchain.h
# include/libplacebo/dither.h
# include/libplacebo/filters.h
# include/libplacebo/shaders.h
# include/libplacebo/log.h
# include/libplacebo/dispatch.h
# include/libplacebo/shaders/custom.h
# include/libplacebo/shaders/film_grain.h
# include/libplacebo/shaders/colorspace.h
# include/libplacebo/shaders/lut.h
# include/libplacebo/shaders/sampling.h
# include/libplacebo/vulkan.h
# include/libplacebo/gpu.h
# include/libplacebo/renderer.h
# include/libplacebo/common.h
# include/libplacebo/dummy.h
# include/libplacebo/context.h
# include/libplacebo/utils/libav_internal.h
# include/libplacebo/utils/dav1d.h
# include/libplacebo/utils/libav.h
# include/libplacebo/utils/upload.h
# include/libplacebo/utils/frame_queue.h
# include/libplacebo/utils/dav1d_internal.h
# include/libplacebo/colorspace.h
# lib/pkgconfig/libplacebo.pc
# lib/libplacebo.so
# lib/libplacebo.a
