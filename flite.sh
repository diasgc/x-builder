#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   F   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------
lib='flite'
dsc='A small fast portable speech synthesis system'
lic='GPL-2+'
src='https://github.com/festvox/flite.git'
sty='git'
cfg='ac'
tls=''
dep=''
pkg='flite'

eta='80'
lsz=41044
psz=
ets=(0 0 0 0 0 0 0 0 0 0 0)
ls0=(0 0 0 0 0 0 0 0 0 0 0)
ls1=(0 0 0 0 0 0 0 0 0 0 0)

cs0="--disable-shared --with-pic=1"
cs1="--enable-shared"
cb0=
cb1=
CSH=$cs0
CBN=$cb0
# -----------------------------------------

. tcutils.sh
dbld=$SRCDIR
CFG=
loadToolchain
if test $arch != x86_64-linux-gnu; then CFG="--host=${arch} --with-sysroot=${SYSROOT} $CFG"; fi

# Use function buildSrc to custom clone repo
# Use function patchSrc to custom patch src and/or configure
patchSrc(){
  sed -i 's/MINGWPREF=\"i386-mingw32-\"/MINGWPREF=\"x86_64-w64-mingw32-\"/g' configure
}

# Use function buildLib to custom build
# Use function buildPC to manually build pkg-config .pc file
buildPC(){
  	cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=$INSTALL_DIR
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include

		Name: flite
		Description: a text to speech library
		Requires:
		Version: 2.1.0
		Libs: -L${libdir} -lflite -lflite_cmu_grapheme_lang -lflite_cmu_grapheme_lex -lflite_cmu_indic_lang -lflite_cmu_indic_lex -lflite_cmulex -lflite_cmu_time_awb -lflite_cmu_us_awb -lflite_cmu_us_kal16 -lflite_cmu_us_kal -lflite_cmu_us_rms -lflite_cmu_us_slt -lflite_usenglish
		Libs.private: -lm
		Cflags: -I${includedir}/flite/
		EOF
}

start