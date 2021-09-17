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
sty='tgz'
cfg='ac'
eta='10'

. xbuilder.sh

CFG="--with-sysroot=${SYSROOT}"
pkgconfig_llib="-llzf"
pkgconfig_url="http://oldhome.schmorp.de/marc/liblzf.html"

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
