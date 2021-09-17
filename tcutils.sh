#!/bin/bash
# ................................................
# builder util 1.0 2020-diasgc
# ................................................

# def colors
C0="\e[0m" CW="\e[97m" CD="\e[90m"
CR0="\e[31m" CR1="\e[91m"
CG0="\e[32m" CG1="\e[92m"
CY0="\e[33m" CY1="\e[93m"
CB0="\e[34m" CB1="\e[94m"
CM0="\e[35m" CM1="\e[95m"
CC0="\e[36m" CC1="\e[96m"

# theme colors
CT0=$CM0; CT1=$CM1; CS0=$CR0; CS1=$CR1

debug=
vsh='0.2.5'
cmake_build_type=Release

aptInstallBr(){
  while [ "$1" != "" ];do
    echo -ne "  ${CT0}install $1${C0} "
    sudo apt -qq install $1 -y >/dev/null 2>&1
    echo -e "${C0}ok ${CT1}done${C0} $(apt-cache show $1 | grep Version)"
    shift
  done
}

init(){
  
  case "$(uname -s)" in
    Linux)  BUILD_TRIP=$(echo $(uname -m)-linux-gnu)
      [ -n "$(grep -q BCM2708 /proc/cpuinfo)" ] && BUILD_TRIP="${BUILD_TRIP}eabihf"    
      if [ -n "$(which getprop)" ];then
        BUILD_TRIP=$(echo $(uname -m)-linux-android)
        export API=$(getprop ro.build.version.sdk)
      fi
      ;;
    Darwin) BUILD_TRIP=$(echo $(uname -m)-darwin-gnu);;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) BUILD_TRIP=$(echo $(uname -m)-w64-mingw32);;
  esac

  # check make
  test -z $(which make) && aptInstallBr make
  export MAKE_EXECUTABLE=$(which make)
  
  # check cmake
  test -z $(which cmake) && aptInstallBr build-essential cmake
  export CMAKE_EXECUTABLE=$(which cmake)
  
  # check ccmake
  test -z $(which ccmake) && aptInstallBr cmake-curses-gui
  
  # check nasm
  test -z $(which nasm) && aptInstallBr nasm
  export NASM_EXECUTABLE=$(which nasm)
  
  # check pkg-config
  test -z $(which pkg-config) && aptInstallBr pkg-config
  export PKG_CONFIG=$(which pkg-config)

  test -z $(which autoconf) && aptInstallBr automake autoconf autogen autopoint libtool-bin m4
  export BUILD_TRIP HOST_NPROC=$(nproc) INIT=1 ROOTDIR=$(pwd)
  #`dirname "$0"`
}

test -z "$INIT" && init

main(){
  [ $debug ] && set -x
  # exit if missing vars lib arch or src
  test -z $LIBSDIR || test -z $lib || test -z $src && errCall

  
  STARTTIME=0
  ENDTIME=0
  update=

  PKGDIST=$ROOTDIR/packages/$arch
  INSTALL_DIR=$LIBSDIR

  SOURCES=$ROOTDIR/sources
  SRCDIR=$SOURCES/$lib
  PKGDIR=$INSTALL_DIR/lib/pkgconfig
  
  export PKGDIST LIBSDIR SOURCES SRCDIR INSTALL_DIR PKGDIR
  [ -d $SOURCES ] || mkdir -p $SOURCES

  # show package info
  [ ! -f $PKGDIR/$pkg.pc ] && [ $banner = 1 ] && pkgInfo

  LOGFILE=$LIBSDIR/${lib}.log
}

