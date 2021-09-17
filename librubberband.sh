#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='librubberband'
dsc='An audio time-stretching and pitch-shifting library and utility program.'
lic='GPL-2.0'
src='https://github.com/breakfastquay/rubberband.git'
sty='git'
cfg='meson'
dep='sndfile samplerate fftw'
pkg='rubberband'
eta='20'

. xbuilder.sh
BUILD_DIR=$SRCDIR/build_${arch}
MAKE_EXECUTABLE=ninja

CFG="-Dextra_include_dirs=$LIBSDIR/include -Dextra_lib_dirs=$LIBSDIR/lib"

build_make_package(){
    DESTDIR=${1} ninja -C ${BUILD_DIR} install
}
start


# Filelist
# --------

# include/rubberband/RubberBandStretcher.h
# include/rubberband/rubberband-c.h
# lib/pkgconfig/rubberband.pc
# lib/librubberband.so.2.1.4
# lib/librubberband.a
# lib/librubberband-jni.so
# bin/rubberband
