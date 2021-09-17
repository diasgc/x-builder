#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   F   .   .   .  -/+  .   .   .   .  static
#  +   .   F   .   .   .  +/-  .   .   .   .  shared
#  +   .   F   .   .   .   +   .   .   .   .  bin

# ANDROID: implicit declaration is invalid in C99 (pthread_setaffinity_np)

lib='svtav1'
dsc='SVT (Scalable Video Technology) for AV1 encoder/decoder library'
lic='BSD'
src='https://github.com/OpenVisualCloud/SVT-AV1.git'
sty='git'
cfg='cm'
pkg='SvtAv1Enc'
eta='45'
cbk="BUILD_APPS"

CFG="-DBUILD_TESTING=OFF"
AS=$YASM

. xbuilder.sh

[ "$PLATFORM" == "Android" ] && pushvar_l LDFLAGS "-L$SYSROOT/usr/${arch}/lib -llog"

source_patch(){
    # android patch to build shared libs
    # ndk doesn't have pthread_setaffinity_np and pthread_attr_setinheritsched
    sed -i 's/#if defined(__linux__)/& \&\& !defined(__ANDROID__)/' $SRCDIR/Source/Lib/Common/Codec/EbThreads.h
    sed -i 's/#ifndef EB_THREAD_SANITIZER_ENABLED/#if !defined EB_THREAD_SANITIZER_ENABLED \&\& !defined(__ANDROID__)/' $SRCDIR/Source/Lib/Common/Codec/EbThreads.c
}

start

# Filelist
# --------
# include/svt-av1/EbDebugMacros.h
# include/svt-av1/EbSvtAv1Formats.h
# include/svt-av1/EbSvtAv1ExtFrameBuf.h
# include/svt-av1/EbSvtAv1Enc.h
# include/svt-av1/EbSvtAv1ErrorCodes.h
# include/svt-av1/EbSvtAv1Metadata.h
# include/svt-av1/EbSvtAv1.h
# include/svt-av1/EbSvtAv1Dec.h
# lib/pkgconfig/SvtAv1Enc.pc
# lib/pkgconfig/SvtAv1Dec.pc
# lib/libSvtAv1Enc.so.0.8.6
# lib/libSvtAv1Dec.so.0.8.6
# bin/SvtAv1DecApp
# bin/SvtAv1EncApp
