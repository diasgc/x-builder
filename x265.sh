#!/bin/bash

# cpu av8 av7 x86 x64
# NDK +++ +++ +++ +++ clang
# GNU +++  .   .   .  gcc
# WIN +++  .   .  +++ clang/gcc

lib='x265'
dsc='x265 is an open source HEVC encoder'
lic='GPL-2.0'
#src='https://github.com/videolan/x265.git'
src='https://bitbucket.org/multicoreware/x265_git.git'
cfg='cmake'
tls='yasm libnuma-dev'
eta='130'
cmake_bin="ENABLE_CLI"
config_dir='source'
cshk='ENABLE_SHARED'

lst_inc='x265.h x265_config.h'
lst_lib='libx265'
lst_bin='x265'
lst_lic='COPYING'
lst_pc='x265.pc'

dev_bra='master'
dev_vrs='3.5'
stb_bra='stable'
stb_vrs='3.5'
multilib=false

extraOpts(){
    case $1 in
        --multilib) multilib=true;;
        --12bit) cmake_config='-DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DMAIN12=ON';;
        --10bit) cmake_config='-DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF'
    esac
    return 0
}

. xbuilder.sh

$build_shared && cmake_config="-DENABLE_SHARED=ON" || cmake_config="-DENABLE_SHARED=OFF"
$host_mingw && cmake_config+=" -DENABLE_PIC=OFF"
$host_arm && cmake_config+=" -DCROSS_COMPILE_ARM=ON -DENABLE_ASSEMBLY=OFF" || cmake_config+=" -DCMAKE_ASM_NASM_FLAGS=-w-macro-params-legacy"

before_make(){
    return 1
}

build_config(){
    cd ${dir_build}
    [ -z "${cmake_toolchain_file}" ] && cmake_create_toolchain ${dir_build}
    [ -f "${cmake_toolchain_file}" ] && cmake_config="-DCMAKE_TOOLCHAIN_FILE=${cmake_toolchain_file} $CFG -DCMAKE_INSTALL_PREFIX=${dir_install} -DCMAKE_BUILD_TYPE=${cmake_build_type} -DSTATIC_LINK_CRT=ON"
    if $multilib; then
        mkdir -p 10bit 12bit
        cd 12bit
        do_log '12bit' cmake ../../../source $cmake_config -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF -DMAIN12=ON
        do_progress 'make' make ${mkf} -j${HOST_NPROC}
        cd ../10bit
        do_log '10bit' cmake ../../../source $cmake_config -DHIGH_BIT_DEPTH=ON -DEXPORT_C_API=OFF -DENABLE_SHARED=OFF -DENABLE_CLI=OFF
        do_progress 'make' make ${mkf} -j${HOST_NPROC}
        cd ..
        ln -sf 10bit/libx265.a libx265_main10.a
        ln -sf 12bit/libx265.a libx265_main12.a
        do_log '8bit' cmake ../../source $cmake_config -DEXTRA_LIB="x265_main10.a;x265_main12.a" -DEXTRA_LINK_FLAGS=-L. -DLINKED_10BIT=ON -DLINKED_12BIT=ON $CSH $CBN
        do_progress 'make' make ${mkf} -j${HOST_NPROC}
        mv libx265.a libx265_main.a
        ${AR} -M <<-EOF
            CREATE libx265.a
            ADDLIB libx265_main.a
            ADDLIB libx265_main10.a
            ADDLIB libx265_main12.a
            SAVE
            END
			EOF
        skip_make=true
    else
        do_log 'cmake' $exec_config ${dir_config} ${cmake_config} ${CSH} ${CBN}
        case $cfg in ccm|ccmake) tput sc; ccmake ..; tput rc;; esac
    fi
    
}

start

