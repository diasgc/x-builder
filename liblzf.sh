#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  +   .   .   .   .   .   .   .   .   .   .  static
#  -   .   .   .   .   .   .   .   .   .   .  shared
#  +   .   .   .   .   .   .   .   .   .   .  bin

lib='liblzf'
apt='liblzf1'
dsc='General purpose data compression library'
lic='?'
vrs='3.6'
src="http://dist.schmorp.de/liblzf/liblzf-${vrs}.tar.gz"
cfg='ac'
eta='10'

pc_llib="-llzf"
pc_url="http://oldhome.schmorp.de/marc/liblzf.html"

lst_inc='lzf.h'
lst_lib='liblzf'
lst_bin='lzf'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT}"


build_patch_config(){
  mkd="prefix=$(build_packages_getdistdir) install"
  mkd_suffix="/"
}



start

# Filelist
# --------

# include/lzf.h
# lib/liblzf.a
# bin/lzf
