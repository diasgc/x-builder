#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   .   .   F   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

# issues:
# *-android:
# aarch64-linux-gnu: Unsupported linker, only bfd, gold, and lld are supported, not aarch64-linux-gnu-ld
lib='libpulse'
apt="${lib}-dev"
dsc='PulseAudio Client Interface'
lic='LGPL-2.1'
vrs='15.0'
src="https://www.freedesktop.org/software/pulseaudio/releases/pulseaudio-${vrs}.tar.xz"
sty='txz'
#src='https://gitlab.freedesktop.org/pulseaudio/pulseaudio.git'
#sty='git'
cfg='meson'
dep='libtool fftw samplerate soxr speex sndfile'
pkg='pulseaudio'
eta='60'

. xbuilder.sh

BUILD_DIR=$SRCDIR/build_${arch}
MAKE_EXECUTABLE=ninja

CFG="-Ddaemon=false -Ddoxygen=false -Dman=false -Dtests=false -Ddatabase=simple -Dalsa=disabled -Dglib=disabled"

case ${arch} in
     aarch*|arm*) CFG="$CFG -Datomic-arm-linux-helpers=true";;
esac

build_make_package(){
    DESTDIR=${1} ninja -C ${BUILD_DIR} install
}

start