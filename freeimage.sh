#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++  ... ... ...
# linux-gnu   ++  ... ... ...
# mingw-llvm  ... ... ... ...

lib='freeimage'
apt="${lib}-dev"
dsc='Open Source library to support popular graphics image formats like PNG, BMP, JPEG, TIFF'
lic='Other'
src='https://svn.code.sf.net/p/freeimage/svn/'
cfg='cmake'
eta='440'
pc_llib="-lfreeimage"

lst_inc='FreeImage.h FreeImagePlus.h'
lst_lib='libFreeImage'
lst_bin=''

. xbuilder.sh

source_config(){
    mv $SRCDIR/FreeImage/trunk $SRCDIR/..
    rm -rf $SRCDIR
    mv $SOURCES/trunk $SRCDIR
}

source_patch(){
    cd ${SRCDIR}
    cp Source/FreeImage.h Dist
    s0=$(cat Makefile.srcs | sed -e 's| Source| ./Source|g; s| \./|\n\t|g')
    #s1=$(cat ${SRCDIR}/fipMakefile.srcs | sed -e 's| Source| ./Sources|g; s| \./|\n\t|g')
    local srcs=$(echo "$s0" | sed -n '/SRCS/,/INCLS/p' | sed '1d; $d')
    #local sfip=$(echo "$s1" | sed -n '/SRCS/,/INCLUDE = /p' | sed '1d; $d')
    local hdrs=$(echo "$s0" | sed -n '/INCLS/,/\n\n/p' | sed '1d; $d')
    local incl=$(echo "$s0" | sed -n '/INCLUDE = /,/$/p' | sed ' s/ -I/\n\t/g' | sed '1,2d')
    echo "$(awk -v r="$srcs" '{gsub(/@sourcelist@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
    echo "$(awk -v r="$hdrs" '{gsub(/@headerlist@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
    echo "$(awk -v r="$incl" '{gsub(/@incldir_list@/,r)}1' CMakeLists.txt)" > CMakeLists.txt
}

start