# Variables
# mkinstall: rule for install 'make $mkinstall' (default: install)
# mkclean  : rule for clean 'make $mkclean' (default: clean)
start(){

  [ $debug ] && echo -ne "${CY0}start() arch=$arch cfg=$CFG "
  
  # if pkgconfig.pc file exists and not for update, it's done
  [ -z "$update" ] && [ -f $PKGDIR/$pkg.pc ] && exit
  
  # Reset LOGFILE
  [ -f $LOGFILE ] && rm -f $LOGFILE

  # Reset INSTALL_DIR
  # [ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR

  # Create INSTALL_DIR and PKGCONFIG DIR
  mkdir -p $PKGDIR
  export PKG_CONFIG_PATH=$PKGDIR

  # Check Tools and Dependencies
  chkTools $tls
  chkDeps $dep

  logstart $arch ${eta}s
  local bss=
  [[ $CSH = *"$cs0"* ]] && bss="${bss}[static]"
  [[ $CSH = *"$cs1"* ]] && bss="${bss}[shared]"
  echo -ne "\t${C0}${bss} "
  cd $SOURCES

  test -n "$update" && rm -rf $SRCDIR
  [ -z "$retry" ] && [[ $dbld != $SRCDIR ]] && rm -rf $dbld

  if [ ! -d $SRCDIR ];then
    
    # is defined custom buildSrc
    if [ "$(type -t buildSrc)" = 'function' ]; then
      buildSrc
    else
      case $sty in
        git) gitClone $src $lib;;
        tgz) getTarGZ $src $lib;;
        txz) getTarXZ $src $lib;;
        tlz) getTarLZ $src $lib;;
        svn) svnClone $src $lib;;
        *)   err;;
      esac
    fi

    case $cfg in
      ag) doAutogen $SRCDIR;;
      ar) doAutoreconf $SRCDIR;;
    esac

    # check whether to patch source
    [ "$(type -t patchSrc)" = 'function' ] && patchSrc
  fi

  [ ! -d $dbld ] && mkdir -p $dbld
  pushd $dbld >/dev/null


  # check whether to build manually or auto/cmake
  [ "$(type -t beforeBuild)" = 'function' ] && beforeBuild
  
  echo -e "Variables: \nCFLAGS=$CFLAGS\nCXXFLAGS=$CXXFLAGS\nCPPFLAGS=$CPPFLAGS\nLDFLAGS=$LDFLAGS\nLIBS=$LIBS\n\nPKG_CONFIG_PATH=$PKG_CONFIG_PATH\n\n \
  CC=$CC\nCXX=$CXX\nLD=$LD\nAS=$AS\nAR=$AR\nNM=$NM\nRANLIB=$RANLIB\nSTRIP=$STRIP\n\n\n" >>$LOGFILE 2>&1
  
  if [ "$(type -t buildLib)" = 'function' ]; then
    buildLib
  else
    [ $mkclean ] || mkclean="clean"
    doLogNoErr 'clean' ${MAKE_EXECUTABLE} $mkclean
    
    case $cfg in
      cm|cmake)
        doLog 'cmake' ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=$cmake_build_type $CFG $CSH $CBN
        ;;
      ccm|ccmake)
        doLog 'cmake' ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=$cmake_build_type $CFG $CSH $CBN
        inlineCcmake $SRCDIR
        ;;
      ac|am|ag|ar)
        doLog 'configure' $dbld/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
        ;;
      meson)
        #check meson package
        local MESON_EXEC=$(which meson)
        [ -z "${MESON_EXEC}" ] && aptInstallBr meson
        MESON_EXEC=$(which meson)
        CPPFLAGS="$CPPFLAGS -I$SYSROOT/usr/include"
        CFLAGS="$CFLAGS -I$SYSROOT/usr/include"
        CXXFLAGS="$CXXFLAGS -I$SYSROOT/usr/include"
        LDFLAGS="$LDFLAGS -L$SYSROOT/usr/lib/${arch} -L$SYSROOT/usr/lib/${arch}/${API}"
        #create config file
        local MESON_CFG="$SRCDIR/${arch}.meson"
        [ -f "$MESON_CFG" ] && rm $MESON_CFG
        mesonCreateAndroidSetup $MESON_CFG
        
        #log config file
        echo "\nMeson file:(${MESON_CFG})\n\n" >>${LOGFILE} 2>&1
        cat ${MESON_CFG} >>${LOGFILE} 2>&1

        #meson config
        doLog 'meson' ${MESON_EXEC} setup --cross-file ${MESON_CFG} ${dbld} ${SRCDIR}
        ;;
      mk)
        MKF=$CFG
        ;;
      *)
        doErr "No cfg found or unknown for $cfg"
        ;;
    esac

    # check whether to create patch Makefile
    if [ "$(type -t patchMakefile)" = 'function' ]; then
      doLog 'patch' patchMakefile
    fi

    doLog 'make' ${MAKE_EXECUTABLE} $MKF -j${HOST_NPROC}

    # default rule for install    
    [ $mkinstall ] || mkinstall="install"
    doLog 'install' ${MAKE_EXECUTABLE} $mkinstall    

  fi
  
  # check whether to create pkg-config .pc file
  if [ "$(type -t buildPC)" = 'function' ]; then
    doLog 'pkgcfg' buildPC
  fi

  popd >/dev/null
  if [ -n "${pkg}" ];then
    logver "$PKGDIR/$pkg.pc"
    export PKG_CONFIG_PATH=$PKGDIR/$pkg.pc:$PKG_CONFIG_PATH
  fi
  logend

  # check if parent process is shell script
  local parent=$(ps -o comm= $PPID)
  [ "${parent: -3}" == ".sh" ] || echo -e "\n\n  ${CG1}::Done${C0}\n\n"
  
  [ $debug ] && set +x
  exit 0
}



