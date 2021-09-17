#!/bin/bash
# ................................................
# toolchain utils diasgc 2020
# git: https://github.com/diasgc/bashscripts.git
# ................................................

# def colors
C0="\e[0m"; CW="\e[97m"; CD="\e[90m"
CR0="\e[31m"; CR1="\e[91m";
CG0="\e[32m"; CG1="\e[92m";
CY0="\e[33m"; CY1="\e[93m";
CB0="\e[34m"; CB1="\e[94m";
CM0="\e[35m"; CM1="\e[95m";
CC0="\e[36m"; CC1="\e[96m";

# theme colors
CT0=$CY0; CT1=$CY1; CS0=$CM0; CS1=$CM1

debug=
vsh='2.2'
cmake_build_type=Release

if [ -z "$BUILD_TRIP" ]; then
  case "$(uname -s)" in
    Linux)  BUILD_TRIP=$(echo $(uname -m)-linux-gnu)
      [ -n "$(grep -q BCM2708 /proc/cpuinfo)" ] && BUILD_TRIP="${BUILD_TRIP}eabihf"    
      ;;
    Darwin) BUILD_TRIP=$(echo $(uname -m)-darwin-gnu);;
    CYGWIN*|MINGW32*|MSYS*|MINGW*) BUILD_TRIP=$(echo $(uname -m)-w64-mingw32);;
  esac
  export BUILD_TRIP
fi

main(){
  [ $debug ] && echo -ne "${CY0}main() arch=$arch"  
  # exit if missing vars lib arch or src
  [ -z "$lib" ] && [ -z "$src" ] && errCall

  STARTTIME=0
  ENDTIME=0
  update=

  export PKGDIST=$(pwd)/packages/$arch
  export LIBSDIR=$(pwd)/builds/$arch
  export SOURCES=$(pwd)/sources
  [ -d $SOURCES ] || mkdir -p $SOURCES
  export SRCDIR=$SOURCES/$lib
  export INSTALL_DIR=$LIBSDIR/$lib
  export PKGDIR=$INSTALL_DIR/lib/pkgconfig

  # show package info
  pkgInfo

  LOGFILE=$LIBSDIR/${lib}.log

  export HOST_NPROC=$(nproc)
  export PKG_CONFIG=$(which pkg-config)
  # check make
  [ -z $(which make) ] && log make && logme sudo apt -qq install make -y
  export MAKE_EXECUTABLE=$(which make)
  # check nasm
  [ -z $(which nasm) ] && log nasm && logme sudo apt -qq install nasm -y
  export NASM_EXECUTABLE=$(which nasm)
  # check pkg-config
  [ -z $(which pkg-config) ] && log pkgconfig && logme sudo apt -qq install pkg-config -y
  [ "$bty"=="ac" ] && [ -z $(which autoconf) ] && \
  log autotools && logme sudo apt -qq install automake autoconf autogen autopoint libtool m4 -y
}

start(){
  [ $debug ] && echo -ne "${CY0}start() arch=$arch cfg=$CFG "
  if [ -z "$update" ] && [ -f $PKGDIR/$pkg.pc ]; then
    log "  $lib "
    logver $PKGDIR/$pkg.pc
    log ' done'
    echo
    exit
  fi
  
  # Reset LOGFILE
  [ -f $LOGFILE ] && rm -f $LOGFILE

  # Reset INSTALL_DIR
  [ -d $INSTALL_DIR ] && rm -rf $INSTALL_DIR

  # Create INSTALL_DIR and PKGCONFIG DIR
  mkdir -p $PKGDIR
  export PKG_CONFIG_PATH=$PKGDIR

  # Check Tools and Dependencies
  chkTools $tls
  chkDeps $dep

  logstart $arch ${eta}s
  cd $SOURCES

  [ -n "$update" ] && rm -rf $SRCDIR
  [ -z "$retry" ] && [ "$dbld" != "$SRCDIR" ] && rm -rf $dbld

  if [ ! -d $SRCDIR ];then
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
    if [ "$(type -t patchSrc)" = 'function' ]; then
      patchSrc
    fi
  fi

  [ ! -d $dbld ] && mkdir -p $dbld
  pushd $dbld >/dev/null

  # check whether to build manually or auto/cmake
  [ "$(type -t beforeBuild)" = 'function' ] && beforeBuild
  
  echo -e "Variables: \nCFLAGS=$CFLAGS\nCXXFLAGS=$CXXFLAGS\nCPPFLAGS=$CPPFLAGS\nLDFLAGS=$LDFLAGS\nLIBS=$LIBS\n\nPKG_CONFIG_PATH=$PKG_CONFIG_PATH\n\nCC=$CC\nCXX=$CXX\n\n\n" >>$LOGFILE 2>&1
  
  if [ "$(type -t buildLib)" = 'function' ]; then
    buildLib
  else
    log 'clean '
    ${MAKE_EXECUTABLE} clean >/dev/null 2>&1
    case $cfg in
      cm)   doLog 'cmake' ${CMAKE_EXECUTABLE} $SRCDIR -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DCMAKE_BUILD_TYPE=$cmake_build_type $CFG $CSH $CBN
            [ $advcfg ] && inlineCcmake $SRCDIR
            ;;
      ac|am|ag|ar) doLog 'configure' $dbld/configure --prefix=${INSTALL_DIR} $CFG $CSH $CBN
            ;;
      mk)   MKF=$CFG;;
      *)    doErr "No cfg found or unknown $cfg"
            ;;
    esac

    # check whether to create patch Makefile
    if [ "$(type -t patchMakefile)" = 'function' ]; then
      doLog 'patch' patchMakefile
    fi

    doLog 'make' ${MAKE_EXECUTABLE} $MKF -j${HOST_NPROC}
    if [ -z "$mkinstall" ];then
      doLog 'install' ${MAKE_EXECUTABLE} install
    else
      doLog 'install' ${MAKE_EXECUTABLE} $mkinstall
    fi
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
  exit
}

