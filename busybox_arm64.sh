#!/bin/bash

libname=busybox
archname=arm64v8
eta=172

LOGFILE="$(pwd)/${libname}_arm64.log"
[ -f $LOGFILE ] && rm -f $LOGFILE

# enable ndk toolchain for arm64
. tcutils.sh arm64 29

export LIBSDIR=$(pwd)/${archname}
export SRCDIR=$(pwd)/${libname}
export BUILDDIR=$SRCDIR
export INSTALL_DIR=$LIBSDIR/${libname}
export PKGDIR=$INSTALL_DIR/lib/pkgconfig

OPT_SHARED="--disable-shared"
OPT_BIN="--disable-apps"

while [ "$1" != "" ]; do
    case $1 in
        --clean )	makeClean $SRCDIR && exit;;
	--clearall )    rm -rf ${libname} && exit;;
	* )  		echo -e "\n\n\t${libname} builder for aarch64-linux-android - 2020 gcdias 1.0.200608\n\n\t\e[97musage: $0 \e[35m[--clean|--clearall]\e[90m\n\n\tTools:make\n\n\e[0m"
		        exit
    esac
    shift
done

[ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR
mkdir -p $PKGDIR
export PKG_CONFIG_PATH=$PKGDIR

logstart ${libname}

if [ ! -d $SRCDIR ];then
	gitClone https://git.busybox.net/busybox $libname
	cd $libname
	sed -i 's|= $(CROSS_COMPILE)as|= '"$AS"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)gcc|= '"$CC"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)ar|= '"$AR"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)nm|= '"$NM"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)strip|= '"$STRIP"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)objcopy|= '"$OBJCOPY"'|g' Makefile
	sed -i 's|= $(CROSS_COMPILE)objdump|= '"$OBJDUMP"'|g' Makefile
	log defconfig
	logme ${MAKE_EXECUTABLE} android_ndk_defconfig
	#cp configs/android_ndk_defconfig .config
	cd ..
fi

pushd $BUILDDIR >/dev/null

log make
logme ${MAKE_EXECUTABLE} CONFIG_EXTRA_CFLAGS="-target $TARGET -fpic -fPIE --sysroot=$SYSROOT" CONFIG_PREFIX=$INSTALL_DIR -j${HOST_NPROC} 
#CONFIG_EXTRA_LDFLAGS="-Xlinker -z -Xlinker muldefs -nostdlib -Bdynamic -Xlinker -dynamic-linker -Xlinker /system/bin/linker -Xlinker -z -Xlinker nocopyreloc -Xlinker --no-undefined ${SYSROOT}/usr/lib/crtbegin_dynamic.o ${SYSROOT}/usr/lib/crtend_android.o" CONFIG_EXTRA_LDLIBS="dl m c gcc" 

log install
logme ${MAKE_EXECUTABLE} install

popd >/dev/null
logver $PKGDIR/${libname}.pc
logend