chkTools(){
  while [ -n "$1" ]; do
  toolname=$1
  toolpkg=$1
  case $1 in
    rust ) installRust && continue;;
    libtool ) toolname=libtoolize;;
    texinfo ) toolname=makeinfo;;
    autotools )  chkAutotools && continue;;
    * ) ;;
  esac
  [ -z $(which $toolname) ] && aptInstall $toolpkg
  shift
  done
}

# usage: chkDeps libs... (must be defined $LIBSDIR $PKGDIR)
# todo: some libs (nettle) have pkgconfig inside lib64 not lib
chkDeps(){
  local pkgfile
  while [ -n "$1" ]; do
    pkgfile=$(./$1.sh $arch --checkPkg)
    libname=$(./$1.sh --libName)
    [ -n "$pkgfile" ] || ./$1.sh $arch || err
    PKG_CONFIG_PATH="${pkgfile}:$PKG_CONFIG_PATH"
    shift
  done
  #for i in $PKGDIR/*.pc; do
  #  PKG_CONFIG_PATH="${i}:$PKG_CONFIG_PATH"
  #done
  export PKG_CONFIG_PATH
}

# usage: chkTools tools...
chkAutotools(){
  if [ -z $(which automake) ];then
    tput sc
    sudo apt -qq install automake autogen autoconf m4 libtool-bin -y >/dev/null 2>&1 
    tput rc
  fi
}

# make args...
doMake(){
  make $@ 2>&1 | tee -a $LOGFILE | grep -Eo "\[.+%\]" 
}

errCall(){
  echo -e "$(
    cat <<-EOM
			\n$CWtcutils $vrs
			${C0}Cannot be called directly. Missing vars lib arch or src
			\n
			EOM
)"
exit 1  
}

secs2time(){
  printf '%dm %ds' $(($1/60%60)) $(($1%60))
}

logstart(){
  STARTTIME=$(date +%s)
  #echo -ne "$CC1  $@: "
  echo -ne "${CD}  $(date '+%H:%M')"
  [ $eta ] && echo -ne "-$(date '+%H:%M' --date="$eta seconds")"
  echo -ne " ${CT1}$lib ${CT0}$arch:${CD} "
}

logend(){
  ENDTIME=$(date +%s)
  local pkgsize=$(du -sk ${INSTALL_DIR} | cut -f1)
  local libsize=$(du -sk ${INSTALL_DIR}/lib | cut -f1)
  local secs=$(($ENDTIME-$STARTTIME))
  local msg="${CT1} done ${CD}elapsed: $(secs2time ${secs})"
  [[ $secs -gt 60 ]] && msg="$msg (${secs}s)"
  echo -e "$msg pkg/lib: ${pkgsize}/${libsize}kb${C0}"
}

log(){
  echo -ne "$CD$@$C0"
  echo -e "\n\n$@\n----------------------------------------\n" >> "$LOGFILE"
}

doErr(){
  echo -e "${CR1}  Error: ${CR0}${1}${C0}\n\n"
  exit 1
}

err(){
  ENDTIME=$(date +%s)
  echo -e "${CR1} fail ${CR0}[$(secs2time $(($ENDTIME-$STARTTIME)))]${C0}\n\n"
  if [ -f $LOGFILE ];then
    if [ -f $dbld/CMakeFiles/CMakeError.log ];then
      echo -e "\n\n\n$dbld/CMakeFiles/CMakeError.log:\n" >> $LOGFILE
      cat $dbld/CMakeFiles/CMakeError.log >> $LOGFILE
    fi
    read -p '  Open log? [Y|n]' openlog
    [ "$openlog" != "n" ] && nano $LOGFILE
  fi
  exit 1
}

logme() {
  echo "$(date): $@" >> "$LOGFILE"
  "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
  echo -e "----------------------------------------\n" >> "$LOGFILE"
  logok
}

doLogNoErr(){
  local var=$1
  shift
  echo -ne "${CD}${var}${C0}"
  "$@" >/dev/null 2>&1
  logok $var
}

doLog() {
  local var=$1
  shift
  echo -ne "${CD}${var}${C0}"
  echo -e "\n\n$@\n----------------------------------------\n" >> "$LOGFILE"
  echo "$(date): $@" >> "$LOGFILE"
  "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
  echo -e "----------------------------------------\n" >> "$LOGFILE"
  #echo -ne "\e[${#var}D${CT1}${var}${C0} "
  logok $var
}

logok() {
  echo -ne "\e[${#1}D${CT0}${1}${C0} "
  #echo -ne "${C0} ok "
}

# usage logver /path/to/pkgconfigfile.pc
logver() {
  if [ -f $1 ];then
    echo -ne "${CT1}version $(pkg-config --modversion $1)${C0}"
  else
    echo -ne "${CS0} pkg-version not found ${C0}"
  fi
}

