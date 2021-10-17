#!$SHELL
# ................................................
# X-Builder util 0.3.1 2021-diasgc
# ................................................
[ -z ${vsh+x} ] && . .common

set -o pipefail

trap err ERR

sudo=$(which sudo)
[ -z ${debug+x} ] && debug=false
[ -z ${nodev+x} ] && nodev=false
[ -z ${is_init+x} ] && is_init=false
[ -z ${pkg+x} ] && pkg=${lib}
[ -z ${apt+x} ] && apt=${lib}
[ -z ${ac_nohost+x} ] && ac_nohost=false
[ -z ${lib_noshared+x} ] && lib_noshared=false
[ -z ${ac_nosysroot+x} ] && ac_nosysroot=false
[ -z ${ac_nopic+x} ] && ac_nopic=false
[ -z ${banner+x} ] && banner=true
[ -z ${req_update_deps+x} ] && req_update_deps=false
[ -z ${update+x} ] && update=false

$req_update_deps && update=true

cmake_build_type=Release
cmake_toolchain_file=

mingw_posix_suffix=
update=false
retry=false
use_llvm_mingw=true
use_clang=true

# default build static, no shared, no executables
build_shared=false
build_static=true
build_bin=false
build_usepkgflags=false
git_stable=false
ndkcmake=false

build_package=true
only_repo=false
pc_filelist=

shell_dstack=

aptInstallBr(){
  while [ -n "$1" ];do
    echo -ne "${ind}${CT0}install $1${C0} "
    $sudo apt -qq install $1 -y >/dev/null 2>&1
    echo -e "${C0}ok ${CT1}done${C0} $(apt-cache show $1 | grep Version)"
    shift
  done
}


init(){
  [ -f ".config" ] && . .config
  if [ ! -f ".config" ] || test `expr $(date +%s) - $config_lastupdate` -gt 86400; then
    ./xsetup.sh
    . .config || doErr 'Unable to initialize config file'
  fi
  export is_init=true indent=0 ind
}

! $is_init && init

inc_tab

main(){
  $debug && set -x
  # exit if missing vars lib arch or src
  test -z ${lib} && {
    echo -e "\n\n${ind}${CB1}${ind}Toolchain is loadad.\n${ind}Now exiting...\n\n${C0}"
    indent=0
    return 0
  }

  test -z $LIBSDIR || test -z $src && errCall

  #[ -z "${cmake_toolchain_file}" ] && 
  logtime_start=0
  logtime_end=0

  PKGDIST="${ROOTDIR}/dist/${lib}"
  INSTALL_DIR=$LIBSDIR

  SOURCES=$ROOTDIR/sources
  SRCDIR=$SOURCES/$lib
  PKGDIR=$INSTALL_DIR/lib/pkgconfig
  
  export PKGDIST LIBSDIR SOURCES SRCDIR INSTALL_DIR PKGDIR
  [ -d "${SOURCES}" ] || mkdir -p ${SOURCES}

  gitjson=$(git_api_tojson $src)
  if [ -n "${gitjson}" ];then
    [ -z "${lic}" ] && lic=$(echo "$gitjson" | jq .licence)
    [ -z "${dsc}" ] && dsc=$(echo "$gitjson" | jq .description)
  fi
  # show package info
  [ ! -f "${PKGDIR}/${pkg}.pc" ] && ${banner} && pkgInfo

  LOGFILE=$LIBSDIR/${lib}.log
}

# Variables
# mki: rule for install 'make $mkinstall' (default: install)
# mkc: rule for clean 'make $mkclean' (default: clean)
# mkf: additional rule for make
# no_host  : while using autotools, no host will be set for cross-compile if no_host is not empty

gitjson=

