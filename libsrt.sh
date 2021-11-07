#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libsrt'
apt='libsrt-openssl-dev'
pkg='srt'
dsc='Secure Reliable Transport (SRT) is an open source transport technology that optimizes streaming performance across unpredictable networks, such as the Internet.'
lic='MPL-2.0'
src='https://github.com/Haivision/srt.git'
sty='git'
cfg='cm'
dep='openssl'
eta='60'

. xbuilder.sh

start

# Filelist
# --------

# include/srt/platform_sys.h
# include/srt/udt.h
# include/srt/srt.h
# include/srt/access_control.h
# include/srt/version.h
# include/srt/logging_api.h
# lib/pkgconfig/haisrt.pc
# lib/pkgconfig/srt.pc
# lib/libsrt.so
# lib/libsrt.a
# bin/srt-live-transmit
# bin/srt-ffplay
# bin/srt-tunnel
# bin/srt-file-transmit