# cursor macros
cursorUp(){
  echo -ne "\e[${1}A"
}
cursorDn(){
  echo -ne "\e[${1}B"
}
cursorFw(){
  echo -ne "\e[${1}C"
}
cursorBk(){
  echo -ne "\e[${1}D"
}
cursorTo(){
  echo -ne "\e[${1};${2}H"
}
cursorToBottomStart(){
  echo -ne "\e[$(tput lines);0H"
}
cursorRow(){
  IFS=';' read -sdR -p $'\e[6n' ROW COL && echo "${ROW#*[}"
}
isBottomRow(){
  test "$(echo "lines"|tput -S)" == "$(IFS=';' read -sdR -p $'\e[6n' ROW COL && echo "${ROW#*[}")" && echo 1 || echo 0
}
echoBottom(){
  tput sc && echo -ne "\e[$(tput lines);0H$@" && tput rc
}



showTargets(){
  echo -e "$(
		cat <<-EOM
		\n  ${CT0}targets:\n  aarch64-linux-android\tarm-linux-androideabi
		  xi686-linux-android\tx86_64-linux-android
		  x86-linux-gnu\t\tx86_64-linux-gnu
		  x86-w64-minwg\t\tx86_64-w64-minwg\n\n${C0}
		EOM
	)"
}

