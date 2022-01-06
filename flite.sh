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
cfg='ac'
eta='80'
pc_llib='-lflite -lflite_cmu_grapheme_lang \
		 -lflite_cmu_grapheme_lex -lflite_cmu_indic_lang \
		 -lflite_cmu_indic_lex -lflite_cmulex -lflite_cmu_time_awb \
		 -lflite_cmu_us_awb -lflite_cmu_us_kal16 -lflite_cmu_us_kal \
		 -lflite_cmu_us_rms -lflite_cmu_us_slt -lflite_usenglish'
pc_libsprivate='-lm'

. xbuilder.sh

CFG="--with-pic"
unset CPPFLAGS

source_patch(){
	sed -i 's/MINGWPREF=\"i386-mingw32-\"/MINGWPREF=\"x86_64-w64-mingw32-\"/g' $SRCDIR/configure
}

start