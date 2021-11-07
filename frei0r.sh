#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  -   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

# issues:
# static build is disabled
# aarch64-android : ld: error: unable to find library -lcairo

lib='frei0r'
apt='frei0r-plugins'
dsc='A large collection of free and portable video plugins'
lic='GPL-2.0'
src='https://github.com/dyne/frei0r.git'
sty='git'
cfg='ag'
xdp='gavl opencv libcairo'
eta='275'
mki='install'

. xbuilder.sh

case $build_tool in
  cmake) CFG="-DWITHOUT_GAVL=ON -DWITHOUT_OPENCV=ON"; CSH="-DBUILD_SHARED_LIBS=ON";;
  automake) CSH="--enable-shared";;
esac

start

# Filelist
# --------

# include/frei0r.h
# lib/pkgconfig/frei0r.pc
# lib/frei0r-1/test_pat_C.so
# lib/frei0r-1/sopsat.so
# lib/frei0r-1/edgeglow.so
# lib/frei0r-1/alphainjection.so
# lib/frei0r-1/dodge.so
# lib/frei0r-1/normaliz0r.so
# lib/frei0r-1/test_pat_L.so
# lib/frei0r-1/cluster.so
# lib/frei0r-1/softglow.so
# lib/frei0r-1/glitch0r.so
# lib/frei0r-1/uvmap.so
# lib/frei0r-1/dither.so
# lib/frei0r-1/pr0file.so
# lib/frei0r-1/spillsupress.so
# lib/frei0r-1/color_only.so
# lib/frei0r-1/addition.so
# lib/frei0r-1/burn.so
# lib/frei0r-1/saturat0r.so
# lib/frei0r-1/delay0r.so
# lib/frei0r-1/hue.so
# lib/frei0r-1/c0rners.so
# lib/frei0r-1/lightgraffiti.so
# lib/frei0r-1/colorhalftone.so
# lib/frei0r-1/three_point_balance.so
# lib/frei0r-1/d90stairsteppingfix.so
# lib/frei0r-1/threelay0r.so
# lib/frei0r-1/ndvi.so
# lib/frei0r-1/tint0r.so
# lib/frei0r-1/vertigo.so
# lib/frei0r-1/scanline0r.so
# lib/frei0r-1/lighten.so
# lib/frei0r-1/colorize.so
# lib/frei0r-1/pr0be.so
# lib/frei0r-1/cartoon.so
# lib/frei0r-1/glow.so
# lib/frei0r-1/alphaout.so
# lib/frei0r-1/lissajous0r.so
# lib/frei0r-1/squareblur.so
# lib/frei0r-1/RGB.so
# lib/frei0r-1/brightness.so
# lib/frei0r-1/composition.so
# lib/frei0r-1/plasma.so
# lib/frei0r-1/alphaspot.so
# lib/frei0r-1/alphagrad.so
# lib/frei0r-1/ising0r.so
# lib/frei0r-1/colortap.so
# lib/frei0r-1/divide.so
# lib/frei0r-1/saturation.so
# lib/frei0r-1/pixeliz0r.so
# lib/frei0r-1/posterize.so
# lib/frei0r-1/value.so
# lib/frei0r-1/addition_alpha.so
# lib/frei0r-1/transparency.so
# lib/frei0r-1/primaries.so
# lib/frei0r-1/lenscorrection.so
# lib/frei0r-1/subtract.so
# lib/frei0r-1/screen.so
# lib/frei0r-1/alphaxor.so
# lib/frei0r-1/tehroxx0r.so
# lib/frei0r-1/colgate.so
# lib/frei0r-1/twolay0r.so
# lib/frei0r-1/onecol0r.so
# lib/frei0r-1/timeout.so
# lib/frei0r-1/baltan.so
# lib/frei0r-1/test_pat_B.so
# lib/frei0r-1/coloradj_RGB.so
# lib/frei0r-1/hardlight.so
# lib/frei0r-1/alphaover.so
# lib/frei0r-1/R.so
# lib/frei0r-1/vignette.so
# lib/frei0r-1/delaygrab.so
# lib/frei0r-1/sigmoidaltransfer.so
# lib/frei0r-1/bw0r.so
# lib/frei0r-1/blend.so
# lib/frei0r-1/test_pat_G.so
# lib/frei0r-1/distort0r.so
# lib/frei0r-1/balanc0r.so
# lib/frei0r-1/invert0r.so
# lib/frei0r-1/xfade0r.so
# lib/frei0r-1/darken.so
# lib/frei0r-1/flippo.so
# lib/frei0r-1/curves.so
# lib/frei0r-1/B.so
# lib/frei0r-1/luminance.so
# lib/frei0r-1/select0r.so
# lib/frei0r-1/rgbnoise.so
# lib/frei0r-1/bluescreen0r.so
# lib/frei0r-1/equaliz0r.so
# lib/frei0r-1/3dflippo.so
# lib/frei0r-1/premultiply.so
# lib/frei0r-1/test_pat_I.so
# lib/frei0r-1/mask0mate.so
# lib/frei0r-1/nois0r.so
# lib/frei0r-1/emboss.so
# lib/frei0r-1/elastic_scale.so
# lib/frei0r-1/threshold0r.so
# lib/frei0r-1/nosync0r.so
# lib/frei0r-1/defish0r.so
# lib/frei0r-1/test_pat_R.so
# lib/frei0r-1/alpha0ps.so
# lib/frei0r-1/hueshift0r.so
# lib/frei0r-1/grain_extract.so
# lib/frei0r-1/softlight.so
# lib/frei0r-1/sharpness.so
# lib/frei0r-1/colordistance.so
# lib/frei0r-1/contrast0r.so
# lib/frei0r-1/alphaatop.so
# lib/frei0r-1/rgbsplit0r.so
# lib/frei0r-1/letterb0xed.so
# lib/frei0r-1/IIRblur.so
# lib/frei0r-1/aech0r.so
# lib/frei0r-1/sobel.so
# lib/frei0r-1/alphain.so
# lib/frei0r-1/difference.so
# lib/frei0r-1/nervous.so
# lib/frei0r-1/gamma.so
# lib/frei0r-1/keyspillm0pup.so
# lib/frei0r-1/overlay.so
# lib/frei0r-1/partik0l.so
# lib/frei0r-1/grain_merge.so
# lib/frei0r-1/medians.so
# lib/frei0r-1/multiply.so
# lib/frei0r-1/G.so
# lib/frei0r-1/levels.so
# lib/frei0r-1/hqdn3d.so
# lib/frei0r-1/perspective.so
# lib/frei0r-1/bgsubtract0r.so
# share/doc/frei0r-plugins/AUTHORS
# share/doc/frei0r-plugins/README.md
# share/doc/frei0r-plugins/ChangeLog
# share/doc/frei0r-plugins/TODO
