#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='cryptopp'
dsc='Free C++ class library of cryptographic schemes'
lic='CRYPTOGAMS'
src='https://github.com/weidai11/cryptopp.git'
cfg='cmake'
eta='60'
cshk='BUILD_SHARED'
cstk='BUILD_STATIC'
#cbk=''
CFG='-DBUILD_TESTING=OFF'

lst_inc='cryptopp/3way.h cryptopp/adler32.h cryptopp/adv_simd.h
    cryptopp/aes.h cryptopp/aes_armv4.h cryptopp/algebra.h
    cryptopp/algparam.h cryptopp/allocate.h cryptopp/arc4.h
    cryptopp/argnames.h cryptopp/aria.h cryptopp/arm_simd.h
    cryptopp/asn.h cryptopp/authenc.h cryptopp/base32.h
    cryptopp/base64.h cryptopp/basecode.h cryptopp/blake2.h
    cryptopp/blowfish.h cryptopp/blumshub.h cryptopp/camellia.h
    cryptopp/cast.h cryptopp/cbcmac.h cryptopp/ccm.h
    cryptopp/chacha.h cryptopp/chachapoly.h cryptopp/cham.h
    cryptopp/channels.h cryptopp/cmac.h cryptopp/config.h
    cryptopp/config_align.h cryptopp/config_asm.h cryptopp/config_cpu.h
    cryptopp/config_cxx.h cryptopp/config_dll.h cryptopp/config_int.h
    cryptopp/config_misc.h cryptopp/config_ns.h cryptopp/config_os.h
    cryptopp/config_ver.h cryptopp/cpu.h cryptopp/crc.h
    cryptopp/cryptlib.h cryptopp/darn.h cryptopp/default.h
    cryptopp/des.h cryptopp/dh.h cryptopp/dh2.h
    cryptopp/dll.h cryptopp/dmac.h cryptopp/donna.h
    cryptopp/donna_32.h cryptopp/donna_64.h cryptopp/donna_sse.h
    cryptopp/drbg.h cryptopp/dsa.h cryptopp/eax.h
    cryptopp/ec2n.h cryptopp/eccrypto.h cryptopp/ecp.h
    cryptopp/ecpoint.h cryptopp/elgamal.h cryptopp/emsa2.h
    cryptopp/eprecomp.h cryptopp/esign.h cryptopp/factory.h
    cryptopp/fhmqv.h cryptopp/files.h cryptopp/filters.h
    cryptopp/fips140.h cryptopp/fltrimpl.h cryptopp/gcm.h
    cryptopp/gf2_32.h cryptopp/gf256.h cryptopp/gf2n.h
    cryptopp/gfpcrypt.h cryptopp/gost.h cryptopp/gzip.h
    cryptopp/hashfwd.h cryptopp/hc128.h cryptopp/hc256.h
    cryptopp/hex.h cryptopp/hight.h cryptopp/hkdf.h
    cryptopp/hmac.h cryptopp/hmqv.h cryptopp/hrtimer.h
    cryptopp/ida.h cryptopp/idea.h cryptopp/integer.h
    cryptopp/iterhash.h cryptopp/kalyna.h cryptopp/keccak.h
    cryptopp/lea.h cryptopp/lsh.h cryptopp/lubyrack.h
    cryptopp/luc.h cryptopp/mars.h cryptopp/md2.h
    cryptopp/md4.h cryptopp/md5.h cryptopp/mdc.h
    cryptopp/mersenne.h cryptopp/misc.h cryptopp/modarith.h
    cryptopp/modes.h cryptopp/modexppc.h cryptopp/mqueue.h
    cryptopp/mqv.h cryptopp/naclite.h cryptopp/nbtheory.h
    cryptopp/nr.h cryptopp/oaep.h cryptopp/oids.h
    cryptopp/osrng.h cryptopp/ossig.h cryptopp/padlkrng.h
    cryptopp/panama.h cryptopp/pch.h cryptopp/pkcspad.h
    cryptopp/poly1305.h cryptopp/polynomi.h cryptopp/ppc_simd.h
    cryptopp/pssr.h cryptopp/pubkey.h cryptopp/pwdbased.h
    cryptopp/queue.h cryptopp/rabbit.h cryptopp/rabin.h
    cryptopp/randpool.h cryptopp/rc2.h cryptopp/rc5.h
    cryptopp/rc6.h cryptopp/rdrand.h cryptopp/resource.h
    cryptopp/rijndael.h cryptopp/ripemd.h cryptopp/rng.h
    cryptopp/rsa.h cryptopp/rw.h cryptopp/safer.h
    cryptopp/salsa.h cryptopp/scrypt.h cryptopp/seal.h
    cryptopp/secblock.h cryptopp/secblockfwd.h cryptopp/seckey.h
    cryptopp/seed.h cryptopp/serpent.h cryptopp/serpentp.h
    cryptopp/sha.h cryptopp/sha1_armv4.h cryptopp/sha256_armv4.h
    cryptopp/sha3.h cryptopp/sha512_armv4.h cryptopp/shacal2.h
    cryptopp/shake.h cryptopp/shark.h cryptopp/simeck.h
    cryptopp/simon.h cryptopp/simple.h cryptopp/siphash.h
    cryptopp/skipjack.h cryptopp/sm3.h cryptopp/sm4.h
    cryptopp/smartptr.h cryptopp/sosemanuk.h cryptopp/speck.h
    cryptopp/square.h cryptopp/stdcpp.h cryptopp/strciphr.h
    cryptopp/tea.h cryptopp/threefish.h cryptopp/tiger.h
    cryptopp/trap.h cryptopp/trunhash.h cryptopp/ttmac.h
    cryptopp/tweetnacl.h cryptopp/twofish.h cryptopp/vmac.h
    cryptopp/wake.h cryptopp/whrlpool.h cryptopp/words.h
    cryptopp/xed25519.h cryptopp/xtr.h cryptopp/xtrcrypt.h
    cryptopp/xts.h cryptopp/zdeflate.h cryptopp/zinflate.h
    cryptopp/zlib.h'
