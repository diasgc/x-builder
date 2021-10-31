#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  F   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='gtk'
dsc='GTK is a multi-platform toolkit for creating graphical user interfaces'
lic='GLP-2.0'
src='https://gitlab.gnome.org/GNOME/gtk.git'
cfg='meson'
dep='shared-mime-info'
eta='0'
CFG='-Ddemos=false -Dbuild-examples=false 
     -Dbuild-tests=false -Dwin32-backend=false'
API=28

#cshk=''
#cstk=''
#cbk=''

lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start