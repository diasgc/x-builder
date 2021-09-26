#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   +   .   .   .   .   .  static
#  +   .   .   .   +   .   .   .   .   .   .  shared
#  +   .   .   .   f   .   .   .   .   .   .  bin

lib='flif'
dsc='Free Lossless Image Format'
lic='BSD-2c'
src='https://github.com/FLIF-hub/FLIF.git'
sty='git'
cfg='cm'
dep='libpng'
eta='60'

pc_inc='flif_dec.h flif_enc.h flif.h flif_common.h'
pc_lib='libflif libflif_dec'
pc_bin='flif apng2flif gif2flif dflif'
pc_oth='share/FLIF/flif.magic \
        share/man/man1/flif.1 \
        share/mime/packages/flif-mime.xml \
        share/licenses/FLIF/LICENSE_Apache2 \
        share/licenses/FLIF/LICENSE \
        share/licenses/FLIF/LICENSE_GPL \
        share/licenses/FLIF/LICENSE_LGPL \
        share/licenses/FLIF/FLIF-CLA-template.txt'

. xbuilder.sh

#BUILD_DIR=$SRCDIR/build_${arch}
SRCDIR=$SRCDIR/src

source_patch(){
    # make option to disable sdl2
    sed -i '0,/^option/{s/^option(.*/option(USE_SDL "Use SDL" OFF)\n&/}' $SRCDIR/CMakeLists.txt
    sed -i '0,/^pkg_check_modules(PKG_SDL2/{s/^pkg_check_modules(PKG_SDL2/if (USE_SDL)\n&/}' $SRCDIR/CMakeLists.txt
    sed -i '0,/^include(FindPackageHandleStandardArgs)/{s/^include(FindPackageHandleStandardArgs)/endif(USE_SDL)\n\n&/}' $SRCDIR/CMakeLists.txt
}

build_pkgconfig_file(){
    create_pkgconfig_file 'flif_dec' '-lflif_dec'
    create_pkgconfig_file 'flif' '-lflif'
}

start

# Filelist
# --------
# include/flif_dec.h
# include/flif_enc.h
# include/flif.h
# include/flif_common.h
# lib/libflif.a
# lib/libflif_dec.so
# lib/libflif_dec.a
# lib/libflif.so
# share/FLIF/flif.magic
# share/man/man1/flif.1
# share/mime/packages/flif-mime.xml
# share/licenses/FLIF/LICENSE_Apache2
# share/licenses/FLIF/LICENSE
# share/licenses/FLIF/LICENSE_GPL
# share/licenses/FLIF/LICENSE_LGPL
# share/licenses/FLIF/FLIF-CLA-template.txt
# bin/flif
# bin/apng2flif
# bin/gif2flif
# bin/dflif
