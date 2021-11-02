#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='pcre'
pkg='libpcre'
dsc=''
lic='BSD-3c'
src='https://sourceforge.net/projects/pcre/files/pcre/8.45/pcre-8.45.tar.gz'
cfg='cmake'
dep='bzip2 readline'
eta='0'

#cshk=''
#cstk=''
#cbk=''

lst_inc='pcre.h pcreposix.h pcrecpparg.h pcre_scanner.h pcre_stringpiece.h pcrecpp.h'
lst_lib='libpcreposix libpcrecpp libpcre'
lst_bin='pcre_scanner_unittest pcrecpp_unittest pcregrep pcre-config pcretest pcre_stringpiece_unittest'

. xbuilder.sh

$build_static && CSH="-DBUILD_SHARED_LIBS=OFF"

start

<<'XB_APPLY_PATCH'
--- pcrecpp.cc	2021-11-01 20:50:35.459000000 +0000
+++ pcrecpp.cc	2021-11-01 21:33:23.172387200 +0000
@@ -48,6 +48,9 @@
 #include "pcrecpp.h"
 #include "pcre_stringpiece.h"
 
+#if defined(__ANDROID__)
+#undef HAVE_STRTOQ
+#endif
 
 namespace pcrecpp {

--- CMakeLists.old	2021-11-01 21:38:45.675000000 +0000
+++ CMakeLists.txt	2021-11-01 21:41:04.482387200 +0000
@@ -127,7 +127,7 @@
 
 SET(BUILD_SHARED_LIBS OFF CACHE BOOL
     "Build shared libraries instead of static ones.")
-
+OPTION(INSTALL_DOCS "INSTALL DOCS AND MAN" OFF)
 OPTION(PCRE_BUILD_PCRE8 "Build 8 bit PCRE library" ON)
 
 OPTION(PCRE_BUILD_PCRE16 "Build 16 bit PCRE library" OFF)
@@ -958,10 +958,11 @@
         ENDFOREACH(man ${man3})
         SET(man3 ${man3_new})
 ENDIF(PCRE_BUILD_PCRECPP)
-
+IF(INSTALL_DOCS)
 INSTALL(FILES ${man1} DESTINATION man/man1)
 INSTALL(FILES ${man3} DESTINATION man/man3)
 INSTALL(FILES ${html} DESTINATION share/doc/pcre/html)
+ENDIF()
 INSTALL(FILES ${pc} DESTINATION ${CMAKE_INSTALL_LIBDIR}/pkgconfig)
 INSTALL(FILES "${CMAKE_CURRENT_BINARY_DIR}/pcre-config"
         DESTINATION bin

XB_APPLY_PATCH




# Filelist
# --------
# include/pcre.h
# include/pcreposix.h
# include/pcrecpparg.h
# include/pcre_scanner.h
# include/pcre_stringpiece.h
# include/pcrecpp.h
# lib/pkgconfig/libpcreposix.pc
# lib/pkgconfig/libpcre.pc
# lib/pkgconfig/libpcrecpp.pc
# lib/libpcreposix.a
# lib/libpcrecpp.a
# lib/libpcre.a
# bin/pcre_scanner_unittest
# bin/pcrecpp_unittest
# bin/pcregrep
# bin/pcre-config
# bin/pcretest
# bin/pcre_stringpiece_unittest