start(){
  
  # check whether to update source of main lib and dependencies
  if $update; then
    rm -rf "${SOURCES}/${lib}"
    ! $req_update_deps && update=false
  else
    [ -f "${PKGDIR}/${pkg}.pc" ] && exit
  fi
  
  # Reset LOGFILE
  [ -f "${LOGFILE}" ] && rm -f $LOGFILE

  # Create INSTALL_DIR and PKGCONFIG DIR
  mkdir -p $PKGDIR
  export PKG_CONFIG_LIBDIR="$PKGDIR:$PKG_CONFIG_LIBDIR"

  check_tools $tls
  pushvar_f old_vrs $vrs
  build_dependencies $dep
  vrs=$(popvar_f old_vrs)

  log_start $arch ${eta}s
  local bss=
  $build_static && bss="${SSB}[static]" || bss="${CD}[static]"
  $build_shared && bss="${bss}${SSB}[shared]" || bss="${bss}${CD}[shared]"
  $build_bin && echo -ne "${bss}${SSB}[bin]${C0} " || echo -ne "${bss}${CD}[bin]${C0} "
  cd $SOURCES

  ! $retry && [ "${BUILD_DIR}" != "$SRCDIR" ] && rm -rf ${BUILD_DIR}
  
  # deprecated
  [ -z ${CONFIG_DIR+x} ] && CONFIG_DIR=${SRCDIR}
  # use this instead
  [ -n "${dir_config+x}" ] && CONFIG_DIR="${SOURCES}/${lib}/${dir_config}"


  if [ ! -d $SRCDIR ];then
    
    # check whether to custom get source
    if ifdef_function 'source_get'; then
      source_get
    else
      case $sty in
        git) git_clone $src $lib;;
        tgz|txz|tlz) wget_tarxx $src $lib;;
        svn) do_svn $src $lib;;
        hg) do_hg $src $lib;;
        *) case $src in
            *.tar.*) wget_tarxx $src $lib;;
            *.git)   do_git $src $lib;;
            *svn.*)  do_svn $src $lib;;
            *) doErr "unknown sty=$sty for $src";;
          esac
          ;;
      esac
    fi

    pushdir $CONFIG_DIR

    # check whether to custom config source
    if ifdef_function 'source_config'; then
      doLog 'config' source_config
    elif [ -n "$automake_cmd" ];then
      doLog 'automake' $automake_cmd
      unset automake_cmd
    else case $cfg in
      ag) doAutogen $CONFIG_DIR --noconfigure;;
      ar) doAutoreconf $CONFIG_DIR;;
      am|autom*)
        if [ ! -f "${CONFIG_DIR}/configure" ];then
          if [ -f "${CONFIG_DIR}/autogen.sh" ];then
            doAutogen $CONFIG_DIR --noconfigure
          else
            doAutoreconf $CONFIG_DIR
          fi
        fi
        ;;
      esac
    fi

    # check whether to auto patch source
    check_xbautopatch

    # check whether to custom patch source
    if ifdef_function 'source_patch'; then
      doLog 'patch' source_patch
    fi
  fi

  $only_repo && end_script

  if [ -z "$BUILD_DIR" ];then
    case $build_tool in
      cmake|meson) BUILD_DIR="${CONFIG_DIR}/build_${arch}"
        [ -d "${BUILD_DIR}" ] && rm -rf ${BUILD_DIR}
        mkdir -p ${BUILD_DIR}
        ;;
      *) BUILD_DIR=${CONFIG_DIR};;
    esac
  fi
  
  popdir; pushdir ${BUILD_DIR}

  log_vars SRCDIR dep PKG_CONFIG_LIBDIR
  log_vars CFLAGS CXXFLAGS CPPFLAGS LDFLAGS LIBS
  log_vars CC CXX LD AS AR NM RANLIB STRIP
  
  ifdef_function 'build_all' && {
    build_all
    end_script
  }

  ifdef_function 'build_prepare' && build_prepare

  ifdef_function 'build_clean' && build_clean || {
    [ -z "$mkc" ] && mkc="clean"
    [ -f "Makefile" ] && doLogNoErr 'clean' ${MAKE_EXECUTABLE} $mkc
  }
  
  if ifdef_function 'build_config'; then
    build_config
  else
    case $build_tool in
      cmake)
        [ -z "$exec_config" ] && exec_config=${CMAKE_EXECUTABLE}
        [ -z "$cmake_toolchain_file" ] && cmake_create_toolchain ${BUILD_DIR}
        [ -f "$cmake_toolchain_file" ] && CFG="-DCMAKE_TOOLCHAIN_FILE=${cmake_toolchain_file} $CFG"
        doLog 'cmake' $exec_config ${CONFIG_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DCMAKE_BUILD_TYPE=$cmake_build_type ${CFG} ${CSH} ${CBN}
        case $cfg in ccm|ccmake) tput sc; ccmake ..; tput rc;; esac
        MAKE_EXECUTABLE=make
        ;;
      automake)
        [ -z "${mki+x}" ] && mki="install-strip"
        [ -z "${mkc+x}" ] && mkc="distclean"
        [ -z "$exec_config" ] && exec_config='configure' # default config executable
        ! $ac_nohost && [ "$arch" != "${build_arch}" ] && CFG+=" --host=${arch}"
        ! $ac_nosysroot && CFG+=" --with-sysroot=${SYSROOT}"
        ! $ac_nopic && CFG+=" --with-pic=1"
        doLog 'configure' ${CONFIG_DIR}/${exec_config} --prefix=${INSTALL_DIR} $CFG $CSH $CBN
        MAKE_EXECUTABLE=make
        ;;
      meson)
        local MESON_EXEC=$(check_tool_dependency meson)
        [ -z "$MESON_EXEC" ] && doErr 'Could not install meson. Aborting.'
        local MESON_CFG="$SRCDIR/${arch}.meson"
        [ -f "$MESON_CFG" ] && rm $MESON_CFG
        meson_create_toolchain $MESON_CFG
        MAKE_EXECUTABLE=ninja
        doLog 'meson' ${MESON_EXEC} setup --buildtype=release --cross-file=${MESON_CFG} --prefix=${INSTALL_DIR} $CFG $CSH $CBN
        ;;
      make)
        mkf=$CFG
        MAKE_EXECUTABLE=make
        ;;
      *)
        doErr "No cfg found or unknown for $cfg. Use build_config to custom configure makefile"
        ;;
    esac
  fi

  ifdef_function 'build_patch_config' && doLog 'patch' build_patch_config

  case $CC in *clang) $build_static && pushvar_f LDFLAGS "-all-static";; esac
  # set -all-static flags at make time (see: https://stackoverflow.com/questions/20068947/how-to-static-link-linux-software-that-uses-configure)
  # $build_static && [[ "$LDFLAGS" != *"-all-static"* ]] && LDFLAGS="-all-static $LDFLAGS"
  

  ifdef_function 'build_make' && doLog 'make' build_make || doLogP 'make' ${MAKE_EXECUTABLE} $mkf -j${HOST_NPROC} || err

  ifdef_function 'patch_install' && patch_install

  [ -z "${mki}" ] && mki="install"
  ifdef_function 'build_install' && doLog 'install' build_install || doLog 'install' ${MAKE_EXECUTABLE} ${mki}

  # check whether to create pkg-config .pc file
  if [ -n "${req_pcforlibs+x}" ];then
    local pcf
    for l in $req_pcforlibs; do
      pcf=$(echo $l | sed 's|^lib||')
      create_pkgconfig_file $pcf "-l$pcf"
    done
  else
    ifdef_function 'build_pkgconfig_file' && \
    doLog 'pkgcfg' build_pkgconfig_file || \
    [ -n "$pc_llib" ] && \
    doLog 'write_pc' create_pkgconfig_file $pkg $pc_llib
  fi

  # create package
  $build_package && doLog 'tar' build_packages_bin

  popdir

  logver "$PKGDIR/${pkg}.pc"

  ifdef_function 'on_end' && on_end

  #stat_savestats
  end_script
}

end_script(){
  log_end
  # check if parent process is shell script
  local parent=$(ps -o comm= $PPID)
  [ "${parent: -3}" == ".sh" ] || echo -e "\n${ind}${CT1}::Done${C0}\n"
  $debug && set +x
  unset CONFIG_DIR CSH CBN exec_config vrs ac_nohost ac_nopic ac_nosysroot req_pcforlibs mkc mki
  dec_tab
  echo
  exit 0
}

check_xbautopatch(){
  pushdir $ROOTDIR
  local match=$(grep -oP "(?<=^<<').*?(?=')" $0)
  [ -z "$match" ] && return 0
  local block=$(awk '/^<<.'"$match"'./{flag=1; next} /^'"$match"'/{flag=0} flag' $0)
  echo -e "\npatch this: \n$block" >>$LOGFILE
  case $match in
    XB_CREATE_CMAKELISTS) echo "${block}" >$SRCDIR/CMakeLists.txt;;
    XB_PATCH_CMAKELISTS) pushdir $SRCDIR; patch -p0 <<<$(echo "${block}") 2>&1 >$LOGFILE; popdir;;
  esac
  popdir
}

# usage create_pkgconfig_file <pkg>.pc [llibds][INSTALL_DIR]
create_pkgconfig_file(){
    [ -z "${1}" ] && pc_file=${lib} || pc_file=${1}
    [ -z "${2}" ] && pc_llib="-l${pc_file}" || pc_llib=${2}
    [ -z "${3}" ] && pc_prefix=${INSTALL_DIR} || pc_prefix=${3}
    [ -z "$pc_libdir" ] && pc_libdir="/lib"
    [ -z "$pc_incdir" ] && pc_incdir="/include"
    [ -z "$pc_cflags" ] && pc_cflags="-I\${includedir}"
    [ -z "$pc_libs" ] && pc_libs="-L\${libdir}"
    [ -z "$pc_url" ] && pc_url=$(dirname $src)
    [ -z "$pc_vrs" ] && {
      [ -d "${SRCDIR}/.git" ] && pc_vrs=$(git_getversion ${SRCDIR}) || pc_vrs=$vrs
    }
    cat <<-EOF >$PKGDIR/${pc_file}.pc
		prefix=${pc_prefix}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}${pc_libdir}
		includedir=\${prefix}${pc_incdir}

		Name: ${lib}
		Description: ${dsc}
		URL: ${pc_url}
		Version: ${pc_vrs}
		Requires: ${pc_requires}
		Requires.private: ${pc_requiresprivate}
		Libs: ${pc_libs} ${pc_llib}
		Libs.private: ${pc_libsprivate}
		Cflags: ${pc_cflags}
  
		EOF
    pc_filelist="${pc_file}.pc ${pc_filelist}"
    unset pc_libdir pc_incdir pc_cflags pc_libs pc_url
}

