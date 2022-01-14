#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='cpio'
dsc='CPIO implementation from the GNU project'
lic='GLP-2.0'
src='https://ftp.gnu.org/gnu/cpio/cpio-latest.tar.gz'
cfg='cmake'
eta='0'

#options:
#  --disable-largefile     omit support for large files
#  --enable-mt             Enable building of mt program
#  --disable-rpath         do not hardcode runtime library paths
#  --disable-nls           do not use Native Language Support
#  --with-packager         String identifying the packager of this software
#  --with-packager-version     Packager-specific version information
#  --with-packager-bug-reports Packager info for bug reports (URL/e-mail/...)
#  --with-rmt=FILE         Use FILE as the default `rmt' program. Do not build included copy of `rmt'.
#  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]
#  --with-libiconv-prefix[=DIR]  search for libiconv in DIR/include and DIR/lib
#  --without-libiconv-prefix     don't search for libiconv in includedir and libdir
#  --with-libintl-prefix[=DIR]  search for libintl in DIR/include and DIR/lib
#  --without-libintl-prefix     don't search for libintl in includedir and libdir

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start