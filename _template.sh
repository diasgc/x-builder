#!/bin/bash
# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib=''
dsc=''
lic='GLP-2.0'
src='https://github.com/'
cfg='cmake'
eta='0'

mki=''
mkc=''

# decaprated
cstk=''
cshk=''
cbk=''
# use this instead
cfg_static=''
cfg_shared=''
cfg_bin=''

dev_bra='main'
dev_vrs=''
stb_bra=''
stb_vrs=''

lst_inc=''
lst_lib=''
lst_bin=''
lst_lic='LICENSE AUTHORS'
lst_pc=''

eta='20'

. xbuilder.sh

CFG=

before_make(){
    return 1
}

on_make(){
    return 1
}

before_install(){
    return 1
}

on_strip(){
    return 1
}

on_install(){
    return 1
}

on_create_pc(){
    return 1
}

on_pack(){
    return 1
}

on_end(){
    return 1
}

start