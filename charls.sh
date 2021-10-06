#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+  .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='charls'
apt='libcharls-dev'
dsc='C++ JPEG-LS (ISO/IEC 14495-1 / ITU-T.87) library implementation.'
lic='BSD-3c'
src='https://github.com/team-charls/charls.git'
cfg='cmake'
eta='15'
cbk="CHARLS_BUILD_SAMPLES"
mki='install/strip'

. xbuilder.sh

start

# Filelist
# --------
# include/charls/charls_jpegls_decoder.h
# include/charls/api_abi.h
# include/charls/annotations.h
# include/charls/jpegls_error.h
# include/charls/public_types.h
# include/charls/charls.h
# include/charls/charls_jpegls_encoder.h
# include/charls/version.h
# lib/pkgconfig/charls.pc
# lib/cmake/charls/charlsConfig.cmake
# lib/cmake/charls/charlsConfig-release.cmake
# lib/libcharls.so