inlineCcmake(){
  #local inL="\e[u"
  #[[ $(isBottomRow) -eq 1 ]] && inL="$inL\e[2A"
  #echo -ne "\e[s" && ccmake $@ && echo -ne "${inL}"
  tput sc && ccmake $@ && tput rc
}

isBottomRow(){
  test "$(echo "lines"|tput -S)" == "$(IFS=';' read -sdR -p $'\e[6n' ROW COL && echo "${ROW#*[}")" && echo 1 || echo 0
}

# usage: gitClone giturl [libname]
gitClone(){
  [ $(which git) ] || aptInstall git || err
  doLog 'git' git clone $1 $2
}

svnClone(){
  [ $(which svn) ] || aptInstall subversion || err
  log svn
  logme svn checkout $1 $2
}

setGitVrs(){
  pushd $SRCDIR >/dev/null
  export vrs=$(git describe --tags)
  popd >/dev/null
}

getGitLastTag(){
  if [ "$sty"=="git" ];then
    #v=$(git -c 'versionsort.suffix=-' \
    #ls-remote --exit-code --refs --sort='version:refname' --tags ${src} '*.*.*' \
    #| tail --lines=1 \
    #| cut --delimiter='/' --fields=3)
    #echo $v
    echo $(git -c 'versionsort.suffix=-' ls-remote --refs --tags --sort='v:refname' $src | tail -n1 | cut -d'/' -f3)
  else
    echo "n/a"
  fi
}

githubLatestTarGz(){
  case $src in
    *github.*)
      local dst=$(echo $src | sed -e 's|\.git||g')
      local url=$(curl -ILs -o /dev/null -w %{url_effective} "${dst}/releases/latest")
      local file=$(curl -s $url | grep -Po '(?<=>)[^<]*' | grep -Po '.*tar.gz$')
      echo "${url}/${file}"
      ;;
    *gitlab.*|*code.videolan.org*)
      local dst=$(echo $src | sed -e 's|\.git||g')
      local v=$(getGitLastTag $src)
      echo "$dst/-/archive/${v}/${lib}-${v}.tar.gz"
      ;;
    *.googlesource.*)
      local tag=$(git -c 'versionsort.suffix=-' ls-remote --refs --sort='v:refname' $src | tail -n1 | cut -f1)
      echo "$src/+archive/${tag}.tar.gz"
      ;;
    esac
}

# usage: getTarLZ url libname
getTarLZ(){
  test -z $(which lzip) && aptInstall lzip
  log download
  wget -O- $1 2>>$LOGFILE | tar --lzip -xv >>$LOGFILE 2>&1 || err
  test -n $2 && mv $2* $2
  logok
}

# usage: getTarXZ url libname
getTarXZ(){
  log download
  wget -O- $1 2>>$LOGFILE | tar -xvJ >>$LOGFILE 2>&1 || err
  test -n $2 && mv $2* $2
  logok
}

# usage: getTarGZ url libname
getTarGZ(){
  log download
  wget -O- $1 2>>$LOGFILE | tar -xz >>$LOGFILE 2>&1 || err
  test -n $2 && mv $2* $2
  logok
}

getZip(){
  [ -z $(which unzip) ] && aptInstall unzip
  log download
  wget $1 -O tmp.zip || err
  log extract unzip tmp.zip
  rm tmp.zip
  logok
}

prtPrc(){
  local v=$(grep "%")
}


makeClean(){
  pushd $1 >/dev/null
  make clean
  popd >/dev/null
}

clean(){
  echo -ne "${CT0}\n\tcleaning...\n"
  rm -rf builds/$arch/$lib builds/$arch/$lib.log
  pushd sources/$lib >/dev/null
  [ -f Makefile ] && make clean
  popd >/dev/null
  echo -e "$C0\tdone"
  clear
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

showOpts(){
  if [ -d "$1" ] && [ -n "$lib" ];then
    bdir=$(pwd)/builds
    pushd $1>/dev/null
    [ -f CMakeLists.txt ] && cmake -LA | awk '{if(f)print} /-- Cache values/{f=1}' >${bdir}/${lib}_cmake.opts && nano "${bdir}/${lib}_cmake.opts"
    [ -f configure ] && ./configure --help >${bdir}/${lib}_aconf.opts && nano "${bdir}/${lib}_aconf.opts"
    popd >/dev/null
  else
    echo -e "  ${CR0}no configuration file found in ${CR1}$1${CD}\n\n"
  fi
}

setCMake(){
  printf "SET($2 $3)\n\n" >> $1
}

doAutogen(){
  [ $1 ] || doErr "missing arg in doAutogen: usage doAutogen <AUTOGEN_DIR>"
  var="autogen"
  echo -ne "${CD}${var}${C0}"
  pushd $1 >/dev/null && shift
  case $1 in
    --noerr ) ./autogen.sh >>$LOGFILE 2>&1;;
    --noconfigure ) NOCONFIGURE=1 logme ./autogen.sh;;
    * ) logme ./autogen.sh;;
  esac
  popd >/dev/null
  logok $var
}

