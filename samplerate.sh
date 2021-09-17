#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
# -/+   .   .   .   .   .   .   .   .   .   .  static
# +/-   .   .   .   .   .   .   .   .   .   .  shared
#  -    .   .   .   .   .   .   .   .   .   .  bin

lib='samplerate'
dsc='An audio Sample Rate Conversion library'
lic='BSD'
src='https://github.com/erikd/libsamplerate.git'
sty='git'
cfg='cm'
dep='sndfile fftw'
pkg='samplerate'
eta='54'
#cbk="LIBSAMPLERATE_EXAMPLES"

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF -DLIBSAMPLERATE_EXAMPLES=OFF" # -DLIBSAMPLERATE_COMPATIBLE_NAME=OFF -DLIBSAMPLERATE_ENABLE_SANITIZER=OFF"

start

# Filelist
# --------

# include/samplerate.h
# lib/pkgconfig/samplerate.pc
# lib/libsamplerate.so
# lib/cmake/SampleRate/SampleRateTargets-release.cmake
# lib/cmake/SampleRate/SampleRateTargets.cmake
# lib/cmake/SampleRate/SampleRateConfigVersion.cmake
# lib/cmake/SampleRate/SampleRateConfig.cmake
# share/doc/libsamplerate/api_full.md
# share/doc/libsamplerate/bugs.md
# share/doc/libsamplerate/license.md
# share/doc/libsamplerate/SRC.png
# share/doc/libsamplerate/quality.md
# share/doc/libsamplerate/api_callback.md
# share/doc/libsamplerate/api_simple.md
# share/doc/libsamplerate/history.md
# share/doc/libsamplerate/api.md
# share/doc/libsamplerate/win32.md
# share/doc/libsamplerate/download.md
# share/doc/libsamplerate/faq.md
# share/doc/libsamplerate/lists.md
# share/doc/libsamplerate/api_misc.md
# share/doc/libsamplerate/index.md