build_packages_getdistdir(){
  [ -f "$PKGDIR/${pkg}.pc" ] && vrs=$(pkg-config $PKGDIR/${pkg}.pc --modversion)
  [ -z "$vrs" ] && set_git_version
  echo "${ROOTDIR}/packages/${lib}-${vrs}-${arch}"
}

build_packages_filelist(){
  local scfile="${ROOTDIR}/${lib}.sh"
  if [ -z "$(cat $scfile | grep '# Filelist')" ]; then
    echo -e "\n\n# Filelist\n# --------" >> $scfile
    find ./ -type f | sed 's|^./|# |g' >> $scfile
  fi
}

build_packages_bin(){
  local xb_distdir=$(build_packages_getdistdir)
  if [ "$(type -t create_package)" = 'function' ]; then
    create_package $xb_distdir
  else
    if [ "$(type -t build_make_package)" = 'function' ]; then
      build_make_package $xb_distdir
    elif [ "$MAKE_EXECUTABLE" = "ninja" ];then
      DESTDIR=${xb_distdir} ninja -C ${BUILD_DIR} install
    else
      [ -z "$mkd" ] && mkd="DESTDIR=${xb_distdir} install"
      ${MAKE_EXECUTABLE} $mkd
    fi
    [ -z "$mkd_suffix" ] && mkd_suffix=${LIBSDIR}
    pushdir "${xb_distdir}${mkd_suffix}"
    
    # also include .pc manually-built file
    if [ "$(type -t build_pkgconfig_file)" = 'function' ] || [ -n "$pc_llib" ];then
      local xb_pkgd=$(pwd)/lib/pkgconfig
      [ ! -d "${xb_pkgd}" ] && mkdir -p $xb_pkgd
      if [ -n "${pc_filelist}" ];then
        for pp in ${pc_filelist}; do
          cp $PKGDIR/${pp} ${xb_pkgd}/
        done
      else
        cp $PKGDIR/${pkg}.pc ${xb_pkgd}/
      fi
    fi
    build_packages_filelist
    tar -czvf "${xb_distdir}.tar.gz" *
    rm -rf ${xb_distdir}
    popdir
  fi
}

dep_add(){
  while [ -n "$1" ]; do
    # doesnt work: str_contains $dep $1 || pushvar_f dep $1
    [[ "$dep" == *"$1"* ]] || dep="$1 $dep" # bash
    shift
  done
}

build_dependencies(){
  local pkgfile=
  local o_csh
  local o_cbh
  local cf
  local ldir
  local args
  $build_shared && args="--shared"
  $build_bin && args="$args --bin"
  while [ -n "${1}" ]; do
    [ -f "./${1}.sh" ] || doErr "no script file ${1}.sh.\n  Aborting..."
    pkgfile=$(./${1}.sh ${arch} --get pc)
    libname=$(./${1}.sh --get libname)
    if [ ! -f "${pkgfile}" ]; then
      o_csh=$CSH
      o_cbh=$CBH
      unset CSH CBH
      ./${1}.sh ${arch} ${args} || err
      CSH=$o_csh
      CBH=$o_cbh
    fi
    if [ -f "${pkgfile}" ]; then
      local cmi=$(./${1}.sh ${arch} --get cmake_include)
      [ -n "$cmi" ] && pushvar_f cmake_includes $cmi
      ldir="$(dirname ${pkgfile})"
      str_contains $PKG_CONFIG_LIBDIR ${ldir} || PKG_CONFIG_LIBDIR="${ldir}:${PKG_CONFIG_LIBDIR}"
    fi
    shift
  done
}

#usage: meson_create_toolchain <out.meson.file>
meson_create_toolchain(){
  case $arch in
    aarch*)  cpu1="aarch64" cpu2="aarch64";;
    arm*)    cpu1="arm"     cpu2="arm";;
    i686*)   cpu1="x86"     cpu2="i686";;
    x86_64*) cpu1="x86_64"  cpu2="x86_64";;
  esac
  cmake_create_toolchain ${BUILD_DIR}
  cat <<-EOF >${1}
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
  cmake_toolchain_file = '${cmake_toolchain_file}'
  
  [host_machine]
  system = '$(str_lowercase ${PLATFORM})'
  cpu_family = '${cpu1}'
  endian = 'little'
  cpu = '${cpu2}'

  [target_machine]
  system = '$(str_lowercase ${PLATFORM})'
  cpu_family = '${cpu1}'
  endian = 'little'
  cpu = '${cpu2}'
	EOF
  echo "\nMeson file:(${1})\n\n" >>${LOGFILE} 2>&1
  cat ${1} >>${LOGFILE} 2>&1
}

cmake_include_directories(){
  printf "include_directories($@)" >> $cmake_toolchain_file
}


# usage cmake_create_toolchain <dir>
cmake_create_toolchain(){
  export cmake_toolchain_file="${ROOTDIR}/xbuilder.cmake"
}

cargo_create_toolchain(){
  cat <<-EOF >>cargo-config.toml
  [target.aarch64-linux-android]
  ar = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
  linker = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android${API}-clang"

  [target.arm-linux-androideabi]
  ar = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
  linker = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/armv7a-linux-androideabi${API}-clang"

  [target.i686-linux-android]
  ar = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
  linker = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/i686-linux-android${API}-clang"

  [target.x86_64-linux-android]
  ar = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-ar"
  linker = "${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/bin/x86_64-linux-android${API}-clang"
	EOF
}

# usage: check_tool_dependency <exe-name> <pkg-name>. returns path of exe-name
check_tool_dependency(){
  local nm
  local pk
  if [ -n "$1" ];then
    nm=$1
    [ -n "$2" ] && pk=$2 || pk=$1
    [ -z $(which $nm) ] && aptInstall $pk
    nm=$(which $nm)
  fi
  echo $nm
}


