#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='sndfile'
apt='libsndfile1'
dsc='A library for reading and writing audio files'
lic='LGPL-3.0'
src='https://github.com/erikd/libsndfile.git'
sty='git'
cfg='cm'
tls='python'
dep='ogg vorbis opus flac speex'
eta='78'
cbk="BUILD_PROGRAMS"
cmake_path='lib/cmake/SndFile'

. xbuilder.sh

CFG="-DENABLE_PACKAGE_CONFIG=ON -DBUILD_TESTING=OFF" #-DINSTALL_MANPAGES=OFF

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
# share/man/man1/sndfile-cmp.1
# share/man/man1/sndfile-convert.1
# share/man/man1/sndfile-play.1
# share/man/man1/sndfile-salvage.1
# share/man/man1/sndfile-interleave.1
# share/man/man1/sndfile-concat.1
# share/man/man1/sndfile-metadata-set.1
# share/man/man1/sndfile-metadata-get.1
# share/man/man1/sndfile-info.1
# share/man/man1/sndfile-deinterleave.1
# share/doc/libsndfile/bugs.md
# share/doc/libsndfile/new_file_type_howto.md
# share/doc/libsndfile/formats.md
# share/doc/libsndfile/embedded_files.md
# share/doc/libsndfile/command.md
# share/doc/libsndfile/sndfile_info.md
# share/doc/libsndfile/api.md
# share/doc/libsndfile/libsndfile.jpg
# share/doc/libsndfile/win32.md
# share/doc/libsndfile/lists.md
# share/doc/libsndfile/FAQ.md
# share/doc/libsndfile/index.md
# share/doc/libsndfile/octave.md
# share/doc/libsndfile/libsndfile.css
# share/doc/libsndfile/print.css
# share/doc/libsndfile/tutorial.md
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