errCall(){
  echo -e "$(
    cat <<-EOM
			\n\n\t$CWtcutils $vrs
			\t${C0}Cannot be called directly. Missing vars lib arch or src
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

doLog() {
  echo -ne "${CD}$1${C0}"
  shift
  echo -e "\n\n$@\n----------------------------------------\n" >> "$LOGFILE"
  echo "$(date): $@" >> "$LOGFILE"
  "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
  echo -e "----------------------------------------\n" >> "$LOGFILE"
  logok
}

logok() {
  echo -ne "$C0 ok "
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
  local inL="\e[u"
  [[ $(isBottomRow) -eq 1 ]] && inL="$inL\e[2A"
  echo -ne "\e[s" && ccmake $@ && echo -ne "${inL}"
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
  setGitVrs
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
    echo $(git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' $1 | tail -n1 | cut -d'/' -f3)
  else
    echo "n/a"
  fi
}

# usage: getTarLZ url libname
getTarLZ(){
  [ -z $(which lzip) ] && sudo apt -qq install lzip -y >/dev/null 2>&1
  log download
  wget -O- $1 2>/dev/null | tar --lzip -xv >/dev/null 2>&1
  [ "$2" != "" ] && mv $2* $2
  logok
}

# usage: getTarXZ url libname
getTarXZ(){
  log download
  wget -O- $1 2>/dev/null | tar -xvJ >/dev/null 2>&1 || err
  [ -n "$2" ] && mv $2* $2
  logok
}

# usage: getTarGZ url libname
getTarGZ(){
  log download
  wget -O- $1 2>>$LOGFILE | tar -xz >>$LOGFILE 2>&1
  [ -n "$2" ] && mv $2* $2
  logok
}

getZip(){
  [ -z $(which unzip) ] && aptInstall unzip
  log download
  wget $1 -O tmp.zip
  log extract unzip tmp.zip
  rm tmp.zip
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
    [ -n "$libname" ] && cp -f $LIBSDIR/$libname/lib/pkgconfig/*.pc $PKGDIR
    # export PKG_CONFIG_PATH=$pkgfile:$PKG_CONFIG_PATH
    # echoBottom $PKG_CONFIG_PATH
    shift
  done
  for i in $PKGDIR/*.pc; do
    PKG_CONFIG_PATH="${i}:$PKG_CONFIG_PATH"
  done
  export PKG_CONFIG_PATH
}

# usage setPkgConfigDir <pkg-dir>
setPkgConfigDir(){
  [ $1 ] || doErr "missing argument. usage setPkgConfigDir <pkg-dir>"
  local ppath=$1 && shift
  local pcfile
  pushd $ROOTDIR >/dev/null
  if [ -z "$1" ];then
    for i in $ppath/*.pc; do
      CFLAGS="$(pkg-config --cflags $i) $CFLAGS"
      LDFLAGS="$(pkg-config --libs --static $i) $LDFLAGS"
      PKG_CONFIG_PATH="${i}:$PKG_CONFIG_PATH"
    done
  else
    while [ -n "$1" ]; do
      pcfile=$(./$1.sh $arch --checkPkg)
      CFLAGS="$(pkg-config --cflags $pcfile) $CFLAGS"
      LDFLAGS="$(pkg-config --libs --static $pcfile) $LDFLAGS"
      PKG_CONFIG_PATH="${pcfile}:$PKG_CONFIG_PATH"
      shift
    done
  fi
  popd >/dev/null
  export PKG_CONFIG_PATH CFLAGS LDFLAGS
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
  log autogen
  pushd $1 >/dev/null && shift
  case $1 in
    --noerr ) ./autogen.sh >>$LOGFILE 2>&1;;
    --noconfigure ) NOCONFIGURE=1 logme ./autogen.sh;;
    * ) logme ./autogen.sh;;
  esac
  popd >/dev/null
}

doAutoreconf(){
  log autoreconf
  pushd $1 >/dev/null
  logme autoreconf -fi
  popd >/dev/null
}

checkUrl(){
  wget -S --spider $1 2>&1 | grep -q "HTTP/1.[0-9] 200 OK" && echo SUCCESS || echo FAIL
}

checkCmd(){
  [ -z "$(which $1)"] sudo apt -qq install $1 -y >/dev/null 2>&1
}

checkMairix(){
  cd sources
  if [ ! -d "$(pwd)/sources/mairix" ];then
    echo -ne "${CT0} mairix ${C0}"    
    {
      wget http://sourceforge.net/projects/ezwinports/files/mairix-0.22-w32-src.zip/download && \
      unzip download && \
      rm -f download && \
      mv mairix-* mairix
    } >/dev/null 2>&1
  fi
  cd ..
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
  checkCmd unzip
  echo -ne " ${CS0}downloading..."
  tput sc && echo -ne "\e[$(tput lines);0H${CY1}"
  wget --progress=dot $1 -O tmp.zip 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\r%4s %s eta:%s  ",$2,$1,$4)}'
  tput rc
  echo -ne "${CS0} decompressing... ${C0}"
  unzip tmp.zip >/dev/null 2>&1 && rm tmp.zip || err
}

ndkPatchLpthread(){
  # NDK Patch: create missing libpthread in NDK
	lpthread="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/$TARGET/libpthread.a"
	[ ! -f $lpthread ] && $AR cr $lpthread
}

assertAndroidHome(){
  if [ -z "$ANDROID_HOME" ];then
    export ANDROID_HOME=~/android
    mkdir -p $ANDROID_HOME
    local 
    [ -f ~/.bashrc ] && [ -z "$(grep 'export ANDROID_HOME' ~/.bashrc)" ] && \
      printf "\n\nexport ANDROID_HOME=$ANDROID_HOME\nexport PATH=\$ANDROID_HOME:\$PATH" >> ~/.bashrc
    source ~/.bashrc
  fi
}

installAndroidNDK(){
  local ndk_v=$(getCurrentNdkVrs)
  if [ -z "$ndk_v" ];then
    assertAndroidHome
    export ANDROID_NDK_HOME=$ANDROID_HOME/android-ndk
    local NDK_URL=
    while [ -z $NDK_URL ];do
      echo -ne "  ${C0}Please select NDK version to install (latest is"
      NDK_URL=$(getLatestNdkUrl)
      local ndkv=$(echo $NDK_URL | grep -Eo 'r[0-9]+[a-z]')
      echo -ne " $ndkv): ${CW}" && read ANDROID_NDK_VERSION
      if [ "$ANDROID_NDK_VERSION" == "latest" ];then
        NDK_URL=$(getLatestNdkUrl)
        ANDROID_NDK_VERSION=$(echo $NDK_URL | grep -Eo 'r[0-9]+[a-z]')
        break
      fi
      NDK_URL="https://dl.google.com/android/repository/android-ndk-${ANDROID_NDK_VERSION}-linux-x86_64.zip"
      ST=$(checkUrl $NDK_URL)
      [ "FAIL" == "$ST" ] && echo -ne "  \e[1A\e[2K${CR1}version $ANDROID_NDK_VERSION does not exists.${CW}" && NDK_URL=
    done
    pushd $ANDROID_HOME >/dev/null
    echo -ne "\n  ${C1}Installing NDK-${ANDROID_NDK_VERSION}..." && download $NDK_URL && echo -e "${CW} ok ${C0}" || err
    mv android-ndk-* android-ndk
    [ -z "$(cat ~/.bashrc | grep 'ANDROID_NDK_HOME')" ] && printf "export ANDROID_NDK_HOME=$ANDROID_HOME/android_ndk\n" >> ~/.bashrc
    popd >/dev/null
  else
    echo -e "${CT1} Android-NDK: v.${ndk_v}${CT0}"
  fi
}

getLatestNdkUrl(){
  echo $(wget -qO- https://github.com/android/ndk/blob/master/Home.md | \
    grep -o 'https://dl.google.com/android/repository/android-ndk-r.*-linux-x86_64.zip"' | \
    rev | cut -c2- | rev)
}
getCurrentNdkVrs(){
  cat $ANDROID_NDK_HOME/source.properties | grep "^Pkg.Revision = " | sed 's/Pkg.Revision = //'
}
getLatestStableNdkVrs(){
 echo $(wget -qO- https://developer.android.com/ndk/downloads | \
  grep ndkVersion | tr ' ' '\n' | tail -n1 | sed 's/"//g')
}

checkAndroidCmdlineTools(){
  assertAndroidHome
  local dirCmdlinetools=$ANDROID_HOME/cmdline-tools/tools/bin
  if [ ! -d $dirCmdlinetools ];then
    echo -ne "  ${CW}Command-line Tools${C0}"
    pushd $ANDROID_HOME >/dev/null
    download https://dl.google.com/android/repository/commandlinetools-linux-6514223_latest.zip
    mkdir cmdline-tools
    mv tools cmdline-tools
    export PATH=$dirCmdlinetools:$PATH
    export PATH=$ANDROID_HOME/tools:$PATH
    popd >/dev/null
    echo -e " ok "
  fi
}

installAndroidCMake(){
  checkAndroidCmdlineTools
  [ -z "$JAVA_HOME" ] && installJava
  if [ ! -d "$ANDROID_HOME/cmake" ];then
    $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager "cmake;3.10.2.4988404"
  else
    echo -e "${CT1} NDK-cmake: $($ANDROID_HOME/cmake/*/bin/cmake --version | head -n1)"
  fi
}

installAndroidPlatform(){
  checkAndroidCmdlineTools
  API=$1
  buildtools=$(./sdkmanager --list | grep "build-tools" | tail -n1 | grep -o "build-tools;[0-9\.|]*")
  [ -z "$API" ] && API=$(echo $buildtools | grep -o ";[0-9]*." | sed "s/;//g" | sed "s|\.||")
  $ANDROID_HOME/cmdline-tools/tools/bin/sdkmanager "platform-tools" "platforms;android-$API" "$buildtools"
}

instalCmdlineTools(){
  checkAndroidCmdlineTools
  [ -z "$JAVA_HOME" ] && installJava
  local tools=
  while [ "$1" != "" ];do
    case $1 in
      platform-tools ) tools="$tools \"$1\""
        export PATH=$ANDROID_HOME/platform-tools:$PATH;;
      platforms* ) tools="$tools \"$1\"";;
      build-tools* ) tools="$tools \"$1\"";;
      cmake* ) tools="$tools \"$1\"";;
    esac
    shift
  done
  if [ -n "$tools" ];then
    pushd $dirCmdlinetools >/dev/null
    echo -ne "${CS0}${tools}${C0} "
    ./sdkmanager $tools
    echo -e "\n\n\n"
    popd >/dev/null
  fi
}