check_tools(){
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

# usage: chkTools tools...
chkAutotools(){
  if [ -z $(which automake) ];then
    tput sc
    $sudo apt -qq install automake autogen autoconf m4 libtool-bin -y >/dev/null 2>&1 
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
  [ $(($1/60%60)) -eq 0 ] && printf '%ds' $(($1%60)) || printf '%dm %ds' $(($1/60%60)) $(($1%60))
  
}

log_start(){
  logtime_start=$(date +%s)
  #echo -ne "$CC1  $@: "
  echo -ne "${C0}${ind}$(date '+%H:%M')"
  [ $eta ] && echo -ne "-${CW}$(date '+%H:%M' --date="$eta seconds")"
  printf " ${CT1}%-10s ${CT1}%-21s${CD} " ${lib} ${arch}
}

log_end(){
  logtime_end=$(date +%s)
  #local pkgsize=$(du -sk ${INSTALL_DIR} | cut -f1)
  #local libsize=$(du -sk ${INSTALL_DIR}/lib | cut -f1)
  local secs=$(($logtime_end-$logtime_start))
  local msg="${CT1} done ${CD}in $(secs2time ${secs})"
  [ $secs -gt 60 ] && msg="$msg (${secs}s)"
  #echo -e "$msg pkg/lib: ${pkgsize}/${libsize}kb${C0}"
  echo -e "$msg"
}

log(){
  echo -ne "$CD$@$C0"
}

log_vars(){
  while [ -n "$1" ]; do
    echo "$1=${!1}" >>$LOGFILE 2>&1
    shift
  done
  echo >>$LOGFILE
}

doErr(){
  echo -e "${CR1}  Error: ${CR0}${1}${C0}\n\n"
  if [ -f $LOGFILE ];then
    if [ -f ${BUILD_DIR}/CMakeFiles/CMakeError.log ];then
      echo -e "\n\n${BUILD_DIR}/CMakeFiles/CMakeError.log:\n" >> $LOGFILE
      cat ${BUILD_DIR}/CMakeFiles/CMakeError.log >> $LOGFILE
    fi
    echo -ne "${CY1}${ind}Open log? [Y|n]:${C0}" && read openlog
    [ "$openlog" != "n" ] && nano $LOGFILE
  fi
  exit 1
}

err(){
  logtime_end=$(date +%s)
  echo -e "${CR1} fail ${CR0}[$(secs2time $(($logtime_end-$logtime_start)))]${C0}\n"
  if [ -f $LOGFILE ];then
    if [ -f ${BUILD_DIR}/CMakeFiles/CMakeError.log ];then
      echo -e "\n\n${BUILD_DIR}/CMakeFiles/CMakeError.log:\n" >> $LOGFILE
      cat ${BUILD_DIR}/CMakeFiles/CMakeError.log >> $LOGFILE
    fi
    echo -ne "${CY1}${ind}Open log? [Y|n]:${C0}" && read openlog
    [ "$openlog" != "n" ] && nano $LOGFILE
  fi
  echo
  exit 1
}

log_this() {
  echo -e "\n$(date +"%T"): $@" >> "$LOGFILE"
  "$@" 2>> "$LOGFILE" 1>> "$LOGFILE" || err
  logok
}

doLogNoErr(){
  local var=$1; shift
  echo -ne "${CD}${var}${C0}"
  echo -e "\n$(date +"%T"): $@" >> "$LOGFILE"
  "$@" 2>> "$LOGFILE" 1>> "$LOGFILE"
  logok $var
}

doLog() {
  local var=$1; shift
  echo -ne "${CD}${var}${C0}"
  log_this $@
  logok $var
}

doLogP() {
  local var=$1; shift
  echo -ne "${CD}${var}"
  echo -e "\n$(date +"%T"): $@" >> "$LOGFILE"
  ("$@" |& tee -a $LOGFILE | topct) || doErr "in ${var}:\n\n...\n$(tail -n5 $LOGFILE)${C0}"
  logok $var
}

logok() {
  echo -ne "\e[${#1}D${CT0}${1}${C0} "
}

# usage logver /path/to/pkgconfigfile.pc
logver() {
  if [ -f $1 ];then
    echo -ne "${CT1}version $(pkg-config --modversion $1)${C0}"
  else
    echo -ne "${CS0} missing ${1} ${C0}"
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

# usage: do_git giturl [libname]
do_git(){
  doLog 'git' git clone $1 $2
  [ -n "${vrs}" ] && {
    cd $2
    doLog ${vrs} git checkout tags/${vrs}
    cd ..
  }
}

topct(){
  printf "%-6s"
  local sln
  while read -r ln; do
    str_contains $ln 'error: ' && printf $CR1
    sln=$(grep -oP '\d+%' <<< $ln)
    [ -n "$sln" ] && printf "\e[5D%-5s" $sln
  done
  printf "\e[6D"
}

git_clone(){
  local var="git"
  echo -ne "${CD}${var}"
  git clone --progress --verbose $1 $2 $src_opt|& tr '\r' '\n' | topct
  logok $var
  [ -d "$2" ] && cd $2 || err
  $nodev && vrs=$(git describe --abbrev=0 --tags)
  if [ -n "${vrs}" ];then
    doLog ${vrs} git checkout tags/${vrs};
  fi
  cd ..
}

do_svn(){
  [ $(which svn) ] || aptInstall subversion || err
  local var="svn"
  echo -ne "${CD}${var}"
  svn checkout $1 $2 >/dev/null || err
  logok $var
}

do_hg(){
  [ $(which hg) ] || aptInstall mercurial || err
  doLog 'clone' hg clone $1 $2
}

set_git_version(){
  pushdir $SRCDIR
  local v=$(git describe --abbrev=0 --tags 2>/dev/null)
  [ -n "$v" ] && export vrs=$v
  popdir
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
      local v=$(git_remote_version $src)
      echo "$dst/-/archive/${v}/${lib}-${v}.tar.gz"
      ;;
    *.googlesource.*)
      local tag=$(git -c 'versionsort.suffix=-' ls-remote --refs --sort='v:refname' $src | tail -n1 | cut -f1)
      echo "$src/+archive/${tag}.tar.gz"
      ;;
    esac
}

# usage: wget_tarxx type url libname
wget_tarxx(){
  local tag="get"
  local args=
  echo -ne "${CD}${tag}${C0}"
  echo "$(date): $@" >> "$LOGFILE"
  
  case $src in
    *.tar.lz) 
      test -z $(which lzip) && aptInstall lzip
      ags="--lzip -xv"
      ;;
    *.tar.gz|*.tgz) args="-xvz";;
    *.tar.xz) args="-xvJ";;
  esac

  [ -d "tmp" ] && rm -rf tmp
  mkdir tmp
  wget -qO- $1 2>>$LOGFILE | tar --transform 's/^dbt2-0.37.50.3/dbt2/' $args -C tmp >/dev/null 2>&1 || err
  cd tmp
  mv * $2 && mv $2 ..
  cd ..
  rm -rf tmp
  
  #if [ ! -f "${2}" ];then
  #  local fname=$(basename $src | sed -E 's/[0-9\.-_].*//')
  #  mv ${fname}* $2
  #fi
  logok $tag
}

wget_tar(){
  local tag="source"
  local args=
  echo -ne "${CD}${tag}${C0}"
  echo -e "\n\n$@\n----------------------------------------\n" >> "$LOGFILE"
  echo "$(date): $@" >> "$LOGFILE"
  case $sty in
    tlz|tar_lz) 
      test -z $(which lzip) && aptInstall lzip
      ags="--lzip -xv"
      ;;
    tgz|tar_gz) args="-xvz";;
    txz|tar_xz) args="-xvJ";;
  esac
  wget -qO- $src 2>>$LOGFILE | tar --transform 's/^dbt2-0.37.50.3/dbt2/' $args >/dev/null 2>&1 || err
  mv ${1}* ${lib}
  echo -e "----------------------------------------\n" >> "$LOGFILE"
  logok $tag
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
  pushdir $1
  make clean
  popdir
}