doAutoreconf(){
  var="autoreconf"
  echo -ne "${CD}${var}${C0}"
  pushd $1 >/dev/null
  logme autoreconf -fi
  popd >/dev/null
  logok $var
}

checkUrl(){
  wget -S --spider $1 2>&1 | grep -q "HTTP/1.[0-9] 200 OK" && echo SUCCESS || echo FAIL
}

checkCmd(){
  [ -z "$(which $1)"] sudo apt -qq install $1 -y >/dev/null 2>&1
}

downloadP(){
  tput sc && echo -ne "\e[$(tput lines);0H${CY1}"
  # wget --progress=dot $url 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\b\b\b\b%4s", $2)}'
  wget --progress=dot $1 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\r%4s %s eta:%s  ",$2,$1,$4)}'
  tput rc
  echo "${C0} ok "
}

download(){
  # bsdtar from stdin doesn't extract file +x permission
  # wget -qO- $1 | bsdtar -xvf- >/dev/null 2>&1
  echo -ne " ${CD}checking tools"
  test -z $(which unzip) && aptInstallBr unzip
  echo -ne " ${CS0}downloading..."
  tput sc && echo -ne "\e[$(tput lines);0H${CY1}"
  wget --progress=dot $1 -O tmp.zip 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\r%4s %s eta:%s  ",$2,$1,$4)}'
  tput rc
  echo -ne "${CS0} decompressing... ${C0}"
  unzip tmp.zip >/dev/null 2>&1 && rm tmp.zip || err
}

ndkPatchLpthread(){
  # NDK Patch: create missing libpthread in NDK
	lpthread="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$arch/libpthread.a"
	[ ! -f $lpthread ] && $AR cr $lpthread
}

ndkPatchLrt(){
  # NDK Patch: create missing librt in NDK
  lrt="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${arch}/librt.a"
  [ ! -f $lrt ] && $AR cr $lrt
}


aptInstall(){
  while [ "$1" != "" ];do
    echo -ne "  ${CT0}install $1${C0}"
    echo -n " "
    stty size | {
      read y x
      echo -ne "${CY1}"
      tput sc
      tput cup "$((y - 1))" 0
      sudo apt -qq install $1 -y >/dev/null 2>&1
      echo -ne "${C0}"
      tput rc
    }
    echo -ne "${C0} ok"
    shift
  done
}

