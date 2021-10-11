#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK PP+  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='sndfile'
apt='libsndfile1'
dsc='A library for reading and writing audio files'
lic='LGPL-3.0'
src='https://github.com/erikd/libsndfile.git'
cfg='cmake'
tls='python'
dep='ogg vorbis opus flac speex'
eta='78'
cbk="BUILD_PROGRAMS"
CFG="-DENABLE_PACKAGE_CONFIG=ON -DBUILD_TESTING=OFF -DINSTALL_MANPAGES=OFF"
lst_inc='sndfile.h sndfile.hh'
lst_lib='libsndfile'
lst_bin='sndfile-convert
	sndfile-play
	sndfile-deinterleave
	sndfile-interleave
	sndfile-cmp
	sndfile-concat
	sndfile-info
	sndfile-metadata-set
	sndfile-metadata-get
	sndfile-salvage'

. xbuilder.sh



start

# Filelist
# --------
# include/sndfile.h
# include/sndfile.hh
# lib/pkgconfig/sndfile.pc
# lib/libsndfile.so
# lib/cmake/SndFile/SndFileConfigVersion.cmake
# lib/cmake/SndFile/SndFileTargets.cmake
# lib/cmake/SndFile/SndFileConfig.cmake
# lib/cmake/SndFile/SndFileTargets-release.cmake
# bin/sndfile-convert
# bin/sndfile-play
# bin/sndfile-deinterleave
# bin/sndfile-interleave
# bin/sndfile-cmp
# bin/sndfile-concat
# bin/sndfile-info
# bin/sndfile-metadata-set
# bin/sndfile-metadata-get
# bin/sndfile-salvage