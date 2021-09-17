#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   F   F   F   .   F   F   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='jxrlib'
pkg='libjxr'
dsc='JPEG XR Image Codec reference implementation library released by Microsoft'
lic='BSD-2c'
src='https://github.com/4creators/jxrlib.git'
sty='git'
cfg='mk'
#csh1="SHARED=true"
. xbuilder.sh

CFG="CC=$CC AR=$AR RANLIB=$RANLIB"
mki="DIR_INSTALL=$INSTALL_DIR install"

source_patch(){
	sed -i 's/\bar\b rvu/${AR} rvu/; s/\branlib\b /${RANLIB} /' $SRCDIR/Makefile
}

build_make_package(){
	$MAKE_EXECUTABLE DIR_INSTALL=${1} install
	mkd_suffix="/"
}

start

# Filelist
# --------
# include/libjxr/glue/JXRMeta.h
# include/libjxr/glue/JXRGlue.h
# include/libjxr/image/perfTimer.h
# include/libjxr/image/strcodec.h
# include/libjxr/image/ansi.h
# include/libjxr/image/xplatform_image.h
# include/libjxr/image/x86/x86.h
# include/libjxr/image/decode.h
# include/libjxr/image/common.h
# include/libjxr/image/strTransform.h
# include/libjxr/image/windowsmediaphoto.h
# include/libjxr/image/encode.h
# include/libjxr/common/wmspecstrings_undef.h
# include/libjxr/common/wmspecstring.h
# include/libjxr/common/wmspecstrings_strict.h
# include/libjxr/common/guiddef.h
# include/libjxr/common/wmspecstrings_adt.h
# include/libjxr/common/wmsal.h
# include/libjxr/test/JXRTest.h
# lib/pkgconfig/libjxr.pc
# lib/libjpegxr.a
# lib/libjxrglue.a
# share/doc/jxr-1.1/JPEGXR_DPK_Spec_1.0.doc
# share/doc/jxr-1.1/readme.txt
# bin/JxrEncApp
# bin/JxrDecApp