clean(){
  echo -ne "${CT0}\n\tcleaning...\n"
  rm -rf builds/$arch/$lib builds/$arch/$lib.log
  pushdir sources/$lib
  [ -f Makefile ] && make clean
  popdir
  echo -e "$C0\tdone"
  clear
}

cmakeClean(){
  pushdir $1
  rm -rf CMakeFiles CMakeCache.txt
  popdir
}

showOpts(){
  if [ -d "$1" ] && [ -n "$lib" ];then
    local bdir=$(pwd)/builds
    pushd $1>/dev/null
    [ -f CMakeLists.txt ] && cmake -LA | awk '{if(f)print} /-- Cache values/{f=1}' >${bdir}/${lib}_cmake.opts && nano "${bdir}/${lib}_cmake.opts"
    [ -f configure ] && ./configure --help >${bdir}/${lib}_aconf.opts && nano "${bdir}/${lib}_aconf.opts"
    popdir
  else
    echo -e "${ind}${CR0}no configuration file found in ${CR1}$1${CD}\n\n"
  fi
}

setCMake(){
  printf "SET($2 $3)\n\n" >> $1
}

doAutogen(){
  [ $1 ] || doErr "missing arg in doAutogen: usage doAutogen <AUTOGEN_DIR>"
  local var="autogen"
  echo -ne "${CD}${var}${C0}"
  pushdir $1
  shift
  case $1 in
    --noerr ) ./autogen.sh >>$LOGFILE 2>&1;;
    --noconfigure ) NOCONFIGURE=1 log_this ./autogen.sh;;
    * ) log_this ./autogen.sh;;
  esac
  popdir
  logok $var
}

doAutoreconf(){
  local var="autoreconf"
  echo -ne "${CD}${var}${C0}"
  pushdir $1
  log_this autoreconf -fi
  popdir
  logok $var
}

checkUrl(){
  wget -S --spider $1 2>&1 | grep -q "HTTP/1.[0-9] 200 OK" && echo SUCCESS || echo FAIL
}

checkCmd(){
  [ -z "$(which $1)"] $sudo apt -qq install $1 -y >/dev/null 2>&1
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

patch_ndk_libpthread(){
  if [ "${host_os}" == "android" ]; then
    # NDK Patch: create missing libpthread in NDK
	  local lpthread="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${arch}/libpthread.a"
	  [ ! -f $lpthread ] && ${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64//bin/llvm-ar cr $lpthread
  fi
}

patch_ndk_librt(){
  if [ "${host_os}" == "android" ]; then
    # NDK Patch: create missing librt in NDK
    local lrt="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${arch}/librt.a"
    [ ! -f $lrt ] && ${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64//bin/llvm-ar cr $lrt
  fi
}

# usage: patch_zlib_createpc <sysroot-prefix>
_patch_zlib_createpc(){
  [ -d "$LIBSDIR/lib/pkgconfig" ] && mkdir -p "$LIBSDIR/lib/pkgconfig"
  cat <<-EOF >$LIBSDIR/lib/pkgconfig/zlib.pc
  prefix=${1}
  libdir=\${prefix}/lib/${arch}
  includedir=\${prefix}/include

  Name: zlib
  Description: zlib compression library
  Version: 1.2.11
  Libs: -L\${libdir} -lz
  Cflags: -I\${includedir}
	EOF
}


aptInstall(){
  while [ "$1" != "" ];do
    #echo -ne "  ${CT0}install $1${C0}"
    #echo -n " "
    stty size | {
      read y x
      echo -ne "${CY1}"
      tput sc
      tput cup "$((y - 1))" 0
      $sudo apt -qq install $1 -y >/dev/null 2>&1
      echo -ne "${C0}"
      tput rc
    }
    #echo -ne "${C0} ok"
    shift
  done
}

set_ndk_api(){
  API=${1}
  loadToolchain
}

loadToolchain(){

  CMAKE_EXECUTABLE=cmake
  YASM=yasm
  PKG_CONFIG=pkg-config
  #reset flags
  unset LIBS CPPFLAGS CFLAGS CXXFLAGS LDFLAGS
  CPPFLAGS="-I$LIBSDIR/include"
  LDFLAGS="-L$LIBSDIR/lib"

  case $PLATFORM in
    Android)
      [ -z "$API" ] && API=24
      CMAKE_TOOLCHAIN="${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake"
      TOOLCHAIN="${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64"
      SYSROOT="${TOOLCHAIN}/sysroot"
      CROSS_PREFIX="${TOOLCHAIN}/bin/${arch}-"
      
      local ndk_cc_prefix=${arch}${API}
      [ -n "$host_eabi" ] && ndk_cc_prefix="armv7a-linux-androideabi${API}"
      CC="${TOOLCHAIN}/bin/${ndk_cc_prefix}-clang"
      CXX="${CC}++"
      AS="${CC}" #AS see https://developer.android.com/ndk/guides/other_build_systems
      LD="${TOOLCHAIN}/bin/ld.lld" #Linker (also llvm-link?)
      GCOV="${TOOLCHAIN}/bin/llvm-cov" # should we disable this?
      # change cross_prefix for bin tools in ndk > r23
      [ ! -f "${CROSS_PREFIX}ar" ] && CROSS_PREFIX="${TOOLCHAIN}/bin/llvm-"
      LT_SYS_LIBRARY_PATH="$SYSROOT/usr/lib/$arch:$SYSROOT/usr/lib/${arch}/${API}"
      if $build_shared;then
        LDFLAGS="-Wl,-rpath,${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      else
        LDFLAGS="-L${SYSROOT}/usr/lib/${arch} -L${SYSROOT}/usr/lib/${arch}/${API} ${LDFLAGS}"
      fi

      ${ndkcmake} && [ -d "${ANDROID_HOME}/cmake" ] && CMAKE_EXECUTABLE="${ANDROID_HOME}/cmake/3.10.2.4988404/bin/cmake"
      YASM=${TOOLCHAIN}/bin/yasm
      #PKG_CONFIG_LIBDIR=${ANDROID_NDK_HOME}/pkgconfig
      #[ ! -f "$LIBSDIR/lib/pkgconfig/zlib.pc" ] && patch_zlib_createpc "${SYSROOT}/usr"
      ;;
    Linux)
      local cross
      local ltsdir
      case $arch in
        aarch64-*) cross="-cross" ltsdir=$xv_aarch64_gnu;;
        arm-*)     cross="-cross" ltsdir=$xv_armeabi_gnu;;
        i686-*)    cross="-cross" ltsdir=$xv_x86_gnu;;
        x86_64-*)  cross= ltsdir=$xv_x64_gnu;;
      esac
      if [ -n "$cross" ];then
        SYSROOT="/usr/${arch}"
        TOOLCHAIN="/usr/${arch}/bin"
        CROSS_PREFIX="${arch}-"
      else
        TOOLCHAIN="/usr"
        unset CROSS_PREFIX
        unset SYSROOT
      fi
      CC=${CROSS_PREFIX}gcc
      CXX=${CROSS_PREFIX}g++
      AS=${CROSS_PREFIX}as
      LD=${CROSS_PREFIX}ld
      # local ltsdir=$(ls -t /usr/lib/gcc${cross}/${arch} 2>/dev/null | head -n1)
      [ -n "$ltsdir" ] && LT_SYS_LIBRARY_PATH="/usr/lib/gcc${cross}/${arch}/${ltsdir}"
      LDFLAGS="-L${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      ;;
    Windows)
      local ltsdir
      PLATFORM='Windows'
      if [ -n "${LLVM_MINGW_HOME}" ] && $use_llvm_mingw; then
        TOOLCHAIN="${LLVM_MINGW_HOME}/bin"
        SYSROOT="${LLVM_MINGW_HOME}/${arch}"
        CROSS_PREFIX="${TOOLCHAIN}/${arch}-"
        $use_clang && {
          CC="${CROSS_PREFIX}clang" CXX="${CC}++"
        } || {
          CC="${CROSS_PREFIX}gcc" CXX="${CROSS_PREFIX}g++"
        }
        LT_SYS_LIBRARY_PATH="${LLVM_MINGW_HOME}/lib/clang/${xv_llvm_mingw}"
        CPPFLAGS+=" -I$LT_SYS_LIBRARY_PATH/include"
        LDFLAGS="-L${LT_SYS_LIBRARY_PATH}/lib -L${SYSROOT}/lib ${LDFLAGS}"
      else
        CROSS_PREFIX="${arch}-"
        TOOLCHAIN="/usr/${arch}/bin"
        SYSROOT="/usr/${arch}"
        $f_win_posix && posix="-posix" || unset posix
        CC="${CROSS_PREFIX}gcc${posix}"
        CXX="${CROSS_PREFIX}g++${posix}"
        LT_SYS_LIBRARY_PATH="/usr/lib/gcc/${arch}/${xv_x64_mingw}"
        LDFLAGS="-L${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      fi
      LD="${CROSS_PREFIX}ld" AS="${CROSS_PREFIX}as"
      
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
  [ -z ${GCOV+x} ] && GCOV=${CROSS_PREFIX}gcov

  pushvar_f CPPFLAGS "-I$SYSROOT/usr/include -I$SYSROOT/usr/local/include"
  #pushvar_f CFLAGS "-I$SYSROOT/usr/include -I$SYSROOT/usr/local/include"
  #pushvar_f CXXFLAGS "-I$SYSROOT/usr/include -I$SYSROOT/usr/local/include"

  # export
  export CMAKE_EXECUTABLE YASM PKG_CONFIG API \
    PLATFORM TOOLCHAIN SYSROOT CC CXX LD AS \
    ADDR2LINE AR NM OBJCOPY OBJDUMP RANLIB \
    READELF SIZE STRINGS STRIP WINDRES \
    CROSS_PREFIX LT_SYS_LIBRARY_PATH CPPFLAGS LDFLAGS
}

