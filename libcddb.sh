#!/bin/bash
# cpu  av8 av7 x86 x64  cc
# NDK  P+. P+.  .   .   clang
# GNU  P+.  .   .   .   gcc
# WIN  P+.  .   .  P++  clang

lib='libcddb'
apt='libcddb2-dev'
dsc='CDDB server access library'
lic='GPL?'
src='https://salsa.debian.org/nickg/libcddb.git'
cfg='ac'
dep='libiconv libcdio' # optional
eta='10'

. xbuilder.sh

CFG="--without-cdio"

source_patch(){
    # ix clang undefined symbol rpl_malloc error by disabling AC_FUNC_MALLOC
    sed -i 's|AC_FUNC_MALLOC|#AC_FUNC_MALLOC|' $SRCDIR/configure.ac
    # regenerate
    doAutoreconf $SRCDIR
}
wopts='-Wno-header-guard'

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