loadToolchain(){

  local posix=""

  while [ -n "$1" ];do
    case $1 in
      --posix ) posix="-posix";;
      --ndkLpthread) ndkPatchLpthread;;
      --ndkLrt) ndkPatchLrt;;
    esac
    shift
  done

  CMAKE_EXECUTABLE=cmake
  YASM=yasm
  PKG_CONFIG=pkg-config

  CPPFLAGS="-I$LIBSDIR/include"
  LDFLAGS="-L$LIBSDIR/lib"

  case $arch in
  
    # Android
    *-linux-android|*-linux-androideabi )
      PLATFORM=Android
      #use ndk cmake
      [[ $ndkcmake = 1 ]] && [ -d ${ANDROID_HOME}/cmake ] && CMAKE_EXECUTABLE=${ANDROID_HOME}/cmake/3.10.2.4988404/bin/cmake
      CMAKE_TOOLCHAIN=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake
      TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
      SYSROOT=${TOOLCHAIN}/sysroot
      CROSS_PREFIX=${TOOLCHAIN}/bin/$arch-
      [ -z "$API" ] && API=24
      LT_SYS_LIBRARY_PATH="$SYSROOT/usr/lib/$arch:$SYSROOT/usr/lib/$arch/$API"
      [[ $CSH = *$cs1* ]] && LDFLAGS="-Wl,-rpath,$LT_SYS_LIBRARY_PATH $LDFLAGS"
      YASM=${TOOLCHAIN}/bin/yasm
      CC=${TOOLCHAIN}/bin/${arch}${API}-clang
      CXX=${CC}++
      # see https://developer.android.com/ndk/guides/other_build_systems
      AS=${CC}
      LD=${TOOLCHAIN}/bin/ld.lld #llvm-lin
      #NDK r23 doesn't have <arch>-linux-android-ar,nm,etc..., use llvm-xx instead
      [ ! -f "${CROSS_PREFIX}ar" ] && CROSS_PREFIX="${TOOLCHAIN}/bin/llvm-"
      #LD=${CROSS_PREFIX}ld
      ;;&
    aarch64-linux-android ) ABI="arm64-v8a";;
    arm-linux-androideabi ) ABI="armv7-a" 
      CC=${TOOLCHAIN}/bin/armv7a-linux-androideabi${API}-clang
      CXX=${CC}++
      AS=${CC} #${TOOLCHAIN}/bin/arm-linux-androideabi-as
      ;;
    i686-linux-android ) ABI="i686";;
    x86_64-linux-android ) ABI="x86_64";;
    
    # Linux
    i686-linux-gnu|x86_64-linux-gnu ) PLATFORM=Linux
      TOOLCHAIN="/usr"
      SYSROOT=
      CROSS_PREFIX=
      LT_SYS_LIBRARY_PATH="/usr/lib/gcc/$arch/9"
      CC=gcc CXX=g++
      AS=as
      LD=ld
      ;;
    a*-linux-gnu* ) PLATFORM=Linux
      TOOLCHAIN="/usr/$arch/bin"
      SYSROOT="/usr/$arch"
      CROSS_PREFIX="${arch}-"
      LT_SYS_LIBRARY_PATH="/usr/lib/gcc/$arch/9"
      CC="$arch-gcc"
      CXX="$arch-g++"
      AS=${CROSS_PREFIX}as
      LD=${CROSS_PREFIX}ld
      ;;
    # Windows
    *-w64-mingw32 ) PLATFORM=Windows
      LT_SYS_LIBRARY_PATH="/usr/lib/gcc/$arch/9.3-win32"
      CMAKE_ROOTPATH_OPTS="-DCMAKE_FIND_ROOT_PATH=\"/usr/$arch;/usr/lib/gcc/$arch/9.3-posix;$LT_SYS_LIBRARY_PATH\" \
        -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
        -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY"
      TOOLCHAIN="/usr/${arch}/bin"
      SYSROOT="/usr/${arch}"
      CROSS_PREFIX="${arch}-"
      CC=${CROSS_PREFIX}gcc${posix}
      CXX=${CROSS_PREFIX}g++${posix}
      AS=${CROSS_PREFIX}as
      LD=${CROSS_PREFIX}ld
      ;;

  esac

  AR=${CROSS_PREFIX}ar
  NM=${CROSS_PREFIX}nm

  ADDR2LINE=${CROSS_PREFIX}addr2line
  OBJCOPY=${CROSS_PREFIX}objcopy
  OBJDUMP=${CROSS_PREFIX}objdump
  RANLIB=${CROSS_PREFIX}ranlib
  READELF=${CROSS_PREFIX}readelf
  SIZE=${CROSS_PREFIX}size
  STRINGS=${CROSS_PREFIX}strings
  STRIP=${CROSS_PREFIX}strip
  WINDRES=${CROSS_PREFIX}windres

  # export
  export CMAKE_EXECUTABLE YASM PKG_CONFIG API \
    PLATFORM TOOLCHAIN SYSROOT CC CXX LD AS \
    ADDR2LINE AR NM OBJCOPY OBJDUMP RANLIB \
    READELF SIZE STRINGS STRIP WINDRES \
    CROSS_PREFIX LT_SYS_LIBRARY_PATH CPPFLAGS LDFLAGS
}

#usage: mesonCreateAndroidSetup <out.meson.file>
mesonCreateAndroidSetup(){

    case $arch in
      aarch*)  cpu1="aarch64" cpu2="aarch64";;
      arm*)    cpu1="arm"     cpu2="arm";;
      i686*)   cpu1="x86"     cpu2="i686";;
      x86_64*) cpu1="x86_64"  cpu2="x86_64";;
    esac

  	cat <<-EOF >>${1}
    [binaries]
    c = '${CC}'
    c_ld = '${LD}'
    cpp = '${CXX}'
    cpp_ld = '${LD}'
    ar = '${AR}'
    as = '${AS}'
    pkgconfig = 'pkg-config'
    addr2line = '${ADDR2LINE}'
    objcopy = '${OBJCOPY}'
    objdump = '${OBJDUMP}'
    ranlib = '${RANLIB}'
    readelf = '${READELF}'
    size = '${SIZE}'
    strings = '${STRINGS}'
    strip = '${STRIP}'
    windres = '${WINDRES}'

    [properties]
    needs_exe_wrapper = true
    cmake_toolchain_file = '${ROOTDIR}/cmake/${arch}.cmake'

    [host_machine]
    system = 'android'
    cpu_family = '${cpu1}'
    endian = 'little'
    cpu = '${cpu2}'
		EOF
}

getMinGwVersion(){
  echo $(x86_64-w64-mingw32-gcc --version | head -n1 | grep -Eo "(GCC).+-win32" | sed 's|GCC) \(.*\)-win32|\1|')
}

errUnknownTarget(){
  if [ $arch ];then
    echo -e "\n  ${CR1}unknown target ${arch}${C0}\n" && exit 1
  else
    echo -e "\n  ${CR1}must specify a target${C0}\n" && usage && exit 1
  fi
}