getMinGwVersion(){
  echo $(x86_64-w64-mingw32-gcc --version | head -n1 | grep -Eo "(GCC).+-win32" | sed 's|GCC) \(.*\)-win32|\1|')
}

errUnknownTarget(){
  if [ $arch ];then
    echo -e "\n${ind}${CR1}unknown target ${arch}${C0}\n" && exit 1
  else
    echo -e "\n${ind}${CR1}must specify a target${C0}\n" && usage && exit 1
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
}

pkgInfo(){
  local DP=
  local VS=
  local longdesc=$(aptLongDesc)
  [ -n "$tls" ] && DP="${CT0}tools: ${C0}$tls "
  [ -n "$dep" ] && DP="${DP}${CT0}dependencies: ${C0}$dep"
  if [ "$sty" == "git" ];then
    local vgit=$(git_remote_version $src)
    if [ -d $SRCDIR ];then
      set_git_version
      VS="${CT0}vrs: ${C0}$vrs "
      str_contains $vgit $vrs && \
        pushvar_l VS 'updated' || \
        pushvar_l VS "$VS ${CT0}latest: ${CT1}${vgit}${C0}"
    else
      VS="${CT0}vrs: ${C0}${vgit}"
    fi
  fi
  echo -e "\n${CW}${ind}${lib^^} - ${C0}${dsc}"
  [ -n "${longdesc}" ] && echo -e "${CD}${longdesc}" | sed 's|\*|\u2605|g; s|\..\..|. |g' # sed 's|^|'${ind}|g'
  echo -e "${CT0}${ind}Licence ${C0}$lic ${DP} ${VS}"
}

aptLongDesc(){
  [ -n "$apt" ] && echo -e $(apt-cache show ${apt} 2>/dev/null | \
    grep -E "Description-..^|^ " | \
    sed $'s/\*/\u2605/g' | \
    sed '/^ *This package contains.*\./d') | fold -s -w120 | sed 's/^/'"${ind}"'/g'
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
    ${CB1}--api n   ${C0}\tset api level <n>
    ${CB1}--stable  ${C0}\tuse git stable branch\n
    ${CM1}<builder-options>
    ${CM1}--cmake   ${C0}\tforce cmake build when available
    ${CM1}--ndkcmake${C0}\tuse android ndk cmake 3.10.2 instead
    ${CM1}--ccmake  ${C0}\tforce cmake + gui ccmake when available
    ${CM1}--vrep    ${C0}\tget repository version
    ${CM1}--checkPkg${C0}\tget pkgconfig file's path\n
    ${CM0}<other-options>
    ${CM0}--get <o> ${C0}\tdelete all (builds + sources)
    ${CM0}   cflags ${C0}\tpkgconfig cflags
    ${CM0}   libs   ${C0}\tpkgconfig link flags
    ${CM0}   ldstatic${C0}\tpkgconfigstatic link flags
    ${CM0}   pc-ver ${C0}\tpkgconfig lib version
    ${CM0}   pc-path${C0}\tpkgconfig.pc file path
    ${CM0}   pc-name${C0}\tfilename (without .pc)
    ${CM0}   prefix ${C0}\tinstall prefix path
    ${CM0}   libname${C0}\tlib name
    ${CM0}   aptname${C0}\tdebian package name for lib
    ${CM0}--wipeall ${C0}\tdelete all (builds + sources)
    ${CM0}--update  ${C0}\tforce source update/download (git/svn/etc)
    ${CM0}--rebuild ${C0}\tforce remake project
    ${CM0}--retry   ${C0}\tretry build without clear cache
    ${CM0}--clean   ${C0}\tclean up last build
    ${CM0}--clearsrc${C0}\tdelete source
    ${CM0}--opts    ${C0}\tshow available configuration options/flags
    ${CM0}--nobanner${C0}\tdon't show banner/packageinfo\n\n
EOF
)" 
}

