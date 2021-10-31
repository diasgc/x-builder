#!/bin/bash
# cpu av8 av7 x86 x64
# NDK +++  .   .   .   clang
# GNU  F   .   .   F   gcc
# WIN  .   .   .   F   clang/gcc

lib='libcaca'
dsc='Colour AsCii Art library'
lic='GPL'
src='https://github.com/cacalabs/libcaca.git'
cfg='ac'
pkg='caca'
eta='80'

. xbuilder.sh

CFG="--disable-doc --disable-imlib2 --disable-java --disable-win32 --disable-cppunit --disable-zzuf --disable-conio"

HOST_NPROC=1
#LDFLAGS="-L$LIBSDIR/lib"

source_config(){
  sed -i 's/^AC_PREREQ/# &/' $SRCDIR/configure.ac
  $SRCDIR/bootstrap
  sed -i 's/if defined _WIN32/if defined _MSC_VER/g' $SRCDIR/caca/caca.h \
    $SRCDIR/caca/caca0.h $SRCDIR/caca/caca0.h $SRCDIR/caca/figfont.c \
    $SRCDIR/caca/string.c
  sed -i 's/if defined(_WIN32)/if defined(_MSC_VER)/g' $SRCDIR/cxx/caca++.h
  sed -i 's/-O2 -fno-strength-reduce/-O3 -flto/g' $SRCDIR/configure
}

build_patch_config(){
  CFLAGS+=" -Wno-ignored-optimization-argument -Wno-absolute-value -Wno-unused-but-set-variable"
}

start

<<'XB_APPLY_PATCH'
--- caca/driver/win32.c	2021-10-28 21:35:44.508000000 +0100
+++ caca/driver/win32.c	2021-10-28 21:35:47.115000000 +0100
@@ -23,7 +23,7 @@
 #define WIN32_LEAN_AND_MEAN
 #include <windows.h>
 
-#ifdef __MINGW32__
+#if defined(__MINGW32__) && !defined(__clang__)
 /* This is missing from the MinGW headers. */
 #   if (_WIN32_WINNT >= 0x0500)
 BOOL WINAPI GetCurrentConsoleFont(HANDLE hConsoleOutput, BOOL bMaximumWindow,
@@ -33,7 +33,6 @@
 #ifndef MOUSE_HWHEELED
 #   define MOUSE_HWHEELED 0x0008
 #endif
-
 #include <stdlib.h>
 #include <stdio.h>

XB_APPLY_PATCH

# Filelist
# --------
# include/caca++.h
# include/caca.h
# include/caca0.h
# include/caca_types.h
# include/caca_conio.h
# lib/pkgconfig/caca++.pc
# lib/pkgconfig/caca.pc
# lib/libcaca.so
# lib/libcaca++.so
# lib/libcaca++.la
# lib/libcaca.a
# lib/libcaca.la
# lib/libcaca++.a
# share/man/man1/img2txt.1
# share/man/man1/cacaserver.1
# share/man/man1/cacaview.1
# share/man/man1/cacafire.1
# share/man/man1/caca-config.1
# share/man/man1/cacaplay.1
# share/libcaca/caca.txt
# bin/caca-config
# bin/cacafire
# bin/cacaserver
# bin/img2txt
# bin/cacaclock
# bin/cacademo
# bin/cacaview
# bin/cacaplay