clearAll(){
  if [ -z "$lib" ];then
    read -p 'Clear all data? (Builds, Sources and Logs) [Y|n] ' ca
    case $ca in Y|y) rm -rf builds sources && clear;;esac
  else
    rm -rf sources/$lib
    [ -n "$arch" ] && rm -rf builds/$arch/$lib builds/$arch/$lib.log
  fi
}

checkPkg(){
  local pf="$LIBSDIR/lib/pkgconfig/${pkg}.pc"
  [ -f "$pf" ] && echo $pf || echo
  #[ $LIBSDIR ] && [ $pkg ] && \
  #  [ -f "$LIBSDIR/lib/pkgconfig/${pkg}.pc" ] && \
  #  [ -d "$LIBSDIR}/include" ] && \
  #  echo "$LIBSDIR/lib/pkgconfig/${pkg}.pc" || echo ""
}

pkgInfo(){
  local DP=
  local VRS=
  [ -n "$tls" ] && DP="${CT0}tools: ${C0}$tls "
  [ -n "$dep" ] && DP="${DP}${CT0}dependencies: ${C0}$dep"
  if [ "$sty" == "git" ];then
    local vgit=$(getGitLastTag $src)
    if [ -d $SRCDIR ];then
      setGitVrs
      VRS="${CT0}vrs: ${C0}$vrs "
      if [[ $vgit = *$vrs* ]];then
        VRS="$VRS updated"
      else
        VRS="$VRS ${CT0}latest: ${CT1}${vgit}${C0}"
      fi
    else
      VRS="${CT0}vrs: ${C0}${vgit}"
    fi
  fi
  echo -e "$(
  cat <<-EOF
		\n${CW}  ${lib^^} - ${C0}${dsc}
		${CT0}  Licence ${C0}$lic ${DP} ${VRS}
		EOF
  )"
}

usage(){
  echo -e "$(
  cat <<-EOF
    \n
    ${CW}usage: $0 ${CC1}<target> ${CB1}<build-options> ${CM1}<builder-options> ${CM0}<other-options>${C0}\n
    ${CC1}<target>
    ${CC1}<android> ${C0}\taarch64-linux-android | arm-linux-androideabi | i686-linux-android | x86_64-linux-android
    ${CC1}<linux>   ${C0}\taarch64-linux-gnu     | arm-linux-gnueabihf   | i686-linux-gnu     | x86_64-linux-gnu
    ${CC1}<windows> ${C0}\ti686-w64-mingw32      | x86_64-w64-ming32\n
    ${CB1}<build-options>
    ${CB1}--shared  ${C0}\tbuild shared/dynamic libs
    ${CB1}--static  ${C0}\tbuild static libs
    ${CB1}--bin     ${C0}\tbuild executables
    ${CB1}--nobin   ${C0}\tdon't build executables
    ${CB1}--prefix d${C0}\tset build directory <d>
    ${CB1}--api n   ${C0}\tset api level <n>\n
    ${CM1}<builder-options>
    ${CM1}--cmake   ${C0}\tforce cmake build when available
    ${CM1}--ndkcmake${C0}\tuse android ndk cmake 3.10.2 instead
    ${CM1}--ccmake  ${C0}\tforce cmake + gui ccmake when available
    ${CM1}--vrep    ${C0}\tget repository version
    ${CM1}--checkPkg${C0}\tget pkgconfig file's path\n
    ${CM0}<other-options>
    ${CM0}--rebuild ${C0}\tforce source update/download (git/svn/etc)
    ${CM0}--retry   ${C0}\tretry build without clear cache
    ${CM0}--clean   ${C0}\tclean up last build
    ${CM0}--clearall${C0}\tclean builds dir, sources dir and all logs
    ${CM0}--opts    ${C0}\tshow available configuration options/flags
    ${CM0}--nobanner${C0}\tdon't show banner/packageinfo\n\n
EOF
)" 
}

showBanner(){
  if [ $banner = 1 ]; then
    echo -ne "\n\n  ${CW}X-Builder ${vsh} for Linux${C0}\n  "
    [ -n $(which lsb_release) ] && echo -ne "$(lsb_release -sd) "
    if [ -n "$(uname -r | grep 'microsoft')" ];then
      echo -ne "WSL2 "
    elif [ -n "$(uname -r | grep 'Microsoft')" ];then
      echo -ne "WSL "
    fi
    echo -e "$(uname -o) $(uname -m) ${CD} $(uname -r)"
  fi
}

# main
debug=
banner=1
update=
retry=
bshared=
bbin=
advcfg=
ndkcmake=
nodev=

# default arch is x86_64-linux
arch=x86_64-linux-gnu

