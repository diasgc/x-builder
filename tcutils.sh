#!/bin/bash

API=21
if [ "$#" -lt 1 ];then
	echo -e "\e[97m\n\tusage: tcutils arm|arm64|x86|x86_64 [api:21-29]\e[0m\n"
fi

PROC=$1
if [ "$2" != "" ];then
	(($2 >= 21 && $2 <= 29)) && API=$2
fi

usage(){
echo -e "$(
cat << EOM
\n\n\t$lib builder for linux-android ndk toolchain - $vsh
\t\e[90m$dsc Licence $lic
\n\t\e[97musage: $0 \e[96marm|arm64|x86|x86_64 api \e[36m[--update|--clean|--clearall|--opts][--shared][--bin]\e[90m
\n\tTools:$tls\t\e[35mDependencies: $dep\e[0m\n\n
EOM
)"
}

STARTTIME=
ENDTIME=

secs2time(){
    printf '%dm %ds' $(($1/60%60)) $(($1%60))
}

logstart(){
    STARTTIME=$(date +%s)
    echo -ne "\n\e[96m  $@: "
}

logend(){
    ENDTIME=$(date +%s)
    echo -e "\e[96m done \e[90min $(secs2time $(($ENDTIME-$STARTTIME)))\e[0m"
}

log(){
    echo -ne "\e[90m$@\e[0m"
    echo -e "\n\n$@" >> "$LOGFILE"
}

err(){
    ENDTIME=$(date +%s)
    echo -e "\e[91m fail \e[31min $(secs2time $(($ENDTIME-$STARTTIME)))\e[0m\n\n"
    exit 1
}

logme() {
    echo "$(date): $@" >> "$LOGFILE"
    "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
    logok
}

logok() {
    echo -ne "\e[0m ok "
}

# usage logver /path/to/pkgconfigfile.pc
logver() {
    echo -ne "\e[36m version $(pkg-config --modversion $1) \e[0m"
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

# usage: gitClone giturl [libname]
gitClone(){
	log git
	logme git clone $1 $2
}

# usage: getTarLZ url libname
getTarLZ(){
	[ -z $(which lzip) ] && sudo apt -qq install lzip -y >/dev/null 2>&1
	log download
	wget -O- $1 2>/dev/null | tar --lzip -xv >/dev/null 2>&1
	[ "$2" != "" ] && mv $2-* $2
	logok
}

# usage: getTarXZ url libname
getTarXZ(){
	log download
	wget -O- $1 2>/dev/null | tar -xz >/dev/null 2>&1
	[ "$2" != "" ] && mv $2-* $2
	logok
}

# usage: getTarGZ url libname
getTarGZ(){
	log download
	wget -O- $1 2>/dev/null | tar -xz >/dev/null 2>&1
	[ "$2" != "" ] && mv $2-* $2
	logok
}


makeClean(){
  pushd $1 >/dev/null
  make clean
  popd >/dev/null
}

# usage: chkTools tools...
chkAutotools(){
	if [ -z $(which automake) ];then
		tput sc
		sudo apt -qq install automake autogen autoconf m4 libtool -y >/dev/null 2>&1 
		tput rc
	fi
}

chkTools(){
  while [ "$1" != "" ]; do
    toolname=$1
    toolpkg=$1
    case $1 in
      libtool )  	toolname=libtoolize;;
	  autotools )	chkAutotools && exit 0;;
            * )  	;;
    esac
    if [ -z $(which $toolname) ];then		
      echo -ne "\e[36mneed $toolpkg\e[0m "
      sudo apt -qq install $toolpkg -y >/dev/null 2>&1
      echo -ne "\e[96mok\e[0m "
    fi
    shift
  done
}

# usage: chkDeps libs... (must be defined $LIBSDIR $PKGDIR)

chkDeps(){
  while [ "$1" != "" ]; do
    [ ! -d $LIBSDIR/$1/lib/pkgconfig ] && ./$1_arm64.sh
    cp -f $LIBSDIR/$1/lib/pkgconfig/*.pc $PKGDIR
    shift
  done
}

makeClean(){
  pushd $1 >/dev/null
  make clean >/dev/null
  popd >/dev/null
}

cmakeClean(){
  pushd $1 >/dev/null
  rm -rf CMakeFiles CMakeCache.txt
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

show_acopts(){
  if [ -f $(pwd)/$1/configure ];then
    cd $1
    ./configure -h >../$1_opts.txt
    cd ..
  else
    echo -e "no $1 found nor configure file"
  fi
}

export HOST_NPROC=$(nproc)

export CMAKE_EXECUTABLE=${ANDROID_SDK_HOME}/cmake/3.10.2.4988404/bin/cmake
[ -z $(which make) ] && log make && logme sudo apt -qq install make -y
export MAKE_EXECUTABLE=$(which make)
[ -z $(which nasm) ] && log nasm && logme sudo apt -qq install nasm -y
export NASM_EXECUTABLE=$(which nasm)

export API=29
export ANDROID_PLATFORM=$API
export TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
export SYSROOT=${TOOLCHAIN}/sysroot

case $PROC in
  arm64 )   export CPU_FAMILY=aarch64
            export TARGET="aarch64-linux-android"
            export ANDROID_ABI="arm64-v8a"
            export CC=${TOOLCHAIN}/bin/${TARGET}${API}-clang
            export CXX=${CC}++
            ;;
   arm )    export CPU_FAMILY=armv7 
            export TARGET="arm-linux-androideabi"
            export ANDROID_ABI="armv7-a"
            export CC=${TOOLCHAIN}/bin/${TARGET}${API}-clang
            export CXX=${CC}++
            ;;
   x86 )    export CPU_FAMILY=i686
            export TARGET="i686-linux-android"
            export ANDROID_ABI="i686"
            export CC=${TOOLCHAIN}/bin/${TARGET}${API}-clang
            export CXX=${CC}++
            ;;
   x86_64 ) export CPU_FAMILY=x86_64  
            export TARGET="x86_64-linux-android"
            export ANDROID_ABI="x86_64"
            export CC=${TOOLCHAIN}/bin/${TARGET}${API}-clang
            export CXX=${CC}++
            ;;
esac

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

# export HOST_NPROC CMAKE_EXECUTABLE MAKE_EXECUTABLE NASM_EXECUTABLE \
#	API ANDROID_PLATFORM TOOLCHAIN SYSROOT PROC CPU_FAMILY TARGET \
#	ANDROID_ABI CC CXX LD AS ADDR2LINE AR NM OBJCOPY OBJDUMP RANLIB \
#	READELF SIZE STRINGS STRIP YASM LLVM_AS LLVM_ADDR2LINE LLVM_AR \
#	LLVM_NM LLVM_OBJCOPY LLVM_OBJDUMP LLVM_RANLIB LLVM_READELF LLVM_SIZE \
#	LLVM_STRINGS LLVM_STRIP