hwinfoCountCores(){
  cat /proc/cpuinfo | grep -Po -c 'model name\s+: \K(.*)'
}

hwinfoCountCoresReadable(){
  case $(nproc) in
    "1") echo "Single-Core";;
    "2") echo "Dual-Core";;
    "4") echo "Quad-Core";;
    "6") echo "Hexa-Core";;
    "8") echo "Octa-Core";;
    *) echo "$n-Core";;
  esac
}

hwinfoProcessor(){
  cat /proc/cpuinfo | grep -Po 'model name\s+: \K(.*)' | head -n1
}

showBanner(){
  if $banner; then
    echo -ne "\n\n${ind}${CW}Cross Compile Shell Scripts ${vsh} for Linux${C0}\n${ind}"
    [ -n $(which lsb_release) ] && echo -ne "$(lsb_release -sd) "
    if [ -n "$(uname -r | grep 'microsoft')" ];then
      echo -ne "WSL2 "
    elif [ -n "$(uname -r | grep 'Microsoft')" ];then
      echo -ne "WSL "
    fi
    echo -e "$(uname -o) $(uname -m) ${C0} $(uname -r)"
    echo -e "${CW}${ind}$(hwinfoCountCoresReadable) $(hwinfoProcessor)${C0}"
  fi
}






# main

while [ $1 ];do
  case $1 in
    aa64|aa8|a*64-*android|android )
      arch=aarch64-linux-android
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=linux; host_arm=true; host_os=android; host_mingw=false
      LIBSDIR=$(pwd)/builds/android/arm64-v8a
      PLATFORM="Android" CPU="aarch64" ABI="arm64-v8a" EABI=
      CT0=$CG3 CT1=$CG6
      ;;
    aa7|arm-*android*eabi|arm-android)
      arch=arm-linux-androideabi
      host_arch=$arch; host_64=false; host_eabi=eabi; host_vnd=linux; host_arm=true; host_os=android; host_mingw=false
      LIBSDIR=$(pwd)/builds/android/armeabi-v7a
      PLATFORM="Android" CPU="arm" ABI="armeabi-v7a" EABI="eabi"
      CT0=$CG2 CT1=$CG5
      ;;
    a86|ax86|*86-*android)
      arch=i686-linux-android
      host_arch=$arch; host_64=false; host_eabi=; host_vnd=linux; host_arm=false; host_os=android; host_mingw=false
      LIBSDIR=$(pwd)/builds/android/x86
      PLATFORM="Android" CPU="i686" ABI="x86" EABI=
      CT0=$CG0 CT1=$CG1
      ;;
    a64|ax64|*64-*android)
      arch=x86_64-linux-android
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=linux; host_arm=false; host_os=android; host_mingw=false
      LIBSDIR=$(pwd)/builds/android/x86_64
      PLATFORM="Android" CPU="x86_64" ABI="x86_64" EABI=
      CT0=$CG0 CT1=$CG1
      ;;
    la8|la64|a*64-linux|a*64-*gnu|a*64-linux-gnu|rpi*64|rpi3b*)
      arch=aarch64-linux-gnu
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=linux; host_arm=true; host_os=gnu; host_mingw=false
      LIBSDIR=$(pwd)/builds/arm/aarch64
      PLATFORM="Linux" CPU="aarch64" ABI="aarch64" EABI=
      CT0=$CM0 CT1=$CM1
      ;;
    la7|lahf|arm*hf|arm-linux*|rpi*32|rpi2*)
      arch=arm-linux-gnueabihf
      host_arch=$arch; host_64=false; host_eabi=eabihf; host_vnd=linux; host_arm=true; host_os=gnu; host_mingw=false
      LIBSDIR=$(pwd)/builds/arm/armeabihf
      PLATFORM="Linux" CPU="arm" ABI="arm" EABI="eabihf"
      CT0=$CY0 CT1=$CY1
      ;;
    l86|lx86|*86-linux*|linux*32 )
      arch=i686-linux-gnu
      host_arch=$arch; host_64=false; host_eabi=; host_vnd=linux; host_arm=false; host_os=gnu; host_mingw=false
      LIBSDIR=$(pwd)/builds/linux/i686
      PLATFORM="Linux" CPU="i686" ABI="x86" EABI=
      CT0=$CM0 CT1=$CM1
      ;;
    l64|lx64|*64-linux*|linux*64|linux )
      arch=x86_64-linux-gnu
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=linux; host_arm=false; host_os=gnu; host_mingw=false
      LIBSDIR=$(pwd)/builds/linux/x86_64
      PLATFORM="Linux" CPU="x86_64" ABI="x86_64" EABI=
      CT0=$CM0 CT1=$CM1
      ;;
    wa8|a*64-w64*|a*64-*mingw*)
      [ -z "${LLVM_MINGW_HOME}" ] && doErr "Toolchain for aarch64-w64-mingw32 is not installed"
      arch='aarch64-w64-mingw32'
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=w64; host_arm=true; host_os=mingw32; host_mingw=true
      LIBSDIR=$(pwd)/builds/windows/aarch64
      PLATFORM="Windows" CPU="aarch64" ABI="aarch64" EABI=
      CT0=$CC0 CT1=$CC1
      ;;
    wa7|arm*-w64*|arm*-*mingw*)
      [ -z "${LLVM_MINGW_HOME}" ] && doErr "Toolchain for armv7-w64-mingw32 is not installed"
      arch=armv7-w64-mingw32
      host_arch=$arch; host_64=false; host_eabi=; host_vnd=w64; host_arm=true; host_os=mingw32; host_mingw=true
      LIBSDIR=$(pwd)/builds/windows/armv7
      PLATFORM="Windows" CPU="arm" ABI="arm" EABI=
      CT0=$CC0 CT1=$CC1
      ;;
    w64|wx64|*64-win*|*64-*mingw*|windows|win|w*64)
      arch=x86_64-w64-mingw32
      host_arch=$arch; host_64=true; host_eabi=; host_vnd=w64; host_arm=false; host_os=mingw32; host_mingw=true
      LIBSDIR=$(pwd)/builds/windows/x86_64
      PLATFORM="Windows" CPU="x86_64" ABI="x86_64" EABI=
      CT0=$CB0 CT1=$CB1
      ;;
    w86|wx86|*86-win*|*86-*mingw*|w*32)
      arch=i686-w64-mingw32
      host_arch=$arch; host_64=false; host_eabi=; host_vnd=w64; host_arm=false; host_os=mingw32; host_mingw=true
      LIBSDIR=$(pwd)/builds/windows/i686
      PLATFORM="Windows" CPU="i686" ABI="x86" EABI=
      CT0=$CB0 CT1=$CB1
      ;;
    --api) shift && export API=$1;;
    --clang) use_clang=true;;
    --prefix) shift && LIBSDIR=$1;;
    --stable) git_stable=true;;
    --desc ) echo $dsc && exit 0;;
    --help|-h) showBanner && usage && exit 0;;
    --clean ) clean && exit 0;;
    --clearsrc ) rm -rf "$(pwd)/sources/${lib}" && exit 0;;
    --update )  update=true;;
    --updateall )  update=true; req_update_deps=true;;
    --vrep)     git_remote_version $src && exit 0;;
    --opts)     showOpts "$(pwd)/sources/$lib" && exit 0;;
    --checkPkg) checkPkg && exit 0;;
    --libName)  echo $lib && exit 0;;
    --getVar)   shift && echo $($1) && exit 0;;
    --refresh)  update=true;;
    --retry)    retry=true;;
    --rebuild)  rm $LIBSDIR/lib/pkgconfig/${pkg}.pc >/dev/null 2>&1;;
    --shared)   $lib_noshared || build_shared=true;;
    --shared-only ) build_shared=true build_static=false;;
    --static)   build_static=true build_shared=false;;
    --bin)      build_bin=true CBN="${cb1}";;
    --nobin)    build_bin=false CBN="${cb0}";;
    --nodist)   bdist=false;;
    --clear) shift
      while [ -n "$1" ];do
        case $1 in
          source|src) [ -n "${lib}" ] && rm -rf sources/${lib} 2>/dev/null;;
          all-sources) rm -rf sources 2>/dev/null;;
          all-builds) rm -rf builds 2>/dev/null;;
          all-packages) rm -rf packages 2>/dev/null;;
        esac
        shift
      done
      exit 0
      ;;
    --get) shift
      pkgfile="$LIBSDIR/lib/pkgconfig/${pkg}.pc"
      case $1 in
        cflags)     [ -f "${pkgfile}" ] && echo $(pkg-config ${pkgfile} --cflags) && exit 0;;
        ldflags)    [ -f "${pkgfile}" ] && echo $(pkg-config ${pkgfile} --libs) && exit 0;;
        ldstatic)   [ -f "${pkgfile}" ] && echo $(pkg-config ${pkgfile} --libs --static) && exit 0;;
        pc-ver)     [ -f "${pkgfile}" ] && echo $(pkg-config ${pkgfile} --modversion) && exit 0;;
        pc-path|pc) echo ${pkgfile} && exit 0;;
        pc-name)    echo ${pkg} && exit 0;;
        prefix)     echo $LIBSDIR && exit 0;;
        libname)    echo ${lib} && exit 0;;
        aptname)    echo ${apt} && exit 0;;
        var) shift; echo ${!1} && exit 0;;
        cmake_include)
          if [ -z "$cmake_path" ];then
            echo
          else
            echo "$LIBSDIR/$cmake_path"
          fi
          exit 0
          ;;
      esac
      ;;
    --repo) only_repo=true;;   
    --cmake) cfg='cm';;
    --ndkcmake) ndkcmake=true;;
    --ccmake) cfg='ccm';;
    --nobanner) banner=false;;
    --debug) debug=true && set -x;;
    --nodev) nodev=true;;
    --posix) f_win_posix=true;;
    --ndkLpthread) patch_ndk_libpthread;;
    --ndkLrt) patch_ndk_librt;;
    --vlatest) echo $(githubLatestTarGz) && exit 0;;
    --wipeall) read -p "Wipe all data? [y|N]" r
      case $r in y|Y) rm -rf builds sources
      esac && exit 0
      ;;
    * ) if [ "$(type -t extraOpts)" = 'function' ]; then
          extraOpts $1
        else
          showBanner
          usage
          echo -e "${ind}${CR0}Unknown option $1\n${C0}"
          exit 1
        fi
        ;;
  esac
  shift
