#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  +   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='libcddb'
apt='libcddb2-dev'
dsc='CDDB server access library'
lic='GPL?'
src='https://salsa.debian.org/nickg/libcddb.git'
sty='git'
dep='libiconv libcdio' # optional
cfg='ac'
eta='10'

. xbuilder.sh

source_patch(){
    # ix clang undefined symbol rpl_malloc error by disabling AC_FUNC_MALLOC
    sed -i 's|AC_FUNC_MALLOC|#AC_FUNC_MALLOC|' $SRCDIR/configure.ac
    # regenerate
    doAutoreconf $SRCDIR
}

CFG="--with-sysroot=${SYSROOT} --with-pic=1 --without-cdio"
CPPFLAGS="$CPPFLAGS -Wno-header-guard"

start

# Filelist
# --------

# include/cddb/cddb_error.h
# include/cddb/cddb_track.h
# include/cddb/cddb_disc.h
# include/cddb/cddb_cmd.h
# include/cddb/cddb.h
# include/cddb/cddb_config.h
# include/cddb/cddb_conn.h
# include/cddb/cddb_site.h
# include/cddb/version.h
# include/cddb/cddb_log.h
# lib/libcddb.a
# lib/pkgconfig/libcddb.pc
# lib/libcddb.so
# lib/libcddb.la
# bin/cddb_query
