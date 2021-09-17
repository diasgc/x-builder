#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  F   .   .   .   .   .   .   .   .   .   .  shared
#  -   .   .   .   .   .   .   .   .   .   .  bin

lib='vapoursynth'
dsc='A video processing framework with simplicity in mind'
lic='LGPL-2.1'
src='https://github.com/vapoursynth/vapoursynth.git'
sty='git'
cfg='ag'
tls='python'
dep='zimg'
eta='60'
mki='install-strip'
mkc='distclean'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --enable-python-module=no --enable-vspipe=no --enable-vsscript=no --enable-x86-asm=no"

start


# Filelist
# --------
# include/vapoursynth/VSScript4.h
# include/vapoursynth/VapourSynth4.h
# include/vapoursynth/VSConstants4.h
# include/vapoursynth/VSHelper.h
# include/vapoursynth/VSScript.h
# include/vapoursynth/VSHelper4.h
# include/vapoursynth/VapourSynth.h
# lib/pkgconfig/vapoursynth.pc
# lib/libvapoursynth.la
# lib/libvapoursynth.a