installRust(){
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

installJava(){
  echo -e "${CT1} OpenJDK-8: "
  aptInstallBr lib32z1 openjdk-8-jdk
  if [ -z "$JAVA_HOME" ];then
    export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64 PATH=$JAVA_HOME:$PATH && \
    printf "\n\nexport JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> ~/.bashrc
  fi
  echo -e "\n${C0}"
}

installGnueabihf(){
  echo -e "${CT1} Aarch64/ArmHF-linux toolchains: "
  aptInstallBr gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
  echo -ne "${CT0}  "
}

installXCompileARMHF(){
  echo -e "${CT1}  "
  aptInstall gcc-multilib-arm-linux-gnueabihf g++-multilib-arm-linux-gnueabihf gdb-multiarch
  echo -e "\n${C0}"
}

installXCompileMINGW(){
  echo -e "\n${CT1} MinGW32 i686/x86_64 toolchains: "
  aptInstallBr mingw-w64 mingw-w64-tools binutils-mingw-w64
  echo -e "\n${C0}"
}

# installLinaro aarch64-elf | aarch64-linux-gnu | aarch64_be-elf | aarch64_be-linux-gnu
# arm-eabi | arm-linux-gnueabi | arm-linux-gnueabihf | armeb-eabi
# armeb-linux-gnueabi | armeb-linux-gnueabihf | armv8l-linux-gnueabihf
installLinaro(){
  LINARO_HOME=~/linaro
  [ ! -d $LINARO_HOME ] && mkdir -p $LINARO_HOME
  pushd $LINARO_HOME
  local a="https://releases.linaro.org"
  local b="components/toolchain/binaries"
  local c=$(wget -qO- ${a}/${b}/ | grep -Eo "${b}/latest-[0-9]*")
  c="${a}/${c}"
  local gccv="7.5.0-2019.12"
  local sysv="2.25-2019.12"
  local gcc="${c}/${1}/gcc-linaro-${gccv}-x86_64_${1}.tar.xz"
  local sysroot="${c}/${1}/sysroot-glibc-linaro-${sysv}-${1}.tar.xz"
  local runtime="${c}/${1}/runtime-gcc-linaro-${gccv}-${1}.tar.xz"
  wget -O- $gcc | tar -xJ

}

aptUpdate(){
  #if [ $(/usr/lib/update-notifier/apt-check |& cut -d";" -f 1) -gt 0 ]; then
  #fi
  #doLog 'Updating' sudo apt update
  #doLog 'Upgrading' sudo apt -y dist-upgrade
  #doLog 'Cleaning' sudo apt autoremove -y
  sudo echo -ne ""
  echo -ne "  ${CT1}Updating "
  sudo apt update >/dev/null 2>&1
  echo -ne "${CW}ok ${CT1}Upgrading "
  sudo apt -y dist-upgrade >/dev/null 2>&1
  echo -ne "${CW}ok ${CT1}Cleaning "
  apt autoremove -y >/dev/null 2>&1
  sudo apt autoclean -y >/dev/null 2>&1
  sudo apt install locate >/dev/null 2>&1
  echo -e "${CT1}done${C0}\n"
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

aptInstallBr(){
  while [ "$1" != "" ];do
    echo -ne "  ${CT0}install $1${C0} "
    sudo apt -qq install $1 -y >/dev/null 2>&1
    echo -e "${C0}ok ${CT1}done${C0} $(apt-cache show $1 | grep Version)"
    shift
  done
}

install(){
  echo -e "\n  ${CD}Installing feature: ${CB}$1${C0}\n"
  case $1 in
    android-ndk ) installAndroidNDK;;
    android-cmake ) installAndroidCMake;;
    android-platform ) installAndroidPlatform;;
    mingw ) installXCompileMINGW;;
    armhf ) installGnueabihf;;
    java ) installJava;;
    * ) echo -e "\t${CS0}Install Options: ${CW}\n\n\tandroid-ndk\n\tandroid-cmake\n\tandroid-platform\n\tmingw\n\tarmhf\n\tjava\n\n$C0";;
  esac
}

