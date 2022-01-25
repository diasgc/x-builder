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

lst_inc='cddb/*.h'
lst_lib='libcddb.*'
lst_bin='cddb_query'
lst_lic='COPYING AUTHORS'
lst_pc='libcddb.pc'

CFG="--without-cdio"
WFLAGS='-Wno-header-guard'

. xbuilder.sh

source_patch(){
    # ix clang undefined symbol rpl_malloc error by disabling AC_FUNC_MALLOC
    sed -i 's|AC_FUNC_MALLOC|#AC_FUNC_MALLOC|' configure.ac
    # regenerate
    doAutoreconf ${dir_src}
}


start

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc
