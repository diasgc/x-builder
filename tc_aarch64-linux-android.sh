#!/bin/bash

STARTTIME=
ENDTIME=
logstart(){
    STARTTIME=$(date +%s)
    echo -ne "\n\e[96m  $@: "
}

logend(){
    ENDTIME=$(date +%s)
    echo -e "\e[96m done \e[90m $(($ENDTIME-$STARTTIME))s\e[0m"
}

log(){
    echo -ne "\e[90m$@\e[0m"
    echo -e "\n\n$@" >> "$LOGFILE"
}

err(){
    ENDTIME=$(date +%s)
    echo -e "\e[91m fail \e[31m$(($ENDTIME-$STARTTIME))s elapsed\e[0m\n\n"
    exit 1
}

logthis() {
    echo "$(date): $@" >> "$LOGFILE"
    "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
    echo -ne "\e[0m ok "
}

dl_deb(){
	mkdir $1
	cd $1
	wget $2 > /dev/null || err
	ar x $1*.deb || err
	tar xf data.tar.xz || err
	rm -f * > /dev/null
	cd usr
	mv * ..
	cd ..
	rm -rf usr
	cd ..
}

check_autotools(){
  [ -z $(which pkg-config) ] && log "apt-get: pkg-config" && sudo apt -qq install pkg-config -y >/dev/null 2>&1
  [ -z $(which autoconf) ] && log "apt-get: autoconf" && sudo apt -qq install autoconf -y >/dev/null 2>&1
  [ -z $(which automake) ] && log "apt-get: automake" && sudo apt -qq install automake -y >/dev/null 2>&1
}

checkTools(){
  while [ "$1" != "" ]; do
    toolname=$1
    toolpkg=$1
    case $1 in
      libtool )  toolname=libtoolize;;
            * )  ;;
    esac
    if [ -z $(which $toolname) ];then		
      echo -ne "\e[36mneed $toolpkg\e[0m "
      sudo apt -qq install $toolpkg -y >/dev/null 2>&1
      echo -ne "\e[96mok\e[0m "
    fi
    shift
  done
}

makeClean(){
  pushd $1 >/dev/null
  make clean
  popd >/dev/null
}

show_cmakeopts(){
  if [ -f $(pwd)/$1/CMakeLists.txt ];then
    cd $1
    cmake -LA | awk '{if(f)print} /-- Cache values/{f=1}' >../$1_opts.txt
    cd ..
  else
    echo -e "no $1 found nor CMakeLists.txt file"
  fi
}

show_autoconfopts(){
  if [ -f $(pwd)/$1/configure ];then
    cd $1
    ./configure -h >../$1_opts.txt
    cd ..
  else
    echo -e "no $1 found nor configure file"
  fi
}

# usage: checkDependencies $LIBDIR $PKGDIR libs ... 
checkDependencies(){
  libdir=$1
  shift
  pkgdir=$1
  shift
  while [ "$1" != "" ]; do
    [ ! -d ${libdir}/${1}/lib/pkgconfig ] && ./${1}_arm64.sh
    cp -f ${libdir}/${1}/lib/pkgconfig/*.pc $pkgdir
    shift
  done
}

export HOST_NPROC=$(nproc)

export CMAKE_EXECUTABLE=${ANDROID_SDK_HOME}/cmake/3.10.2.4988404/bin/cmake
[ -z $(which make) ] && log make && logthis sudo apt -qq install make -y
export MAKE_EXECUTABLE=$(which make)
[ -z $(which nasm) ] && log nasm && logthis sudo apt -qq install nasm -y
export NASM_EXECUTABLE=$(which nasm)

export TARGET="aarch64-linux-android"
export ANDROID_ABI="arm64-v8a"
export API=29
export ANDROID_PLATFORM=$API
export TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
export SYSROOT=${TOOLCHAIN}/sysroot
export CPU_FAMILY=aarch64

export CC=${TOOLCHAIN}/bin/${TARGET}${API}-clang
export CXX=${CC}++
export LD=${TOOLCHAIN}/bin/${TARGET}-ld
export AS=${TOOLCHAIN}/bin/${TARGET}-as
export ADDR2LINE=${TOOLCHAIN}/bin/${TARGET}-addr2line
export AR=${TOOLCHAIN}/bin/${TARGET}-ar
export NM=${TOOLCHAIN}/bin/${TARGET}-nm
export OBJCOPY=${TOOLCHAIN}/bin/${TARGET}-objcopy
export OBJDUMP=${TOOLCHAIN}/bin/${TARGET}-objdump
export RANLIB=${TOOLCHAIN}/bin/${TARGET}-ranlib
export READELF=${TOOLCHAIN}/bin/${TARGET}-readelf
export SIZE=${TOOLCHAIN}/bin/${TARGET}-size
export STRINGS=${TOOLCHAIN}/bin/${TARGET}-strings
export STRIP=${TOOLCHAIN}/bin/${TARGET}-strip
export YASM=${TOOLCHAIN}/bin/yasm

export LLVM_AS=${TOOLCHAIN}/bin/llvm-as
export LLVM_ADDR2LINE=${TOOLCHAIN}/bin/llvm-addr2line
export LLVM_AR=${TOOLCHAIN}/bin/llvm-ar
export LLVM_NM=${TOOLCHAIN}/bin/llvm-nm
export LLVM_OBJCOPY=${TOOLCHAIN}/bin/llvm-objcopy
export LLVM_OBJDUMP=${TOOLCHAIN}/bin/llvm-objdump
export LLVM_RANLIB=${TOOLCHAIN}/bin/llvm-ranlib
export LLVM_READELF=${TOOLCHAIN}/bin/llvm-readelf
export LLVM_SIZE=${TOOLCHAIN}/bin/llvm-size
export LLVM_STRINGS=${TOOLCHAIN}/bin/llvm-strings
export LLVM_STRIP=${TOOLCHAIN}/bin/llvm-strip