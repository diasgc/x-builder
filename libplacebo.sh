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

dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

lst_inc='libplacebo/*.h'
lst_lib='libplacebo'
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc=''
. xbuilder.sh
meson_cfg="-Ddemos=false"
case $host_os in
    android) dep='glslang vulkan' meson_cfg+=" -Dvulkan-registry=${dir_install}/share/vulkan/registry/vk.xml";;
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