# http://repo.msys2.org/mingw/x86_64/mingw-w64-x86_64-libtool-2.4.6-17-any.pkg.tar.zst
# usage installMingwPkg <pkg-name> <pkg-url> <dest-dir>
installMingw64Pkg(){
  local pkgname=$1
  local pkgurl=$2
  [ $pkgname ] || [ $pkgurl ] echo -e "\n  {CR1}ERROR: missing args in installMingwPkg\n"
  [ $(which zstd) ] || echo -ne "${CS0}get zstd " && tput sc && sudo apt-get -qq install zstd -y && tput rc
  log "  get pkg $pkgname "
  wget -O- $pkgurl | unzstd | tar -x
  sudo cp -r mingw64/bin/* /usr/x86_64-w64-mingw32/bin
  sudo cp -r mingw64/lib/* /usr/x86_64-w64-mingw32/lib
  sudo cp -r mingw64/include/* /usr/x86_64-w64-mingw32/include
  rm -rf mingw64
  logok
}

loadToolchain(){

  local posix=""

  while [ -n "$1" ];do
    case $1 in
      --posix ) posix="-posix";;
    esac
    shift
  done

  CMAKE_EXECUTABLE=cmake
  YASM=yasm
  PKG_CONFIG=pkg-config

  case $arch in
  
    # Android
    *-linux-android|*-linux-androideabi ) PLATFORM=Android
      [ -d ${ANDROID_HOME}/cmake ] && CMAKE_EXECUTABLE=${ANDROID_HOME}/cmake/3.10.2.4988404/bin/cmake
      CMAKE_TOOLCHAIN=${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake
      TOOLCHAIN=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
      SYSROOT=${TOOLCHAIN}/sysroot
      CROSS_PREFIX=${TOOLCHAIN}/bin/$arch-
      [ -z "$API" ] && API=24
      LT_SYS_LIBRARY_PATH="$SYSROOT/usr/lib/$arch/$API"
      [[ $CSH = $cs1 ]] && export LDFLAGS="-Wl,-rpath,$LT_SYS_LIBRARY_PATH $LDFLAGS"
      YASM=${TOOLCHAIN}/bin/yasm
      CC=${TOOLCHAIN}/bin/${arch}${API}-clang CXX=${CC}++
      ;;&
    aarch64-linux-android ) ABI="arm64-v8a";;
    arm-linux-androideabi ) ABI="armv7-a" 
      CROSS_PREFIX=${TOOLCHAIN}/bin/arm-linux-androideabi- 
      CC=${TOOLCHAIN}/bin/armv7a-linux-androideabi${API}-clang CXX=${CC}++;;
    i686-linux-android ) ABI="i686";;
    x86_64-linux-android ) ABI="x86_64";;
    
    # Linux
    i686-linux-gnu|x86_64-linux-gnu ) PLATFORM=Linux
      TOOLCHAIN="/usr"
      SYSROOT=
      CROSS_PREFIX=
      LT_SYS_LIBRARY_PATH="/usr/lib/gcc/$arch/9"
      CC=gcc CXX=g++
      ;;
    a*-linux-gnu* ) PLATFORM=Linux
      TOOLCHAIN="/usr/$arch/bin"
      SYSROOT="/usr/$arch"
      CROSS_PREFIX="${arch}-"
      LT_SYS_LIBRARY_PATH="/usr/lib/gcc/$arch/9"
      CC="$arch-gcc" CXX="$arch-g++"
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
      CC=${CROSS_PREFIX}gcc${posix} CXX=${CROSS_PREFIX}g++${posix}
      ;;

  esac

  LD=${CROSS_PREFIX}ld
  AS=${CROSS_PREFIX}as
  ADDR2LINE=${CROSS_PREFIX}addr2line
  AR=${CROSS_PREFIX}ar
  NM=${CROSS_PREFIX}nm
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
    ADDR2LINE AR NM OBJCOPY OBJDUMP RUNLIB \
    READELF SIZE STRINGS STRIP WINDRES \
    CROSS_PREFIX LT_SYS_LIBRARY_PATH
}

getMinGwVersion(){
  echo $(x86_64-w64-mingw32-gcc --version | head -n1 | grep -Eo "(GCC).+-win32" | sed 's|GCC) \(.*\)-win32|\1|')
}

errUnknownTarget(){
  if [ $arch ];then
    echo -e "\n  ${CR1}unknown target ${arch}${C0}\n" && exit 1
  else
    echo -e "\n  ${CR1}must specify a target${C0}\n" && showTargets && exit 1
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
  [ $lib ] && [ $pkg ] && \
    [ -f "$(pwd)/builds/${arch}/${lib}/lib/pkgconfig/${pkg}.pc" ] && \
    [ -d "$(pwd)/builds/${arch}/${lib}/include" ] && \
    echo "$(pwd)/builds/${arch}/${lib}/lib/pkgconfig/${pkg}.pc" || echo ""
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
      VRS="${CT0} vrs: ${C0}${vgit}"
    fi
  fi
  echo -e "$(
  cat <<-EOF
		\n${CW}  ${lib^^} - ${CD}${dsc} [$BUILD_TRIP]
		${CT0}  Licence ${C0}$lic ${DP} ${VRS}
		EOF
  )"
}

createDistPkg(){
  pushd $INSTALL_DIR >/dev/null
  cd ..
  doLog 'packaging' tar -czvf ${lib}aom-${vrs}-${arch}.tar.gz $lib
  popd >/dev/null
}



# SETUP------------------------------------------------------------------------
MENU_BACKTITLE="Setup utility"
dialogMenu(){
  local cnt=0
  local wtitle=$1 && shift
  local mtitle=$1 && shift
  IFS=' ' read -r -a vals <<< "$@"
  while [ -n "$1" ];do
    menu="$menu $cnt $1"
    shift
    let cnt=cnt+1
  done
  out=$(dialog --clear --backtitle "$MENU_BACKTITLE" --title "$wtitle" \
    --menu "$mtitle:" 20 120 $cnt $menu 2>&1 >/dev/tty)
  echo ${vals[$out]}
}

toolchainMenu(){
  local cnt=0
  local i=1
  local wtitle=$1 && shift
  local mtitle=$1 && shift
  declare -a arr
  IFS=' ' read -r -a vals <<< "$@"
  arr=("1" "android-clang" "on" "2" "aarch64-linux" "on" "3")
  while [ -n "$1" ];do
    arr[ $i ]=$cnt
    let cnt=cnt+1
    val=$1
    [ -f "$1.sh" ] && val="${val}: $(./$1.sh --desc)"
    arr[ ($i + 1) ]=$val
    arr[ ($i + 2) ]="on"
    (( i=($i+3) ))
    shift  
  done
  local out=$(dialog --clear--backtitle "$MENU_BACKTITLE" --title "$wtitle" \
    --checklist "$mtitle:" 20 120 $cnt "${arr[@]}" 2>&1 >/dev/tty)
  local outvals=
  for i in $out;do outvals="$outvals ${vals[$i]}"; done
  echo ${outvals}
}

# END SETUP---------------------------------------------------------------------

usage(){
  echo -e "$(
  cat <<-EOF
    \n\t${CW}usage: $0 ${CS0}<target> ${C0}[--update|--clean|--clearall|--opts][--shared][--bin]\n
    \t${CS0}<target>:${CM0} android: aarch64-linux-android | arm-linux-androideabi | i686-linux-android | x86_64-linux-android
    \t\t${CM0}  linux:   aarch64-linux-gnu | arm-linux-gnueabihf | i686-linux-gnu | x86_64-linux-gnu
    \t\t${CM0}  windows: i686-w64-mingw32 | x86_64-w64-ming32\n
    \t${C0}--update ${CD}\tupdate system (requires previous sudo apt update)
    \t${C0}--install <opt>${CD}\tsetup build system:
    \t${C0}                android-ndk:${CD}     install latest NDK toolchain
    \t${C0}                android-cmake${CD}    install android CMake
    \t${C0}                android-platform${CD} install android platform and build-tools
    \t${C0}                java${CD}             install jdk
    \t${C0}                mingw${CD}            install cross-compile w64-ming32 toolchain
    \t${C0}                armhf${CD}            install cross-compile armhf toolchain\n
    \t${C0}--resfresh${CD}\tforce source update/download (git/svn/etc)
    \t${C0}--retry   ${CD}\tretry build without clear cache
    \t${C0}--clean   ${CD}\tclean up last build
    \t${C0}--clearall${CD}\tclean builds dir, sources dir and all logs
    \t${C0}--opts    ${CD}\tshow advanced options (nano) for build
    \t${C0}--advanced${CD}\tshow ccmake advanced settings before make
    \t${C0}--noshared${CD}\tforcec disable build shared/dynamic libs
    \t${C0}--bin     ${CD}\tenable build executables
    \t${C0}--nobin   ${CD}\tforce disable build executables\n
EOF
)" 
}

setup(){
  echo -e "\n\n ${CT1}Setup${C0}"
  echo -e " ${CT1}Install tools: ${C0}"
  aptInstallBr unzip zstd build-essential cmake cmake-curses-gui pkg-config dialog automake autoconf autopoint m4 libtool nasm
  installGnueabihf
  installXCompileMINGW
  installAndroidNDK
  read -p "  Install NDK tools and Jdk ? (Yn): " yn
  case $yn in Y|y) installJava && installAndroidCMake;;esac
  source ~/.bashrc
}

monitTmp(){
  if [ -n "$(uname -a | grep -Eo 'microsoft')" ];then
    echo -e "${CR1}  Cannot run chkTemp on WSL/WSL2${C0}"
    exit 1
  fi
  while true;do
    paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/'
    sleep 2
  done
}

showBanner(){
  echo -ne "\n\n  ${CW}Bashscripts Build 2.1 for Linux${C0}\n  "
  if [ -n "$(uname -r | grep 'microsoft')" ];then
    echo -ne "WSL2 "
  elif [ -n "$(uname -r | grep 'Microsoft')" ];then
    echo -ne "WSL "
  else
    echo -ne "Native "
  fi
  echo -e "$(uname -o) $(uname -m) ${CD} $(uname -r)"
}

# main

update=
retry=
bshared=
bbin=
advcfg=

# default arch is x86_64-linux
arch=x86_64-linux-gnu

while [ $1 ];do
  case $1 in
    aarch64-linux-android|aarch64-android|arm64-android|android ) arch=aarch64-linux-android;;
    arm-linux-androideabi|arm-android|armv7-android ) arch=arm-linux-androideabi;;
    x86_64-linux-android|x64-android|x86_64-android ) arch=x86_64-linux-android;;
    x86-*android|i686-*android ) arch=i686-linux-android;;
    x86_64-linux-gnu|x64-linux|linux|linux64 ) arch=x86_64-linux-gnu;;
    i686-linux-gnu|x86-linux|i686-linux|linux32 ) arch=i686-linux-gnu;;
    x86_64-w64-mingw32|win64|windows|x64-win* ) arch=x86_64-w64-mingw32;;
    i686-w64-mingw32|win32|i686-win*|x86-win* ) arch=i686-w64-mingw32;;
    rpi3b|rpi4 ) arch=aarch64-linux-gnu;;
    rpi2|armhf ) arch=arm-linux-gnueabihf;;
    --desc ) echo $dsc && exit 0;;
    --help|-h) usage && exit 0;;
    --clean ) clean && exit 0;;
    --clearall ) clearAll && exit 0;;
    --update ) showBanner && aptUpdate && exit 0;;
    --vrep ) getGitLastTag $src && exit 0;;
    --opts ) showOpts "$(pwd)/sources/$lib" && exit 0;;
    --checkPkg ) checkPkg && exit 0;;
    --libName ) echo $lib && exit 0;;
    --getVar ) shift && echo ${$1} && exit 0;;
    --refresh ) update=1;;
    --retry ) retry=1;;
    --rebuild ) rm -rf $(pwd)/builds/$arch/$lib;;
    --shared ) bshared=1;;
    --noshared ) bshared=0;;
    --bin ) bbin=1;;
    --nobin ) bbin=0;;
    --cmake ) cfg='cm';;
    --advanced ) advcfg=1;;
    --install ) shift && install $1 && exit 0 ;;
    --setup ) setup && exit 0;;
    --chkTemp ) monitTmp && exit 0;;
    * ) if [ "$(type -t extraOpts)" = 'function' ]; then
          extraOpts $1
        else
          usage && exit 1
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
  echo -ne "  ${CY1}Requesting sudo for further tool install w/o prompting "
  sudo echo -ne "\r"
fi


# set theme colors
case $arch in
  *android* )    CT0=$CG0 CT1=$CG1 CS0=$CM0 CS1=$CM1 ;;
  *linux-gnu )   CT0=$CY0 CT1=$CY1 CS0=$CM0 CS1=$CM1 ;;
  *w64-mingw32 ) CT0=$CC0 CT1=$CC1 CS0=$CM0 CS1=$CM1 ;;
esac

setBuildOpts(){
  if [[ $bshared ]];then
    [[ $bshared -eq 1 ]] && CSH=$cs1
    [[ $bshared -eq 0 ]] && CSH=$cs0
  fi
  if [[ $bbin ]];then
    [[ $bbin -eq 1 ]] && CBN=$cb1
    [[ $bbin -eq 0 ]] && CBN=$cb0
  fi
}

setBuildOpts

export arch update retry bshared bbin advcfg CSH CBN ROOTDIR=$(pwd)

main
