#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   +   F   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='flite'
apt='flite'
dsc='A small fast portable speech synthesis system'
lic='GPL-2+'
src='https://github.com/festvox/flite.git'
sty='git'
cfg='ac'
eta='80'

. xbuilder.sh

CFG="--with-pic"

source_patch(){
	pushdir $SRCDIR
	sed -i 's/MINGWPREF=\"i386-mingw32-\"/MINGWPREF=\"x86_64-w64-mingw32-\"/g' configure
	popdir
}

build_pkgconfig_file(){
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