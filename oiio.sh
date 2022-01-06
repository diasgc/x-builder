#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='oiio'
dsc='Reading, writing, and processing images in a wide variety of file formats, using a format-agnostic API, aimed at VFX applications'
lic='BSD-3c'
src='https://github.com/OpenImageIO/oiio.git'
url='openimageio.readthedocs.org'
dep='boost'
cfg='cmake'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start