<<'XB64_PATCH'
LS0tIENNYWtlTGlzdHMudHh0XwkyMDIyLTAxLTIwIDE5OjAwOjEyLjczMTU1ODAwMCArMDAw
MAorKysgQ01ha2VMaXN0cy50eHQJMjAyMi0wMS0yMCAxODo1NjoyNi43MTE1NTgwMDAgKzAw
MDAKQEAgLTAsMCArMSw1MyBAQAorY21ha2VfbWluaW11bV9yZXF1aXJlZChWRVJTSU9OIDMu
MTEpCisKK3Byb2plY3QoRnJlZUltYWdlKQorCitzZXQoVkVSTElCTkFNRSAzLjE5LjApCisK
K3NldChTUkNTIEBzb3VyY2VsaXN0QAorICAgICkKKworc2V0KEhEUlMgQGhlYWRlcmxpc3RA
CisgICAgKQorCitpbmNsdWRlX2RpcmVjdG9yaWVzKCR7Q01BS0VfU09VUkNFX0RJUn0KKyAg
ICBAaW5jbGRpcl9saXN0QAorICAgICkKKworc2V0IChBTExfU1JDICR7U1JDU30gJHtIRFJT
fSkKKworaWYoVU5JWCkKKwlhZGRfZGVmaW5pdGlvbnMoLU8zIC1mUElDIC1mZXhjZXB0aW9u
cyAtZnZpc2liaWxpdHk9aGlkZGVuIC1EX19BTlNJX18pCisJc2V0KENNQUtFX0NfRkxBR1Mg
IiR7Q01BS0VfQ19GTEFHU30gLXN0ZD1jOTkgLURPUEpfU1RBVElDIC1ETk9fTENNUyAtRERJ
U0FCTEVfUEVSRl9NRUFTVVJFTUVOVCIpCisJc2V0KENNQUtFX1NIQVJFRF9MSU5LRVJfRkxB
R1MgIiR7Q01BS0VfU0hBUkVEX0xJTktFUl9GTEFHU30gLWxzdGRjKysgLWxtIikKKwlzZXQo
Q01BS0VfQ1hYX0ZMQUdTICIke0NNQUtFX0NYWF9GTEFHU30gLXN0ZD1jKysweCIpCitlbHNl
KCkKKwkjIHRvZG8gbWluZ3czMgorCWFkZF9kZWZpbml0aW9ucygtTzMgLWZleGNlcHRpb25z
IC1ETkRFQlVHKQorCXNldChDTUFLRV9DX0ZMQUdTICIke0NNQUtFX0NfRkxBR1N9IC1ERElT
QUJMRV9QRVJGX01FQVNVUkVNRU5UIC1EX19BTlNJX18gLURPUEpfU1RBVElDIikKKwlzZXQo
Q01BS0VfQ1hYX0ZMQUdTICIke0NNQUtFX0NYWF9GTEFHU30gLWZ2aXNpYmlsaXR5PWhpZGRl
biAtV25vLWN0b3ItZHRvci1wcml2YWN5IikKKwlzZXQoQ01BS0VfU0hBUkVEX0xJTktFUl9G
TEFHUyAiJHtDTUFLRV9TSEFSRURfTElOS0VSX0ZMQUdTfSAtcyAtc2hhcmVkIC1zdGF0aWMg
LWx3czJfMzIiKQorZW5kaWYoKQorCitpZihDTUFLRV9TWVNURU1fUFJPQ0VTU09SIE1BVENI
RVMgIl5hIikKKwlzZXQoQ01BS0VfQ19GTEFHUyAiJHtDTUFLRV9DX0ZMQUdTfSAtRFBOR19B
Uk1fTkVPTl9PUFQ9T0ZGIikKK2VuZGlmKCkKKworYWRkX2xpYnJhcnkoZnJlZWltYWdlICR7
QUxMX1NSQ30pCitzZXQoVEFSR0VUUyBmcmVlaW1hZ2UgZnJlZWltYWdlX3N0YXRpYykKKwor
aWYoQlVJTERfU0hBUkVEX0xJQlMgQU5EIEJVSUxEX1NUQVRJQ19MSUJTKQorICAgIGFkZF9s
aWJyYXJ5KGZyZWVpbWFnZV9zdGF0aWMgU1RBVElDICR7QUxMX1NSQ30pCisgICAgc2V0X3Rh
cmdldF9wcm9wZXJ0aWVzKGZyZWVpbWFnZV9zdGF0aWMgUFJPUEVSVElFUyBPVVRQVVRfTkFN
RSBmcmVlaW1hZ2UpCisgICAgc2V0KFRBUkdFVFMgZnJlZWltYWdlIGZyZWVpbWFnZV9zdGF0
aWMpCitlbmRpZigpCisKK2luc3RhbGwoVEFSR0VUUyAke1RBUkdFVFN9CisgIFJVTlRJTUUg
REVTVElOQVRJT04gYmluCisgIExJQlJBUlkgREVTVElOQVRJT04gbGliJHtMSUJfU1VGRklY
fQorICBBUkNISVZFIERFU1RJTkFUSU9OIGxpYiR7TElCX1NVRkZJWH0KKykKKworaW5zdGFs
bChGSUxFUyBTb3VyY2UvRnJlZUltYWdlLmggREVTVElOQVRJT04gaW5jbHVkZSkKK2luc3Rh
bGwoRklMRVMgV3JhcHBlci9GcmVlSW1hZ2VQbHVzL0ZyZWVJbWFnZVBsdXMuaCBERVNUSU5B
VElPTiBpbmNsdWRlKQoraW5zdGFsbChGSUxFUyBsaWNlbmNlLSoudHh0IERFU1RJTkFUSU9O
IHNoYXJlL2RvY3MvRnJlZUltYWdlKQpcIE5vIG5ld2xpbmUgYXQgZW5kIG9mIGZpbGUK
XB64_PATCH

# Filelist
# --------
# include/FreeImage.h
# include/FreeImagePlus.h
# lib/pkgconfig/freeimage.pc
# lib/libFreeImage.a
# lib/libFreeImage.so
