#!/bin/bash

lib='libjpeg'
apt="${lib}-dev"
dsc='JPEG image codec that uses SIMD instructions'
lic='BSD'
src='https://github.com/libjpeg-turbo/libjpeg-turbo.git'
cfg='cmake'
eta='52'
cstk="ENABLE_STATIC"
cshk="ENABLE_SHARED"
cmake_path='lib/cmake/libjpeg-turbo'
mki='install/strip'

CFG="-DWITH_JPEG8=ON -DWITH_JPEG7=ON -DWITH_DOCS=OFF -DWITH_MAN=OFF"

extraOpts(){
  case $1 in
    --jpeg7) CFG="-DWITH_JPEG7=ON $CFG";;
    --jpeg8) CFG="-DWITH_JPEG8=ON $CFG";;
    --12bit) CFG="-DWITH_12BIT=ON $CFG";;
  esac
}


. xbuilder.sh

source_patch(){
  pushdir $SRCDIR

  # Add options: WITH_DOCS and WITH_MAN (default OFF)
  patch -p0 <<'EOF'
--- CMakeLists.txt	2021-09-18 20:51:56.191317400 +0100
+++ CMakeLists.txt	2021-09-18 20:55:08.651317400 +0100
@@ -1493,6 +1493,13 @@
 
 install(TARGETS rdjpgcom wrjpgcom RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
 
+option(WITH_DOCS "with docs" FALSE)
+boolean_number(WITH_DOCS)
+
+option(WITH_MAN "with man pages" FALSE)
+boolean_number(WITH_MAN)
+
+if(WITH_DOCS)
 install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/README.ijg
   ${CMAKE_CURRENT_SOURCE_DIR}/README.md ${CMAKE_CURRENT_SOURCE_DIR}/example.txt
   ${CMAKE_CURRENT_SOURCE_DIR}/tjexample.c
@@ -1500,12 +1507,13 @@
   ${CMAKE_CURRENT_SOURCE_DIR}/structure.txt
   ${CMAKE_CURRENT_SOURCE_DIR}/usage.txt ${CMAKE_CURRENT_SOURCE_DIR}/wizard.txt
   ${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.md DESTINATION ${CMAKE_INSTALL_DOCDIR})
+endif()
 if(WITH_JAVA)
   install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/java/TJExample.java
     DESTINATION ${CMAKE_INSTALL_DOCDIR})
 endif()
 
-if(UNIX OR MINGW)
+if(WITH_MAN AND UNIX OR MINGW)
   install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/cjpeg.1
     ${CMAKE_CURRENT_SOURCE_DIR}/djpeg.1 ${CMAKE_CURRENT_SOURCE_DIR}/jpegtran.1
     ${CMAKE_CURRENT_SOURCE_DIR}/rdjpgcom.1
EOF
  popdir
}

start

# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   +   .   .   +   .   .   .   .   .   .  static
#  +   +   .   .   .   .   .   .   .   .   .  shared
#  +   +   .   .   .   .   .   .   .   .   .  bin

# Filelist
# --------
# include/jerror.h
# include/jconfig.h
# include/jpeglib.h
# include/jmorecfg.h
# include/turbojpeg.h
# lib/pkgconfig/libjpeg.pc
# lib/pkgconfig/libturbojpeg.pc
# lib/libturbojpeg.a
# lib/cmake/libjpeg-turbo/libjpeg-turboTargets-release.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboConfig.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboConfigVersion.cmake
# lib/cmake/libjpeg-turbo/libjpeg-turboTargets.cmake
# lib/libjpeg.so.8.2.2
# lib/libturbojpeg.so.0.2.0
# lib/libjpeg.a
# bin/rdjpgcom
# bin/jpegtran
# bin/wrjpgcom
# bin/djpeg
# bin/tjbench
# bin/cjpeg
