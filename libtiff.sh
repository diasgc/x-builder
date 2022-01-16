#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  P   P   .   .   +   +   .   .   .   .   .  static
#  P   P   +   +   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

lib='libtiff'
apt="${lib}-dev"
dsc='TIFF Library and Utilities'
vrs='v4.3.0'
lic='GPL?'
src='https://gitlab.com/libtiff/libtiff.git'
cfg='cmake'
pkg='libtiff-4'
eta='150'
mkc='distclean'
mki='install/strip'
dep='liblzma libjpeg libzstd libwebp libdeflate lerc'
CFG="-Dlzma=ON -Djpeg=ON -Dzstd=ON -Dwebp=ON -Dlerc=ON -Dlibdeflate=ON"
mingw_posix=true

extraOpts(){
    case $1 in
        --min) unset dep CFG;;
    esac
}

. xbuilder.sh

# cmake doesn't supports dual static-shared build
if $build_static && $build_shared; then
    cfg='ag'
    build_tool="automake"
    CSH="--enable-shared --enable-static"
    mki='install-strip'
    CFG=
fi

start

# Filelist
# --------
# include/tiffio.hxx
# include/tiffio.h
# include/tiffconf.h
# include/tiffvers.h
# include/tiff.h
# share/man/man3/TIFFSetDirectory.3tiff
# share/man/man3/TIFFcolor.3tiff
# share/man/man3/TIFFWriteRawStrip.3tiff
# share/man/man3/TIFFFieldTag.3tiff
# share/man/man3/TIFFswab.3tiff
# share/man/man3/TIFFFieldDataType.3tiff
# share/man/man3/TIFFOpen.3tiff
# share/man/man3/TIFFSetField.3tiff
# share/man/man3/TIFFError.3tiff
# share/man/man3/TIFFReadRGBAStrip.3tiff
# share/man/man3/TIFFRGBAImage.3tiff
# share/man/man3/TIFFReadRGBATile.3tiff
# share/man/man3/TIFFReadRawTile.3tiff
# share/man/man3/TIFFFlush.3tiff
# share/man/man3/TIFFWarning.3tiff
# share/man/man3/TIFFbuffer.3tiff
# share/man/man3/TIFFmemory.3tiff
# share/man/man3/TIFFFieldName.3tiff
# share/man/man3/libtiff.3tiff
# share/man/man3/TIFFFieldPassCount.3tiff
# share/man/man3/TIFFWriteDirectory.3tiff
# share/man/man3/TIFFquery.3tiff
# share/man/man3/TIFFtile.3tiff
# share/man/man3/TIFFReadRawStrip.3tiff
# share/man/man3/TIFFGetField.3tiff
# share/man/man3/TIFFReadRGBAImage.3tiff
# share/man/man3/TIFFFieldWriteCount.3tiff
# share/man/man3/TIFFWriteRawTile.3tiff
# share/man/man3/TIFFReadEncodedStrip.3tiff
# share/man/man3/TIFFReadTile.3tiff
# share/man/man3/TIFFPrintDirectory.3tiff
# share/man/man3/TIFFClose.3tiff
# share/man/man3/TIFFWriteEncodedStrip.3tiff
# share/man/man3/TIFFDataWidth.3tiff
# share/man/man3/TIFFReadEncodedTile.3tiff
# share/man/man3/TIFFReadScanline.3tiff
# share/man/man3/TIFFFieldReadCount.3tiff
# share/man/man3/TIFFcodec.3tiff
# share/man/man3/TIFFWriteTile.3tiff
# share/man/man3/TIFFWriteScanline.3tiff
# share/man/man3/TIFFWriteEncodedTile.3tiff
# share/man/man3/TIFFstrip.3tiff
# share/man/man3/TIFFsize.3tiff
# share/man/man3/TIFFReadDirectory.3tiff
# share/man/man1/tiffcrop.1
# share/man/man1/tiff2ps.1
# share/man/man1/raw2tiff.1
# share/man/man1/tiffcp.1
# share/man/man1/fax2ps.1
# share/man/man1/tiffdump.1
# share/man/man1/tiffcmp.1
# share/man/man1/tiffgt.1
# share/man/man1/tiffset.1
# share/man/man1/tiff2bw.1
# share/man/man1/pal2rgb.1
# share/man/man1/tiff2pdf.1
# share/man/man1/tiffsplit.1
# share/man/man1/tiffdither.1
# share/man/man1/ppm2tiff.1
# share/man/man1/fax2tiff.1
# share/man/man1/tiffmedian.1
# share/man/man1/tiff2rgba.1
# share/man/man1/tiffinfo.1
# share/doc/tiff-4.3.0/TODO
# share/doc/tiff-4.3.0/html/v3.4beta036.html
# share/doc/tiff-4.3.0/html/v3.7.0alpha.html
# share/doc/tiff-4.3.0/html/TIFFTechNote2.html
# share/doc/tiff-4.3.0/html/v3.7.1.html
# share/doc/tiff-4.3.0/html/bugs.html
# share/doc/tiff-4.3.0/html/v3.9.1.html
# share/doc/tiff-4.3.0/html/v3.9.0beta.html
# share/doc/tiff-4.3.0/html/v3.5.5.html
# share/doc/tiff-4.3.0/html/v3.4beta029.html
# share/doc/tiff-4.3.0/html/v3.4beta016.html
# share/doc/tiff-4.3.0/html/intro.html
# share/doc/tiff-4.3.0/html/v3.5.1.html
# share/doc/tiff-4.3.0/html/v3.7.3.html
# share/doc/tiff-4.3.0/html/v4.3.0.html
# share/doc/tiff-4.3.0/html/v3.5.4.html
# share/doc/tiff-4.3.0/html/v3.4beta024.html
# share/doc/tiff-4.3.0/html/v3.4beta033.html
# share/doc/tiff-4.3.0/html/document.html
# share/doc/tiff-4.3.0/html/v3.5.6-beta.html
# share/doc/tiff-4.3.0/html/internals.html
# share/doc/tiff-4.3.0/html/v3.5.3.html
# share/doc/tiff-4.3.0/html/v4.0.4.html
# share/doc/tiff-4.3.0/html/images.html
# share/doc/tiff-4.3.0/html/man/TIFFmemory.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFOpen.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffcrop.1.html
# share/doc/tiff-4.3.0/html/man/tiffgt.1.html
# share/doc/tiff-4.3.0/html/man/tiff2pdf.1.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFswab.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFSetField.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadRGBAStrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFWarning.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffmedian.1.html
# share/doc/tiff-4.3.0/html/man/tiff2ps.1.html
# share/doc/tiff-4.3.0/html/man/TIFFPrintDirectory.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteDirectory.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFlush.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/fax2tiff.1.html
# share/doc/tiff-4.3.0/html/man/ppm2tiff.1.html
# share/doc/tiff-4.3.0/html/man/TIFFbuffer.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldPassCount.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldReadCount.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadScanline.3tiff.html
# share/doc/tiff-4.3.0/html/man/pal2rgb.1.html
# share/doc/tiff-4.3.0/html/man/tiffset.1.html
# share/doc/tiff-4.3.0/html/man/TIFFcodec.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadRawTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffsplit.1.html
# share/doc/tiff-4.3.0/html/man/TIFFcolor.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFsize.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFClose.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFtile.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldTag.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffdump.1.html
# share/doc/tiff-4.3.0/html/man/tiff2bw.1.html
# share/doc/tiff-4.3.0/html/man/TIFFDataWidth.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadEncodedTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldDataType.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadEncodedStrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldWriteCount.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFSetDirectory.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFFieldName.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffcmp.1.html
# share/doc/tiff-4.3.0/html/man/TIFFGetField.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteEncodedTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiffdither.1.html
# share/doc/tiff-4.3.0/html/man/tiffinfo.1.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteRawTile.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadDirectory.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFError.3tiff.html
# share/doc/tiff-4.3.0/html/man/fax2ps.1.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteEncodedStrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadRGBAImage.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFstrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/raw2tiff.1.html
# share/doc/tiff-4.3.0/html/man/tiffcp.1.html
# share/doc/tiff-4.3.0/html/man/libtiff.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadRGBATile.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFReadRawStrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFquery.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteRawStrip.3tiff.html
# share/doc/tiff-4.3.0/html/man/TIFFWriteScanline.3tiff.html
# share/doc/tiff-4.3.0/html/man/index.html
# share/doc/tiff-4.3.0/html/man/TIFFRGBAImage.3tiff.html
# share/doc/tiff-4.3.0/html/man/tiff2rgba.1.html
# share/doc/tiff-4.3.0/html/v4.0.9.html
# share/doc/tiff-4.3.0/html/libtiff.html
# share/doc/tiff-4.3.0/html/v4.0.5.html
# share/doc/tiff-4.3.0/html/v4.0.2.html
# share/doc/tiff-4.3.0/html/v3.4beta031.html
# share/doc/tiff-4.3.0/html/v3.7.4.html
# share/doc/tiff-4.3.0/html/v4.0.1.html
# share/doc/tiff-4.3.0/html/v3.4beta035.html
# share/doc/tiff-4.3.0/html/v4.0.7.html
# share/doc/tiff-4.3.0/html/v4.2.0.html
# share/doc/tiff-4.3.0/html/v3.8.0.html
# share/doc/tiff-4.3.0/html/v3.4beta034.html
# share/doc/tiff-4.3.0/html/addingtags.html
# share/doc/tiff-4.3.0/html/v3.7.0.html
# share/doc/tiff-4.3.0/html/v3.7.0beta2.html
# share/doc/tiff-4.3.0/html/v4.0.3.html
# share/doc/tiff-4.3.0/html/v4.1.0.html
# share/doc/tiff-4.3.0/html/v4.0.0.html
# share/doc/tiff-4.3.0/html/tools.html
# share/doc/tiff-4.3.0/html/v3.6.1.html
# share/doc/tiff-4.3.0/html/v3.8.2.html
# share/doc/tiff-4.3.0/html/support.html
# share/doc/tiff-4.3.0/html/v4.0.4beta.html
# share/doc/tiff-4.3.0/html/v4.0.8.html
# share/doc/tiff-4.3.0/html/v3.8.1.html
# share/doc/tiff-4.3.0/html/build.html
# share/doc/tiff-4.3.0/html/v3.6.0.html
# share/doc/tiff-4.3.0/html/v3.7.0beta.html
# share/doc/tiff-4.3.0/html/v4.0.10.html
# share/doc/tiff-4.3.0/html/v3.4beta032.html
# share/doc/tiff-4.3.0/html/v4.0.6.html
# share/doc/tiff-4.3.0/html/v3.4beta018.html
# share/doc/tiff-4.3.0/html/v3.5.7.html
# share/doc/tiff-4.3.0/html/v3.9.2.html
# share/doc/tiff-4.3.0/html/v3.4beta028.html
# share/doc/tiff-4.3.0/html/v3.5.2.html
# share/doc/tiff-4.3.0/html/misc.html
# share/doc/tiff-4.3.0/html/images/back.gif
# share/doc/tiff-4.3.0/html/images/smallliz.jpg
# share/doc/tiff-4.3.0/html/images/note.gif
# share/doc/tiff-4.3.0/html/images/warning.gif
# share/doc/tiff-4.3.0/html/images/cat.gif
# share/doc/tiff-4.3.0/html/images/ring.gif
# share/doc/tiff-4.3.0/html/images/jello.jpg
# share/doc/tiff-4.3.0/html/images/jim.gif
# share/doc/tiff-4.3.0/html/images/quad.jpg
# share/doc/tiff-4.3.0/html/images/oxford.gif
# share/doc/tiff-4.3.0/html/images/strike.gif
# share/doc/tiff-4.3.0/html/images/cover.jpg
# share/doc/tiff-4.3.0/html/images/bali.jpg
# share/doc/tiff-4.3.0/html/images/dave.gif
# share/doc/tiff-4.3.0/html/images/cramps.gif
# share/doc/tiff-4.3.0/html/images/info.gif
# share/doc/tiff-4.3.0/html/contrib.html
# share/doc/tiff-4.3.0/html/v3.4beta007.html
# share/doc/tiff-4.3.0/html/index.html
# share/doc/tiff-4.3.0/html/v3.7.2.html
# share/doc/tiff-4.3.0/ChangeLog
# share/doc/tiff-4.3.0/VERSION
# share/doc/tiff-4.3.0/RELEASE-DATE
# share/doc/tiff-4.3.0/COPYRIGHT
# share/doc/tiff-4.3.0/README.md
# lib/libtiffxx.a
# lib/libtiff.a
# lib/libtiff.la
# lib/libtiffxx.so
# lib/libtiffxx.la
# lib/libtiff.so
# lib/pkgconfig/libtiff-4.pc
# bin/raw2tiff
# bin/fax2tiff
# bin/fax2ps
# bin/tiffcmp
# bin/tiff2pdf
# bin/tiffset
# bin/tiff2ps
# bin/tiffinfo
# bin/pal2rgb
# bin/tiffmedian
# bin/tiff2rgba
# bin/tiffcrop
# bin/tiffdump
# bin/ppm2tiff
# bin/tiff2bw
# bin/tiffdither
# bin/tiffcp
# bin/tiffsplit