#cpu patch for arm-mingw archs
# Do NOT edit---------------------------------------------------------------
<<'XB64_PATCH'
LS0tIHNvdXJjZS9DTWFrZUxpc3RzLnR4dAkyMDIxLTEwLTEwIDE4OjQ2OjMyLjQ1NTAwMDAwMCAr
MDEwMAorKysgc291cmNlL0NNYWtlTGlzdHMudHh0CTIwMjEtMTAtMTAgMTg6NTI6MTkuMDgzMzE0
NDAwICswMTAwCkBAIC0yMTksOSArMjE5LDkgQEAKICAgICBlbHNlKCkKICAgICAgICAgYWRkX2Rl
ZmluaXRpb25zKC1zdGQ9Z251Kys5OCkKICAgICBlbmRpZigpCi0gICAgaWYoRU5BQkxFX1BJQykK
KyAgICBpZihOT1QgV0lOMzIgQU5EIEVOQUJMRV9QSUMpCiAgICAgICAgICBhZGRfZGVmaW5pdGlv
bnMoLWZQSUMpCi0gICAgZW5kaWYoRU5BQkxFX1BJQykKKyAgICBlbmRpZigpCiAgICAgaWYoTkFU
SVZFX0JVSUxEKQogICAgICAgICBpZihJTlRFTF9DWFgpCiAgICAgICAgICAgICBhZGRfZGVmaW5p
dGlvbnMoLXhob3N0KQpAQCAtMjM4LDIxICsyMzgsMjUgQEAKICAgICAgICAgICAgIGVuZGlmKCkK
ICAgICAgICAgZW5kaWYoKQogICAgIGVuZGlmKCkKKyAgICBzZXQoUElDICIiKQorICAgIGlmKE5P
VCBXSU4zMikKKyAgICAgICAgc2V0KFBJQyAtZlBJQykKKyAgICBlbmRpZigpCiAgICAgaWYoQVJN
IEFORCBDUk9TU19DT01QSUxFX0FSTSkKICAgICAgICAgaWYoQVJNNjQpCi0gICAgICAgICAgICBz
ZXQoQVJNX0FSR1MgLWZQSUMpCisgICAgICAgICAgICBzZXQoQVJNX0FSR1MgJHtQSUN9KQogICAg
ICAgICBlbHNlKCkKLSAgICAgICAgICAgIHNldChBUk1fQVJHUyAtbWFyY2g9YXJtdjYgLW1mbG9h
dC1hYmk9c29mdCAtbWZwdT12ZnAgLW1hcm0gLWZQSUMpCisgICAgICAgICAgICBzZXQoQVJNX0FS
R1MgLW1hcmNoPWFybXY2IC1tZmxvYXQtYWJpPXNvZnQgLW1mcHU9dmZwIC1tYXJtICR7UElDfSkK
ICAgICAgICAgZW5kaWYoKQogICAgICAgICBtZXNzYWdlKFNUQVRVUyAiY3Jvc3MgY29tcGlsZSBh
cm0iKQogICAgIGVsc2VpZihBUk0pCiAgICAgICAgIGlmKEFSTTY0KQotICAgICAgICAgICAgc2V0
KEFSTV9BUkdTIC1mUElDKQorICAgICAgICAgICAgc2V0KEFSTV9BUkdTICR7UElDfSkKICAgICAg
ICAgICAgIGFkZF9kZWZpbml0aW9ucygtREhBVkVfTkVPTikKICAgICAgICAgZWxzZSgpCiAgICAg
ICAgICAgICBmaW5kX3BhY2thZ2UoTmVvbikKICAgICAgICAgICAgIGlmKENQVV9IQVNfTkVPTikK
LSAgICAgICAgICAgICAgICBzZXQoQVJNX0FSR1MgLW1jcHU9bmF0aXZlIC1tZmxvYXQtYWJpPWhh
cmQgLW1mcHU9bmVvbiAtbWFybSAtZlBJQykKKyAgICAgICAgICAgICAgICBzZXQoQVJNX0FSR1Mg
LW1jcHU9bmF0aXZlIC1tZmxvYXQtYWJpPWhhcmQgLW1mcHU9bmVvbiAtbWFybSAke1BJQ30pCiAg
ICAgICAgICAgICAgICAgYWRkX2RlZmluaXRpb25zKC1ESEFWRV9ORU9OKQogICAgICAgICAgICAg
ZWxzZSgpCiAgICAgICAgICAgICAgICAgc2V0KEFSTV9BUkdTIC1tY3B1PW5hdGl2ZSAtbWZsb2F0
LWFiaT1oYXJkIC1tZnB1PXZmcCAtbWFybSkKCi0tLSBzb3VyY2UvY29tbW9uL2NwdS5vbGQJMjAy
MS0xMC0xMCAxOToyMDozOS4xNjMzMTQ0MDAgKzAxMDAKKysrIHNvdXJjZS9jb21tb24vY3B1LmNw
cAkyMDIxLTEwLTEwIDE5OjIwOjM3LjcyMzMxNDQwMCArMDEwMApAQCAtMzksNyArMzksNyBAQAog
I2luY2x1ZGUgPG1hY2hpbmUvY3B1Lmg+CiAjZW5kaWYKIAotI2lmIFgyNjVfQVJDSF9BUk0gJiYg
IWRlZmluZWQoSEFWRV9ORU9OKQorI2lmIFgyNjVfQVJDSF9BUk0gJiYgIWRlZmluZWQoSEFWRV9O
RU9OKSAmJiAhZGVmaW5lZChfX1dJTjMyX18pCiAjaW5jbHVkZSA8c2lnbmFsLmg+CiAjaW5jbHVk
ZSA8c2V0am1wLmg+CiBzdGF0aWMgc2lnam1wX2J1ZiBqbXBidWY7Cg==
XB64_PATCH

# Filelist
# --------
# include/x265.h
# include/x265_config.h
# lib/pkgconfig/x265.pc
# lib/libx265.so
# lib/libx265.a
# share/doc/x265/COPYING
# bin/x265
