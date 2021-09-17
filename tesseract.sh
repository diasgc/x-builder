#!/bin/bash

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin
# PKGINFO-------------------------------------

lib='tesseract'
apt='libtesseract-dev'
dsc='An OCR Engine that was developed at HP Labs between 1985 and 1995... and now at Google'
lic='Apache-2.0'
src='https://github.com/tesseract-ocr/tesseract.git'
sty='git'
cfg='ag'
dep='leptonica'
pkg='tesseract'
mki="install-strip"
eta='420'
f_win_posix=true

. xbuilder.sh

if test $cfg = 'cm'; then 
  CFG="-DCMAKE_TOOLCHAIN_FILE=$(pwd)/cmake/${arch}.cmake -Dpkgcfg_lib_Leptonica_lept$LIBSDIR/lib/pkgconfig/lept.pc"
else
  CFG="--with-sysroot=${SYSROOT} --with-pic=1 --disable-debug \
    --disable-graphics \
    --disable-tessdata-prefix \
    --disable-largefile"
  [ -d $SRCDIR ] && [ ! -f $SRCDIR/configure ] && doAutogen $SRCDIR
fi

start

# Filelist
# --------

# include/tesseract/ltrresultiterator.h
# include/tesseract/ocrclass.h
# include/tesseract/capi.h
# include/tesseract/unichar.h
# include/tesseract/renderer.h
# include/tesseract/export.h
# include/tesseract/pageiterator.h
# include/tesseract/version.h
# include/tesseract/resultiterator.h
# include/tesseract/publictypes.h
# include/tesseract/osdetect.h
# include/tesseract/baseapi.h
# lib/pkgconfig/tesseract.pc
# lib/libtesseract.so
# lib/libtesseract.a
# lib/libtesseract.la
# share/tessdata/tessconfigs/batch
# share/tessdata/tessconfigs/msdemo
# share/tessdata/tessconfigs/batch.nochop
# share/tessdata/tessconfigs/matdemo
# share/tessdata/tessconfigs/segdemo
# share/tessdata/tessconfigs/nobatch
# share/tessdata/configs/logfile
# share/tessdata/configs/wordstrbox
# share/tessdata/configs/box.train
# share/tessdata/configs/get.images
# share/tessdata/configs/inter
# share/tessdata/configs/hocr
# share/tessdata/configs/makebox
# share/tessdata/configs/ambigs.train
# share/tessdata/configs/strokewidth
# share/tessdata/configs/unlv
# share/tessdata/configs/lstm.train
# share/tessdata/configs/txt
# share/tessdata/configs/linebox
# share/tessdata/configs/lstmbox
# share/tessdata/configs/rebox
# share/tessdata/configs/alto
# share/tessdata/configs/lstmdebug
# share/tessdata/configs/api_config
# share/tessdata/configs/bigram
# share/tessdata/configs/pdf
# share/tessdata/configs/digits
# share/tessdata/configs/kannada
# share/tessdata/configs/box.train.stderr
# share/tessdata/configs/quiet
# share/tessdata/configs/tsv
# share/tessdata/pdf.ttf
# bin/tesseract
