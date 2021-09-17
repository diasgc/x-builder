#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  F   .   .   .   +   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='isobmff'
dsc='ISO Base Media File Format Reference Software'
lic='?'
src='https://github.com/MPEGGroup/isobmff.git'
sty='git'
cfg='cm'
eta='60'

. xbuilder.sh

case $PLATFORM in
    Linux|Android) xinclude="-I$SRCDIR/IsoLib/libisomediafile/linux";;
    Windows) xinclude="-I$SRCDIR/IsoLib/libisomediafile/win32";;
esac
xinclude="$xinclude -I/$SRCDIR/external/Part04-Dynamic_Range_Control/trunk/modules/uniDrcModules/uniDrcBitstreamDecoderLib/include \
-I/$SRCDIR/external/Part04-Dynamic_Range_Control/trunk/modules/uniDrcModules/uniDrcCommon -I/$SRCDIR/external/Part04-Dynamic_Range_Control/trunk/tools/readonlubitbuf/include \
-I/$SRCDIR/external/Part04-Dynamic_Range_Control/trunk/tools/wavIO/include -I/$SRCDIR/external/Part04-Dynamic_Range_Control/trunk/tools/writeonlubitbuf/include"
CFLAGS="$CFLAGS $xinclude" CXXFLAGS="$CXXFLAGS $xinclude" CPPFLAGS="$CPPFLAGS $xinclude"
#mkf="libisoiff isoiff_tool"
 
source_patch(){
    pushdir $SRCDIR
    doLog 'submodule' git submodule update --init --recursive
    popdir
}
start