done


[ -z ${f_win_posix} ] && f_win_posix=false

# Set default Host
if [ -z "${arch}" ];then
  arch="x86_64-linux-gnu"
  LIBSDIR=$(pwd)/builds/linux/x86_64
  SYSTEM_NAME="Android"
  CPU="x86_64"
  ABI="x86_64"
  EABI=
fi

loadToolchain

if [ -z "$ISRUNNING" ]; then
  showBanner
  export ISRUNNING=1
fi
if [ -n "${sudo}" ] && ! ${sudo} -n true 2>/dev/null; then
  echo -ne "${ind}${CY1}Requesting sudo for tool install "
  ${sudo} echo -ne "\r"
fi


# check build type and set defaults if no cst0 cst1 csh0 or csh1 value provided
case $cfg in
  cm|ccm|cmake|ccmake)
    build_tool=cmake
    [ -n "$cstk" ] && cst0="-D${cstk}=OFF" cst1="-D${cstk}=ON"
    [ -z "$cst0" ] && cst0="-DBUILD_STATIC_LIBS=OFF"
    [ -z "$cst1" ] && cst1="-DBUILD_STATIC_LIBS=ON"

    [ -n "$cshk" ] && csh0="-D${cshk}=OFF" csh1="-D${cshk}=ON"
    [ -z "$csh0" ] && csh0="-DBUILD_SHARED_LIBS=OFF"
    [ -z "$csh1" ] && csh1="-DBUILD_SHARED_LIBS=ON"
    
    [ -n "$cbk" ] && cb0="-D${cbk}=OFF" cb1="-D${cbk}=ON"

    ;;
  am|ac|ar|ag|auto*)
    build_tool=automake
    [ -z "$cst0" ] && cst0="--disable-static"
    [ -z "$cst1" ] && cst1="--enable-static"
    [ -z "$csh0" ] && csh0="--disable-shared"
    [ -z "$csh1" ] && csh0="--enable-shared"
    [ -n "$cbk" ] && {
      case $cbk in
        --enable-*) cb0="${cbk}=0"; cb1="${cbk}=1";;
        able-*) cb0="--dis${cbk}"; cb1="--en${cbk}";;
        with-*) cb0="--without-${cbk:5}"; cb1="--${cbk}";;
        *) cb0="--enable-${cbk}=0" cb1="--enable-${cbk}=1";;
      esac
    }
    ;;
  meson)
    build_tool=meson
    $build_static && ! $build_shared && CSH="-Ddefault_library=static"
    $build_shared && ! $build_static && CSH="-Ddefault_library=shared"
    $build_static && $build_shared && CSH="-Ddefault_library=both"
    ;;
  mk|make) build_tool=make;;
  *) unset build_tool;;
esac

if [ -z ${CSH+x} ];then
  $build_static && CSH="${cst1}" || CSH="${cst0}"
  $build_shared && CSH="${csh1} ${CSH}" || CSH="${csh0} ${CSH}"
fi
if [ -z ${CBN+x} ];then
  $build_bin && CBN="${cb1}" || CBN="${cb0}"
fi

# reset presets, we don't need them anymore
unset cst0 cst1 csh0 csh1 cb0 cb1 cstk cshk cbk

export arch update retry \
  build_shared build_static build_bin build_tool \
  CSH CBN LIBSDIR PLATFORM CPU ABI EABI \
  host_arch host_64 host_eabi host_vnd host_arm host_os \
  f_win_posix MAKE_EXECUTABLE=make cmake_includes

main