lst_lib='libcryptopp'
lst_bin=''

pc_llib='-lcryptopp'

. xbuilder.sh

source_config(){
    cd $SRCDIR
    local url="https://raw.githubusercontent.com/noloader/cryptopp-cmake/master/"
    for f in CMakeLists.txt cryptopp-config.cmake; do
        wget -O ${f} ${url}${f}
    done
}

start

# Filelist
# --------
# include/cryptopp/blumshub.h
# include/cryptopp/elgamal.h
# include/cryptopp/ecpoint.h
# include/cryptopp/keccak.h
# include/cryptopp/speck.h
# include/cryptopp/sha.h
# include/cryptopp/modes.h
# include/cryptopp/siphash.h
# include/cryptopp/zlib.h
# include/cryptopp/gf256.h
# include/cryptopp/config_os.h
# include/cryptopp/asn.h
# include/cryptopp/3way.h
# include/cryptopp/ppc_simd.h
# include/cryptopp/modarith.h
# include/cryptopp/xtr.h
# include/cryptopp/poly1305.h
# include/cryptopp/smartptr.h
# include/cryptopp/blake2.h
# include/cryptopp/pch.h
# include/cryptopp/tiger.h
# include/cryptopp/rabbit.h
# include/cryptopp/arc4.h
# include/cryptopp/polynomi.h
# include/cryptopp/idea.h
# include/cryptopp/strciphr.h
# include/cryptopp/hmac.h
# include/cryptopp/kalyna.h
# include/cryptopp/sha3.h
# include/cryptopp/hight.h
# include/cryptopp/threefish.h
# include/cryptopp/files.h
# include/cryptopp/mqueue.h
# include/cryptopp/aria.h
# include/cryptopp/serpentp.h
# include/cryptopp/eccrypto.h
# include/cryptopp/scrypt.h
# include/cryptopp/salsa.h
# include/cryptopp/config.h
# include/cryptopp/shacal2.h
# include/cryptopp/pwdbased.h
# include/cryptopp/basecode.h
# include/cryptopp/hmqv.h
# include/cryptopp/config_misc.h
# include/cryptopp/config_ns.h
# include/cryptopp/mqv.h
# include/cryptopp/mars.h
# include/cryptopp/aes_armv4.h
# include/cryptopp/config_cxx.h
# include/cryptopp/algebra.h
# include/cryptopp/rc2.h
# include/cryptopp/allocate.h
# include/cryptopp/ripemd.h
# include/cryptopp/filters.h
# include/cryptopp/arm_simd.h
# include/cryptopp/blowfish.h
# include/cryptopp/emsa2.h
# include/cryptopp/donna_32.h
# include/cryptopp/hc256.h
# include/cryptopp/resource.h
# include/cryptopp/gost.h
# include/cryptopp/naclite.h
# include/cryptopp/darn.h
# include/cryptopp/config_align.h
# include/cryptopp/square.h
# include/cryptopp/mdc.h
# include/cryptopp/zdeflate.h
# include/cryptopp/config_ver.h
# include/cryptopp/integer.h
# include/cryptopp/panama.h
# include/cryptopp/aes.h
# include/cryptopp/sosemanuk.h
# include/cryptopp/md5.h
# include/cryptopp/sha256_armv4.h
# include/cryptopp/simon.h
# include/cryptopp/mersenne.h
# include/cryptopp/ida.h
# include/cryptopp/authenc.h
# include/cryptopp/lea.h
# include/cryptopp/sha512_armv4.h
# include/cryptopp/eax.h
# include/cryptopp/nbtheory.h
# include/cryptopp/rijndael.h
# include/cryptopp/default.h
# include/cryptopp/seed.h
# include/cryptopp/misc.h
# include/cryptopp/cryptlib.h
# include/cryptopp/hrtimer.h
# include/cryptopp/base64.h
# include/cryptopp/rc6.h
# include/cryptopp/factory.h
# include/cryptopp/gf2_32.h
# include/cryptopp/sm4.h
# include/cryptopp/pkcspad.h
# include/cryptopp/rng.h
# include/cryptopp/shake.h
# include/cryptopp/xtrcrypt.h
# include/cryptopp/dll.h
# include/cryptopp/luc.h
# include/cryptopp/oids.h
# include/cryptopp/dsa.h
# include/cryptopp/md2.h
# include/cryptopp/hashfwd.h
# include/cryptopp/lubyrack.h
# include/cryptopp/gf2n.h
# include/cryptopp/hex.h
# include/cryptopp/md4.h
# include/cryptopp/dh.h
# include/cryptopp/fhmqv.h
# include/cryptopp/secblock.h
# include/cryptopp/xed25519.h
# include/cryptopp/donna_64.h
# include/cryptopp/cast.h
# include/cryptopp/padlkrng.h
# include/cryptopp/channels.h
# include/cryptopp/osrng.h
# include/cryptopp/twofish.h
# include/cryptopp/cmac.h
# include/cryptopp/rw.h
# include/cryptopp/dh2.h
# include/cryptopp/whrlpool.h
# include/cryptopp/chachapoly.h
# include/cryptopp/words.h
# include/cryptopp/config_int.h
# include/cryptopp/wake.h
# include/cryptopp/simeck.h
# include/cryptopp/seckey.h
# include/cryptopp/safer.h
# include/cryptopp/seal.h
# include/cryptopp/ccm.h
# include/cryptopp/fips140.h
# include/cryptopp/config_dll.h
# include/cryptopp/gcm.h
# include/cryptopp/gfpcrypt.h
# include/cryptopp/queue.h
# include/cryptopp/trunhash.h
# include/cryptopp/esign.h
# include/cryptopp/sm3.h
# include/cryptopp/gzip.h
# include/cryptopp/ossig.h
# include/cryptopp/dmac.h
# include/cryptopp/stdcpp.h
# include/cryptopp/des.h
# include/cryptopp/adv_simd.h
# include/cryptopp/skipjack.h
# include/cryptopp/nr.h
# include/cryptopp/ecp.h
# include/cryptopp/algparam.h
# include/cryptopp/hkdf.h
# include/cryptopp/modexppc.h
# include/cryptopp/simple.h
# include/cryptopp/donna.h
# include/cryptopp/tea.h
# include/cryptopp/adler32.h
# include/cryptopp/cham.h
# include/cryptopp/iterhash.h
# include/cryptopp/ec2n.h
# include/cryptopp/chacha.h
# include/cryptopp/rabin.h
# include/cryptopp/base32.h
# include/cryptopp/drbg.h
# include/cryptopp/trap.h
# include/cryptopp/config_asm.h
# include/cryptopp/serpent.h
# include/cryptopp/rsa.h
# include/cryptopp/vmac.h
# include/cryptopp/shark.h
# include/cryptopp/cbcmac.h
# include/cryptopp/oaep.h
# include/cryptopp/pssr.h
# include/cryptopp/lsh.h
# include/cryptopp/rc5.h
# include/cryptopp/zinflate.h
# include/cryptopp/pubkey.h
# include/cryptopp/sha1_armv4.h
# include/cryptopp/crc.h
# include/cryptopp/donna_sse.h
# include/cryptopp/xts.h
# include/cryptopp/config_cpu.h
# include/cryptopp/cpu.h
# include/cryptopp/ttmac.h
# include/cryptopp/randpool.h
# include/cryptopp/argnames.h
# include/cryptopp/fltrimpl.h
# include/cryptopp/secblockfwd.h
# include/cryptopp/tweetnacl.h
# include/cryptopp/camellia.h
# include/cryptopp/eprecomp.h
# include/cryptopp/rdrand.h
# include/cryptopp/hc128.h
# lib/libcryptopp.a
# lib/cmake/cryptopp/cryptopp-config.cmake
# lib/cmake/cryptopp/cryptopp-targets.cmake
# lib/cmake/cryptopp/cryptopp-config-version.cmake
# lib/cmake/cryptopp/cryptopp-targets-release.cmake
# lib/libcryptopp.so
