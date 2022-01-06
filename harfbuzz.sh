#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='harfbuzz'
apt='libharfbuzz-dev'
dsc='HarfBuzz text shaping engine'
lic='Old MIT'
src='https://github.com/harfbuzz/harfbuzz.git'
cfg='ag'
tls='ragel'
dep='freetype'
eta='400'

. xbuilder.sh

case $build_tool in
	cmake)      $build_bin && CBN="-DHB_BUILD_UTILS=ON";;
	automake)   CFG="--with-libstdc++=yes --with-glib=no --with-gobject=no --with-cairo=no --with-fontconfig=no --with-icu=no --with-freetype=no"";;
esac

start

# Filelist
# --------
# include/harfbuzz/hb-subset.h
# include/harfbuzz/hb-ot-color.h
# include/harfbuzz/hb-ot-deprecated.h
# include/harfbuzz/hb-blob.h
# include/harfbuzz/hb-set.h
# include/harfbuzz/hb-aat-layout.h
# include/harfbuzz/hb-aat.h
# include/harfbuzz/hb-font.h
# include/harfbuzz/hb-shape-plan.h
# include/harfbuzz/hb.h
# include/harfbuzz/hb-ot.h
# include/harfbuzz/hb-face.h
# include/harfbuzz/hb-ot-layout.h
# include/harfbuzz/hb-unicode.h
# include/harfbuzz/hb-ot-shape.h
# include/harfbuzz/hb-version.h
# include/harfbuzz/hb-shape.h
# include/harfbuzz/hb-ot-name.h
# include/harfbuzz/hb-map.h
# include/harfbuzz/hb-ot-font.h
# include/harfbuzz/hb-ot-math.h
# include/harfbuzz/hb-ot-meta.h
# include/harfbuzz/hb-ot-metrics.h
# include/harfbuzz/hb-common.h
# include/harfbuzz/hb-buffer.h
# include/harfbuzz/hb-ot-var.h
# include/harfbuzz/hb-style.h
# include/harfbuzz/hb-draw.h
# include/harfbuzz/hb-deprecated.h
# lib/pkgconfig/harfbuzz.pc
# lib/pkgconfig/harfbuzz-subset.pc
# lib/libharfbuzz.so
# lib/cmake/harfbuzz/harfbuzz-config.cmake
# lib/libharfbuzz-subset.la
# lib/libharfbuzz-subset.so
# lib/libharfbuzz.a
# lib/libharfbuzz.la
# lib/libharfbuzz-subset.a
