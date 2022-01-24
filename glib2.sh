#!/bin/bash

lib='glib2'
pkg='glib-2.0'
apt='libglib2.0-dev'
dsc='GLib is a library containing many useful C routines for things such as trees, hashes, lists, and strings'
lic='LGPL-2.1'
src='https://gitlab.gnome.org/GNOME/glib.git'
dep='libiconv libffi'
cfg='meson'
eta='220'
CFG='-Dgtk_doc=false -Dman=false'

lst_inc='libintl.h glib-2.0/*.h glib-2.0/glib/*.h glib-2.0/gobject/*.h glib-2.0/gio/*.h'
lst_lib='libintl.* libgio-2.0.* libglib-2.0.* libgthread-2.0.* libgobject-2.0.* libgmodule-2.0.*'
lst_bin='glib-gettextize gdbus glib-genmarshal gdbus-codegen gio-querymodules gobject-query glib-compile-schemas gresource gsettings gio glib-mkenums gtester-report'
lst_lic='COPYING AUTHORS'
lst_pc='glib-2.0.pc gio-2.0.pc gio-windows-2.0.pc gmodule-2.0.pc gmodule-export-2.0.pc gobject-2.0.pc gthread-2.0.pc gmodule-no-export-2.0.pc'

. xbuilder.sh

build_patch_config(){
    mkf="-C ${dir_build}"
    mki="${mkf} install"
}

build_make_package(){
    DESTDIR=${1} ninja -C ${dir_build} install
}

$host_mingw && CFG+=' -Dlibelf=disabled -Dforce_posix_threads=true'
WFLAGS='-Wno-unused-result -Wno-unused-variable -Wno-unused-function -Wno-array-bounds'
LDFLAGS+=" -L${dir_install_lib} -liconv -lffi"

start

# cpu av8 av7 x86 x64
# NDK +++ +++ ... ... CLANG
# GNU +++ +++ ... ... GCC
# WIN +++ ... ... +++ CLANG/GCC