while [ $1 ];do
  case $1 in
    aarch64-linux-android|aarch64-android|arm64-android|android )
      arch=aarch64-linux-android
      LIBSDIR=$(pwd)/builds/android/arm64-v8a
      ;;
    arm-linux-androideabi|arm-android|armv7-android )
      arch=arm-linux-androideabi
      LIBSDIR=$(pwd)/builds/android/armeabi-v7a
      ;;
    x86_64-linux-android|x64-android|x86_64-android )
      arch=x86_64-linux-android
      LIBSDIR=$(pwd)/builds/android/x86_64
      ;;
    x86-*android|i686-*android )
      arch=i686-linux-android
      LIBSDIR=$(pwd)/builds/android/x86
      ;;
    x86_64-linux-gnu|x64-linux|linux|linux64 )
      arch=x86_64-linux-gnu
      LIBSDIR=$(pwd)/builds/linux/x86_64
      ;;
    i686-linux-gnu|x86-linux|i686-linux|linux32 )
      arch=i686-linux-gnu
      LIBSDIR=$(pwd)/builds/linux/i686
      ;;
    x86_64-w64-mingw32|win64|windows|x64-win* )
      arch=x86_64-w64-mingw32
      LIBSDIR=$(pwd)/builds/windows/x86_64
      ;;
    i686-w64-mingw32|win32|i686-win*|x86-win* )
      arch=i686-w64-mingw32
      LIBSDIR=$(pwd)/builds/windows/x86
      ;;
    rpi3b|rpi4|aarch64-linux|aarch64-linux-gnu )
      arch=aarch64-linux-gnu
      LIBSDIR=$(pwd)/builds/arm/aarch64
      ;;
    rpi2|armhf|arm-linux|arm-linux-gnueabihf )
      arch=arm-linux-gnueabihf
      LIBSDIR=$(pwd)/builds/arm/armeabihf
      ;; 
    --api) shift && export API=$1;;
    --prefix) shift && LIBSDIR=$1;;
    --desc ) echo $dsc && exit 0;;
    --help|-h) showBanner && usage && exit 0;;
    --clean ) clean && exit 0;;
    --clearall ) clearAll && exit 0;;
    --update )
      rm $LIBSDIR/lib/pkgconfig/${pkg}.pc >/dev/null
      rm -rf $(pwd)/sources/$lib >/dev/null
      ;;
    --vrep ) getGitLastTag $src && exit 0;;
    --opts ) showOpts "$(pwd)/sources/$lib" && exit 0;;
    --checkPkg ) checkPkg && exit 0;;
    --libName ) echo $lib && exit 0;;
    --getVar ) shift && echo $($1) && exit 0;;
    --refresh ) update=1;;
    --retry ) retry=1;;
    --rebuild ) rm $LIBSDIR/lib/pkgconfig/${pkg}.pc;;
    --shared ) CSH="${cs1} ${CSH}";;
    --static) CSH="${cs0} ${CSH}";;
    --bin ) CBN="${cb1}";;
    --nobin) CBN="${cb0}";;
    --cmake ) cfg='cm';;
    --ndkcmake) ndkcmake=1;;
    --advanced ) advcfg=1;;
    --ccmake) cfg='ccm';;
    --nobanner) banner=0;;
    --debug) debug=1;;
    --nodev) nodev=1;;
    --vlatest) echo $(githubLatestTarGz) && exit 0;;
    
    * ) if [ "$(type -t extraOpts)" = 'function' ]; then
          extraOpts $1
        else
          showBanner && usage && exit 1
        fi
        ;;
  esac
  shift
done

if [ -z "$ISRUNNING" ]; then
  showBanner
  export ISRUNNING=1
fi
if ! sudo -n true 2>/dev/null; then
  echo -ne "  ${CY1}Requesting sudo for tool install "
  sudo echo -ne "\r"
fi


# set theme colors
case $arch in
  *android* )    CT0=$CG0 CT1=$CG1 CS0=$CR0 CS1=$CR1 ;;
  *linux-gnu )   CT0=$CM0 CT1=$CM1 CS0=$CR0 CS1=$CR1 ;;
  *w64-mingw32 ) CT0=$CC0 CT1=$CC1 CS0=$CR0 CS1=$CR1 ;;
esac

setBuildOpts(){
  echo
  #if [[ $bshared ]];then
  #  [[ $bshared -eq 1 ]] && CSH=$cs1
  #  [[ $bshared -eq 0 ]] && CSH=$cs0
  #fi
  #if [[ $bbin ]];then
  #  [[ $bbin -eq 1 ]] && CBN=$cb1
  #  [[ $bbin -eq 0 ]] && CBN=$cb0
  #fi
}

export arch update retry bshared bbin advcfg CSH CBN LIBSDIR

main
