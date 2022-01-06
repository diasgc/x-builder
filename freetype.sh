#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   +   +   .   .   .   .   .   .   .  static
#  +   +   +   +   .   .   .   .   .   .   .  shared
#  -   -   -   -   .   .   .   .   .   .   .  bin

lib='freetype'
pkg='freetype2'
apt='libfreetype-dev'
dsc='A free, high-quality, and portable font engine.'
lic='BSD'
src='https://git.savannah.nongnu.org/r/freetype/freetype2.git'
cfg='ag'
dep='libpng brotli bzip2 harfbuzz'
eta='60'
#cmake_path="lib/cmake/freetype"

. xbuilder.sh

start

# Filelist
# --------

# include/freetype2/ft2build.h
# include/freetype2/freetype/ftmoderr.h
# include/freetype2/freetype/ftwinfnt.h
# include/freetype2/freetype/ftbbox.h
# include/freetype2/freetype/ftcolor.h
# include/freetype2/freetype/ftfntfmt.h
# include/freetype2/freetype/ftmm.h
# include/freetype2/freetype/fterrors.h
# include/freetype2/freetype/ftlcdfil.h
# include/freetype2/freetype/ftgzip.h
# include/freetype2/freetype/freetype.h
# include/freetype2/freetype/tttables.h
# include/freetype2/freetype/ftimage.h
# include/freetype2/freetype/ftincrem.h
# include/freetype2/freetype/ftgasp.h
# include/freetype2/freetype/ftadvanc.h
# include/freetype2/freetype/tttags.h
# include/freetype2/freetype/ftmodapi.h
# include/freetype2/freetype/ftrender.h
# include/freetype2/freetype/ftcache.h
# include/freetype2/freetype/config/ftoption.h
# include/freetype2/freetype/config/ftconfig.h
# include/freetype2/freetype/config/ftheader.h
# include/freetype2/freetype/config/ftstdlib.h
# include/freetype2/freetype/config/integer-types.h
# include/freetype2/freetype/config/ftmodule.h
# include/freetype2/freetype/config/mac-support.h
# include/freetype2/freetype/config/public-macros.h
# include/freetype2/freetype/ftoutln.h
# include/freetype2/freetype/fttrigon.h
# include/freetype2/freetype/ftdriver.h
# include/freetype2/freetype/ftsizes.h
# include/freetype2/freetype/ftsynth.h
# include/freetype2/freetype/ftbzip2.h
# include/freetype2/freetype/ftlist.h
# include/freetype2/freetype/ftmac.h
# include/freetype2/freetype/ftsnames.h
# include/freetype2/freetype/ftglyph.h
# include/freetype2/freetype/ftstroke.h
# include/freetype2/freetype/ttnameid.h
# include/freetype2/freetype/ftbdf.h
# include/freetype2/freetype/t1tables.h
# include/freetype2/freetype/fterrdef.h
# include/freetype2/freetype/ftgxval.h
# include/freetype2/freetype/ftlogging.h
# include/freetype2/freetype/ftbitmap.h
# include/freetype2/freetype/ftpfr.h
# include/freetype2/freetype/ftlzw.h
# include/freetype2/freetype/ftchapters.h
# include/freetype2/freetype/ftcid.h
# include/freetype2/freetype/ftotval.h
# include/freetype2/freetype/fttypes.h
# include/freetype2/freetype/ftsystem.h
# include/freetype2/freetype/ftparams.h
# lib/pkgconfig/freetype2.pc
# lib/cmake/freetype/freetype-config-release.cmake
# lib/cmake/freetype/freetype-config.cmake
# lib/cmake/freetype/freetype-config-version.cmake
# lib/libfreetype.so
