#!$SHELL
# ................................................
# X-Builder util 0.3.2 2021-diasgc
# ................................................

# first load .common functions and error trap
if [ -z ${vsh+x} ];then
  . .common
  set -o pipefail
  if [ "${1}" == "--debug" ];then
    shift
    set -x
    debug=true
  fi
  trap err ERR
fi

sudo=$(which sudo)
# defvar debug=false 
: "${debug:=false}"
: "${nodev:=false}"
: "${is_init:=false}"
: "${pkg:=${lib}}"
: "${apt:=${lib}}"
: "${ac_nohost:=false}"
: "${disable_shared:=false}"
: "${ac_nosysroot:=false}"
: "${ac_nopic:=false}"
: "${banner:=true}"
: "${req_update_deps:=false}"
: "${update:=false}"
: "${build_dist:=true}"
: "${dep_build:=--static}"
: "${build_strip:=true}"
: "${API:=24}"

$req_update_deps && update=true
pkg_fmt="tgz"
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

logtime_start=0
logtime_end=0

export ROOTDIR=$(pwd)
export target_trip=
export CPPFLAGS=
export dir_sources="${ROOTDIR}/sources"
export dir_src="${dir_sources}/${lib}"
export dir_pkgdist="${ROOTDIR}/packages"

# decaprated, legacy support only
export SRCDIR=${dir_src}
# to remove after 

[ -d "${dir_sources}" ] || mkdir -p ${dir_sources}

# variables defined in .config file
# config_lastupdate
# ROOTDIR path
# build_arch (x86_64-linux-gnu)
# ANDROID_NDK_HOME path
# xv_ndk (23.1.7779620)
# xv_ndk_major (23)
# MAKE_EXECUTABLE path
# CMAKE_EXECUTABLE path
# NASM_EXECUTABLE path
# PKG_CONFIG path
# HOST_NPROC (4)
# LLVM_MINGW_HOME path
# LLVM_MINGW_REL (20211002)
# xv_llvm_mingw (13.0.0)
# llvm_mingw_rel (20211002)
# xv_aarch64_gnu (11)
# xv_armeabi_gnu (10)
# xv_x86_gnu (10)
# xv_x64_gnu (10)
# xv_x64_mingw (10)
# 
xv_x86_mingw="10"
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
  [ -z "${indent}" ] && indent=0
  export is_init=true indent ind
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

  test -z ${dir_install} || test -z $src && errCall

  gitjson=$(git_api_tojson $src)
  if [ -n "${gitjson}" ];then
    #echo -ne "${CY1}${b}${C0}"
    : "${lic:=$(echo "$gitjson" | jq .licence)}"
    : "${dsc:=$(echo "$gitjson" | jq .description)}"
  fi
  # show package info
  [ -f "${dir_install_pc}/${pkg}.pc" ] || pkgInfo

  log_file="${dir_install}/${lib}.log"
}

pkgInfo(){
  local dp=
  local vs=
  local longdesc=$(aptLongDesc)
  [ -z "$(echo $longdesc | xargs 2>/dev/null)" ] && unset longdesc
  [ -n "${tls}" ] && dp="${CT0}build deps: ${C0}$tls "
  [ -n "${dep}" ] && dp="${dp}${CT0}lib deps: ${C0}$dep"
  if [ "$sty" == "git" ];then
    local vgit=$(git_remote_version $src)
    if [ -d ${dir_src} ];then
      pushd ${dir_src}
      local vrep=$(git describe --abbrev=0 --tags 2>/dev/null)
      popd
      vs="${CT0}vrs: ${C0}$vrep "
      if str_contains $vgit $vrs; then
        vs+=" updated"
      else
        vs+=" ${CT0}latest: ${CT1}${vgit}${C0}"
      fi
    else
      vs="${CT0}vrs: ${C0}${vgit}"
    fi
  fi
  [ -n "${dsc}" ] && echo -e "\n${CW}${ind}${lib^^} - ${C0}${dsc}"
  [ -n "${longdesc}" ] && echo -e "${CD}${longdesc}" | sed 's|\*|\u2605|g; s|\..\..|. |g' # sed 's|^|'${ind}|g'
  echo -e "${CT0}${ind}Licence ${C0}$lic ${dp} ${vs}"
}

aptLongDesc(){
  [ -n "$apt" ] && echo -e $(apt-cache show ${apt} 2>/dev/null | \
    grep -E "Description-..^|^ " | \
    sed $'s/\*/\u2605/g' | \
    sed '/^ *This package contains.*\./d') | fold -s -w120 | sed 's/^/'"${ind}"'/g'
  return 0
}

# Variables
# mki: rule for install 'make $mkinstall' (default: install)
# mkc: rule for clean 'make $mkclean' (default: clean)
# mkf: additional rule for make
# no_host  : while using autotools, no host will be set for cross-compile if no_host is not empty

gitjson=

guess_cfg(){
  if [ -f "${dir_config}/meson.build" ]; then
    build_tool="meson"
    cfg="meson"
  elif [ -f "${dir_config}/CMakeLists.txt" ]; then
    build_tool="cmake"
    cfg="cmake"
  elif [ -n "$(ls ${dir_config}/configure.* 2>/dev/null)" ]; then
    build_tool="automake"
    cfg='ac'
    if [ -f "${dir_config}/autogen.sh" ]; then
      automake_cmd="${dir_config}/autogen.sh"
    elif [ -f "${dir_config}/bootstrap.sh" ]; then
      automake_cmd="${dir_config}/bootstrap.sh"
    elif [ -f "${dir_config}/bootstrap" ]; then
      automake_cmd="${dir_config}/bootstrap"
    elif [ ! -f "${dir_config}/configure" ]; then
      automake_cmd="autoreconf -fiv ${dir_config}/bootstrap"
    else
      return 1
    fi
  else
    return 1
  fi
  return 0
}

start(){
  
  # check whether to update source of main lib and dependencies
  if $update; then
    [ -d "${dir_src}" ] && rm -rf "${dir_src}" 2>/dev/null
    ! $req_update_deps && update=false
  else
    [ -f "${dir_install_pc}/${pkg}.pc" ] && exit
  fi
  
  # Reset LOGFILE
  [ -f "${log_file}" ] && rm -f ${log_file}

  # Create INSTALL_DIR and PKGCONFIG DIR
  mkdir -p ${dir_install_pc}
  export PKG_CONFIG_LIBDIR="${dir_install_pc}:${PKG_CONFIG_LIBDIR}"

  check_tools $tls
  o_vrs=$vrs
  o_csh=$CSH
  o_cbn=$CBN
  unset vrs CSH CBN
  build_dependencies $dep
  vrs=$o_vrs
  CSH=$o_csh
  CBN=$o_cbn

  log_start $arch ${eta}s
  local bss=
  $build_static && bss="${SSB}[static]" || bss="${CD}[static]"
  $build_shared && bss="${bss}${SSB}[shared]" || bss="${bss}${CD}[shared]"
  $build_bin && echo -ne "${bss}${SSB}[bin]${C0} " || echo -ne "${bss}${CD}[bin]${C0} "
  cd ${dir_sources}

  ! $retry && [ "${dir_build}" != "${dir_src}" ] && rm -rf ${dir_build}
  
  # default dir_config is dir_src
  : "${dir_config:=${dir_src}}"
  # check if defined custom dir_config location (config_dir)
  [ -n "${config_dir+x}" ] && dir_config="${dir_sources}/${lib}/${config_dir}"

  local req_src_config=false

  # get source
  if [ ! -d ${dir_src} ];then
    # check whether to custom get source
    if fn_defined 'source_get'; then
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
    req_src_config=true
  fi

  pushdir ${dir_config}
  
  if [ -z ${cfg} ]; then
    guess_cfg
  fi

  if $req_src_config; then
    # check whether to custom config source
    if fn_defined 'source_config'; then
      do_log 'config' source_config
    elif [ -n "$automake_cmd" ];then
      do_log 'automake' $automake_cmd
      unset automake_cmd
    else case $cfg in
      ab) [ -f "${dir_config}/boostrap" ] && do_log 'bootstrap' ${dir_config}/boostrap
          [ -f "${dir_config}/boostrap.sh" ] && do_log 'bootstrap' ${dir_config}/boostrap.sh
          ;;
      ag) doAutogen ${dir_config} --noconfigure;;
      ar) doAutoreconf ${dir_config};;
      am|autom*)
        if [ ! -f "${dir_config}/configure" ];then
          if [ -f "${dir_config}/autogen.sh" ];then
            doAutogen ${dir_config} --noconfigure
          else
            doAutoreconf ${dir_config}
          fi
        fi
        ;;
      esac
    fi

    # check whether to custom patch source
    if fn_defined 'source_patch'; then
      do_log 'patch' source_patch
    fi

    # check whether to auto patch source
    check_xbautopatch
  fi

  $only_repo && end_script
  
  if [ -z "${dir_build}" ];then
    case ${build_tool} in
      cmake|meson) dir_build="${dir_config}/build_${arch}"
        [ -d "${dir_build}" ] && rm -rf ${dir_build} 2>/dev/null
        ;;
      *) dir_build=${dir_config};;
    esac
  fi
  
  [ -d "${dir_build}" ] || mkdir -p "${dir_build}"
  cd ${dir_build}
  
  log_vars dir_src dep PKG_CONFIG_LIBDIR
  log_vars CC CXX LD AS AR NM RANLIB STRIP
  
  if fn_defined 'build_all'; then
    build_all
    end_script
  fi

  if fn_defined 'build_prepare'; then
    build_prepare
  fi

  if fn_defined 'build_clean'; then
    build_clean
  else
    [ -z "${mkc+x}" ] && mkc=$(make_findtarget "distclean" "clean")
    [ -f "Makefile" ] && do_quietly 'clean' ${MAKE_EXECUTABLE} $mkc
  fi

  if fn_defined 'build_config'; then
    build_config
  else case $build_tool in
    cmake)
      : "${exec_config:=${CMAKE_EXECUTABLE}}"
      [ -z "${cmake_toolchain_file}" ] && cmake_create_toolchain ${dir_build}
      [ -f "${cmake_toolchain_file}" ] && CFG="-DCMAKE_TOOLCHAIN_FILE=${cmake_toolchain_file} $CFG"
      do_log 'cmake' $exec_config ${dir_config} -DCMAKE_INSTALL_PREFIX=${dir_install} -DCMAKE_BUILD_TYPE=$cmake_build_type ${CFG} ${CSH} ${CBN}
      case $cfg in ccm|ccmake) tput sc; ccmake ..; tput rc;; esac
      MAKE_EXECUTABLE=make
      ;;
    automake)
      [ -z "${mki+x}" ] && mki=$(make_findtarget "install-strip" "install")
      [ -z "$exec_config" ] && exec_config='configure' # default config executable
      ! $ac_nohost && [ "$arch" != "${build_arch}" ] && CFG+=" --host=${arch}"
      ! $ac_nosysroot && CFG+=" --with-sysroot=${SYSROOT}"
      ! $ac_nopic && CFG+=" --with-pic=1"
      do_log 'configure' ${dir_config}/${exec_config} --prefix=${dir_install} ${CFG} $CSH $CBN "${cfg_args[@]}"
      MAKE_EXECUTABLE=make
      ;;
    meson)
      local MESON_CFG="${dir_config}/${arch}.meson"
      [ -f "${MESON_CFG}" ] && rm ${MESON_CFG}
      $host_clang || LD="bfd"
      meson_create_toolchain $MESON_CFG
      MAKE_EXECUTABLE=ninja
      do_log 'meson' meson setup --buildtype=release --cross-file=${MESON_CFG} --prefix=${dir_install} $CFG $CSH $CBN
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

  if fn_defined 'build_patch_config'; then
    do_log 'patch' build_patch_config
  fi

  [ -n "${WFLAGS}" ] && CPPFLAGS+=" ${WFLAGS}"
  
  static_ldflag='-static'
  # set -all-static flags at make time (see: https://stackoverflow.com/questions/20068947/how-to-static-link-linux-software-that-uses-configure)
  # $build_static && [[ "$LDFLAGS" != *"-all-static"* ]] && LDFLAGS="-all-static $LDFLAGS"
  $host_clang && static_ldflag="-all${static_ldflag}"
  $build_static && LDFLAGS="${static_ldflag} $LDFLAGS"

  log_vars CFLAGS CXXFLAGS WFLAGS CPPFLAGS LDFLAGS LIBS

  if fn_defined 'build_make'; then
    do_log 'make' build_make
  else
    do_progress 'make' ${MAKE_EXECUTABLE} $mkf -j${HOST_NPROC} || err
  fi
  
  if fn_defined 'patch_install';then
    patch_install
  fi


  [ -z ${mki} ] && mki="install"
  if fn_defined 'build_install'; then
    do_log 'install' build_install
  else
    $build_strip && do_log 'strip' doStrip
    do_log 'install' ${MAKE_EXECUTABLE} ${mki}
  fi

  # check whether to create pkg-config .pc file
  if [ -n "${req_pcforlibs+x}" ];then
    local pcf
    for l in $req_pcforlibs; do
      pcf=$(echo $l | sed 's|^lib||')
      create_pkgconfig_file $pcf "-l$pcf"
    done
  else
    fn_defined 'build_pkgconfig_file' && \
    do_log 'pkgcfg' build_pkgconfig_file || \
    [ -n "$pc_llib" ] && \
    do_log 'write_pc' create_pkgconfig_file $pkg $pc_llib
  fi

  # create package
  $build_package && do_log 'tar' build_packages_bin

  popdir

  logver "${dir_install_pc}/${pkg}.pc"

  fn_defined 'on_end' && on_end

  #stat_savestats
  end_script
}

doStrip(){
  local libdir
  for dd in $(find ${dir_src} \( -name "*.a" -o -name "*.so" \));do
    ${STRIP} --strip-unneeded $dd
  done
}

end_script(){
  log_end
  # check if parent process is shell script
  local parent=$(ps -o comm= $PPID)
  [ "${parent: -3}" == ".sh" ] || echo -e "\n${ind}${CT1}::Done${C0}\n"
  $debug && set +x
  unset dir_config dir_build dir_src \
        CSH CBN exec_config vrs \
        ac_nohost ac_nopic ac_nosysroot \
        req_pcforlibs mkc mki mingw_posix \
        cfg_args
  dec_tab
  echo
  exit 0
}

make_findtarget(){
  ${MAKE_EXECUTABLE} ${1} -n 2>>${log_file}
  test $? -eq 2 && {
    echo "${2}"; echo "make: target ${1} not found, setting default ${2} target." >>${log_file}
  } || {
    echo "${2}"; echo "make: target ${1} found." >>${log_file}
  }
}

check_xbautopatch(){
  pushdir $ROOTDIR
  local match=$(grep -oP "(?<=^<<').*?(?=')" $0)
  if [ -n "$match" ]; then
    local block=$(awk '/^<<.'"$match"'./{flag=1; next} /^'"$match"'/{flag=0} flag' $0)
    echo -e "\npatch this: \n$block" >>${log_file}
    case $match in
      XB_CREATE_CMAKELISTS) echo "${block}" >${dir_src}/CMakeLists.txt;;
      XB_APPLY_PATCH) pushdir ${dir_src}
        patch -p0 <<<$(echo "${block}") 2>&1 >${log_file}
        popdir;;
      XB64_PATCH) pushdir ${dir_src}
        patch -p0 <<<$(echo "${block}" | base64 -d) 2>&1 >${log_file}
        popdir;;
    esac
  fi
  popdir
  return 0
}

# usage create_pkgconfig_file <pkg>.pc [llibds][INSTALL_DIR]
create_pkgconfig_file(){
    [ -z "${1}" ] && pc_file=${lib} || pc_file=${1}
    [ -z "${2}" ] && pc_llib="-l${pc_file}" || pc_llib=${2}
    [ -z "${3}" ] && pc_prefix=${dir_install} || pc_prefix=${3}
    [ -z "$pc_libdir" ] && pc_libdir="/lib"
    [ -z "$pc_incdir" ] && pc_incdir="/include"
    [ -z "$pc_cflags" ] && pc_cflags="-I\${includedir}"
    [ -z "$pc_libs" ] && pc_libs="-L\${libdir}"
    [ -z "$pc_url" ] && pc_url=$(dirname $src)
    [ -z "$pc_vrs" ] && {
      [ -d "${dir_src}/.git" ] && pc_vrs=$(git_getversion ${dir_src}) || pc_vrs=$vrs
    }
    cat <<-EOF >${dir_install_pc}/${pc_file}.pc
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
  [ -f "${dir_install_pc}/${pkg}.pc" ] && vrs=$(pkg-config ${dir_install_pc}/${pkg}.pc --modversion)
  [ -z "$vrs" ] && set_git_version
  echo "${ROOTDIR}/packages/${lib}_${vrs}_${arch}"
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
      DESTDIR=${xb_distdir} ninja -C ${dir_build} install
    else
      [ -z "$mkd" ] && mkd="DESTDIR=${xb_distdir} install"
      ${MAKE_EXECUTABLE} $mkd
    fi
    [ -z "$mkd_suffix" ] && mkd_suffix=${dir_install}
    pushdir "${xb_distdir}${mkd_suffix}"
    
    # also include .pc manually-built file
    if [ "$(type -t build_pkgconfig_file)" = 'function' ] || [ -n "$pc_llib" ];then
      local xb_pkgd=$(pwd)/lib/pkgconfig
      [ ! -d "${xb_pkgd}" ] && mkdir -p $xb_pkgd
      if [ -n "${pc_filelist}" ];then
        for pp in ${pc_filelist}; do
          cp ${dir_install_pc}/${pp} ${xb_pkgd}/
        done
      else
        cp ${dir_install_pc}/${pkg}.pc ${xb_pkgd}/
      fi
    fi
    build_packages_filelist
    case $pkg_fmt in
      tgz) tar -czvf "${xb_distdir}.tar.gz" *;;
      tbz) tar -cvjSf "${xb_distdir}.tar.bz2" *;;
      zip) zip -r "${xb_distdir}.zip" *;;
    esac
    rm -rf ${xb_distdir}
    popdir
  fi
}

build_dependencies(){
  local pkgfile=
  local o_csh
  local o_cbh
  local cf
  local ldir
  while [ -n "${1}" ]; do
    [ -f "./${1}.sh" ] || doErr "no script file ${1}.sh.\n  Aborting..."
    pkgfile=$(./${1}.sh ${arch} --get pc)
    libname=$(./${1}.sh --get libname)
    if [ ! -f "${pkgfile}" ]; then
      o_csh=$CSH
      o_cbh=$CBH
      unset CSH CBH
      ./${1}.sh ${arch} ${dep_build} || err
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
  cmake_create_toolchain ${dir_build}
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
  echo "\nMeson file:(${1})\n\n" >>${log_file} 2>&1
  cat ${1} >>${log_file} 2>&1
}

cmake_include_directories(){
  printf "include_directories($@)" >>${cmake_toolchain_file}
}


# usage cmake_create_toolchain <dir>
cmake_create_toolchain(){
  export cmake_toolchain_file="${ROOTDIR}/xbuilder.cmake"
}

cmake_create_toolchainfile(){
  cmake_toolchain_file="${dir_build}/${arch}.cmake"
  cat <<-EOF >${cmake_toolchain_file}
    set(CMAKE_SYSTEM_NAME "${PLATFORM}")
    set(CMAKE_SYSTEM_PROCESSOR "${target_trip[0]}${target_trip[1]}")
    set(CMAKE_C_COMPILER ${CC})
    set(CMAKE_CXX_COMPILER ${CXX})
    set(CMAKE_FIND_ROOT_PATH ${SYSROOT}/usr
        ${SYSROOT}/usr/lib/${arch}
        ${SYSROOT}/usr/lib/${arch}/${API}
        ${dir_install})
    ${cmake_tcf_arch}

        set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_SYSTEM_PROCESSOR ${XB_CPU})
    if(XB_HOST MATCHES "^a")
        set(CMAKE_FIND_ROOT_PATH /usr/${XB_HOST}
            /usr/lib/gcc-cross/${XB_HOST}/${XB_ARMLINUX_TCVERSION}
            ${XB_INSTALL}})
    elseif(XB_HOST MATCHES "^i")
        set(CMAKE_SYSTEM_PROCESSOR "x86")
        set(CMAKE_C_COMPILER_ARG1 "-m32")
        set(CMAKE_CXX_COMPILER_ARG1 "-m32")
        set(CMAKE_FIND_ROOT_PATH /usr/${XB_HOST}
            /usr/lib/gcc-cross/${XB_HOST}/${XB_X86LINUX_TCVERSION}
            ${XB_INSTALL})
    endif()
    if(XB_HOST MATCHES "^x86_64")
        set(CMAKE_C_COMPILER gcc)
        set(CMAKE_CXX_COMPILER g++)
    else()
        set(CMAKE_C_COMPILER ${XB_HOST}-gcc)
        set(CMAKE_CXX_COMPILER ${XB_HOST}-g++)
        set(CMAKE_AR ${XB_HOST}-ar CACHE FILEPATH Archiver)
        set(CMAKE_RANLIB ${XB_HOST}-ranlib CACHE FILEPATH Indexer)
    endif()
EOF
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
  make $@ 2>&1 | tee -a ${log_file} | grep -Eo "\[.+%\]" 
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
  if [ -n "${logtime_start}" ]; then
    logtime_end=$(date +%s)
    #local pkgsize=$(du -sk ${dir_install} | cut -f1)
    #local libsize=$(du -sk ${dir_install}/lib | cut -f1)
    local secs=$(($logtime_end-$logtime_start))
    local msg="${CT1} done ${CD}in $(secs2time ${secs})"
    [ $secs -gt 60 ] && msg="$msg (${secs}s)"
    #echo -e "$msg pkg/lib: ${pkgsize}/${libsize}kb${C0}"
    echo -e "$msg"
  fi
}

log(){
  echo -ne "$CD$@$C0"
}

log_vars(){
  while [ -n "$1" ]; do
    echo "$1=${!1}" >>${log_file} 2>&1
    shift
  done
  echo >>${log_file}
}

doErr(){
  echo -e "${CR1}  Error: ${CR0}${1}${C0}\n\n"
  if [ -f ${log_file} ];then
    if [ -f ${dir_build}/CMakeFiles/CMakeError.log ];then
      echo -e "\n\n${dir_build}/CMakeFiles/CMakeError.log:\n" >> ${log_file}
      cat ${dir_build}/CMakeFiles/CMakeError.log >> ${log_file}
    fi
    echo -ne "${CY1}${ind}Open log? [Y|n]:${C0}" && read openlog
    [ "$openlog" != "n" ] && nano ${log_file}
  fi
  exit 1
}

err(){
  if [ -n "${logtime_start}" ]; then
    logtime_end=$(date +%s)
    echo -e "${CR1} fail ${CR0}[$(secs2time $(($logtime_end-$logtime_start)))]${C0}\n"
  fi
  if [ -f ${log_file} ];then
    if [ -f ${dir_build}/CMakeFiles/CMakeError.log ];then
      echo -e "\n\n${dir_build}/CMakeFiles/CMakeError.log:\n" >> ${log_file}
      cat ${dir_build}/CMakeFiles/CMakeError.log >> ${log_file}
    fi
    echo -ne "${CY1}${ind}Open log? [Y|n]:${C0}" && read openlog
    [ "$openlog" != "n" ] && nano ${log_file}
  fi
  echo
  exit 1
}

log_this() {
  echo -e "\n$(date +"%T"): $@" >> "${log_file}"
  "$@" 2>> "${log_file}" 1>> "${log_file}" || err
  logok
}


do_quietly(){
  local var=$1; shift
  echo -ne "${CD}${var}${C0}"
  echo -e "\n$(date +"%T"): $@" >> "${log_file}"
  "$@" >/dev/null 2>&1
  logok $var
}

do_log() {
  local var=$1; shift
  echo -ne "${CD}${var}${C0}"
  log_this $@
  logok $var
}

do_progress() {
  local var=$1; shift
  echo -ne "${CD}${var}"
  echo -e "\n$(date +"%T"): $@" >> "${log_file}"
  ("$@" |& tee -a ${log_file} | topct) || doErr "in ${var}:\n\n...\n$(tail -n5 ${log_file})${C0}"
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
  tput sc; ccmake $@; tput rc
}

isBottomRow(){
  test "$(echo "lines"|tput -S)" == "$(IFS=';' read -sdR -p $'\e[6n' ROW COL && echo "${ROW#*[}")" && echo 1 || echo 0
}

# usage: do_git giturl [libname]
do_git(){
  do_log 'git' git clone $1 $2
  cd $2
  [ -n "${vrs}" ] && do_log ${vrs} git checkout tags/${vrs}
  [ -n "${sub}" ] && do_log 'sub' git ${sub}
  cd ..
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
    do_log ${vrs} git checkout tags/${vrs};
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
  do_log 'clone' hg clone $1 $2
}

set_git_version(){
  pushdir ${dir_src}
  local v=$(git describe --abbrev=0 --tags 2>/dev/null)
  [ -n "$v" ] && export vrs=$v
  popdir
}

github_latest_tgz(){
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
  echo "$(date): $@" >> "${log_file}"
  
  case $src in
    *.tar.lz) 
      test -z $(which lzip) && aptInstall lzip
      args="--lzip -xv"
      ;;
    *.tar.gz|*.tgz) args="-xvz";;
    *.tar.xz) args="-xvJ";;
  esac

  [ -d "tmp" ] && rm -rf tmp
  mkdir tmp
  wget -qO- $1 2>>${log_file} | tar --transform 's/^dbt2-0.37.50.3/dbt2/' $args -C tmp >/dev/null 2>&1 || err
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
  echo -e "\n\n$@\n----------------------------------------\n" >> "${log_file}"
  echo "$(date): $@" >> "${log_file}"
  case $sty in
    tlz|tar_lz) 
      test -z $(which lzip) && aptInstall lzip
      ags="--lzip -xv"
      ;;
    tgz|tar_gz) args="-xvz";;
    txz|tar_xz) args="-xvJ";;
  esac
  wget -qO- $src 2>>${log_file} | tar --transform 's/^dbt2-0.37.50.3/dbt2/' $args >/dev/null 2>&1 || err
  mv ${1}* ${lib}
  echo -e "----------------------------------------\n" >> "${log_file}"
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
    --noerr ) ./autogen.sh >>${log_file} 2>&1;;
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

ndk_assert_h_sys_soundcard(){
  [ "$host_os" == "android" ] && \
    [ ! -f "$SYSROOT/usr/include/sys/soundcard.h" ] && \
    echo "#include <linux/soundcard.h>" >"$SYSROOT/usr/include/sys/soundcard.h" 
  return 0
}

toolchain_android(){
  [ -d "${ANDROID_NDK_HOME}" ] || doErr "No ANDROID NDK Toolchain found. Aborting."

  TOOLCHAIN="${ndk_toolchain}"
  SYSROOT="${TOOLCHAIN}/sysroot"
  CROSS_PREFIX="${TOOLCHAIN}/bin"
  
  CC="${TOOLCHAIN}/bin/${target_trip[0]}${target_trip[1]}-${target_trip[2]}-${target_trip[3]}${target_trip[4]}${API}-"
  CXX="${CC}${ndk_cc[1]}"
  CC="${CC}${ndk_cc[0]}"
  LD="${TOOLCHAIN}/bin/ld.lld"
  YASM=${TOOLCHAIN}/bin/yasm
  arch="${target_trip[0]}-${target_trip[2]}-${target_trip[3]}${target_trip[4]}"

  if [ ${xv_ndk_major} -gt 22 ];then
    AS=${CC}  
    CROSS_PREFIX+="/llvm-"
  else
    CROSS_PREFIX+="/${arch}-"
    AS="${CROSS_PREFIX}as"
  fi
  
  CMAKE_TOOLCHAIN="${ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake"
  LT_SYS_LIBRARY_PATH="${SYSROOT}/usr/lib/$arch:${SYSROOT}/usr/lib/${arch}/${API}"
  CPPFLAGS+=" -I${SYSROOT}/usr/include -I${SYSROOT}/usr/include/${arch} -I${SYSROOT}/usr/local/include"
  LDFLAGS="-Wl,-rpath,${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
}

loadToolchain(){

  ${host_cross} && return 0

  CMAKE_EXECUTABLE=cmake
  YASM=yasm
  PKG_CONFIG=pkg-config

  #reset flags
  unset LIBS CFLAGS CXXFLAGS LDFLAGS WFLAGS
  CPPFLAGS+=" -I${dir_install_include}"
  LDFLAGS="-L${dir_install_lib}"



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
      LDFLAGS="-Wl,-rpath,${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      CPPFLAGS+=" -I${SYSROOT}/usr/include/${arch} -I$SYSROOT/usr/include -I$SYSROOT/usr/local/include"
      YASM=${TOOLCHAIN}/bin/yasm
      cmake_tcf_arch="set(ANDROID_ABI ${target_trip[5]})\n
    set(ANDROID_PLATFORM ${API})\n
    set(ANDROID_NDK ${ANDROID_NDK_HOME})\n
    set(ZLIB_INCLUDE_DIRS ${SYSROOT}/usr/include)\n
    set(ZLIB_LIBRARIES ${SYSROOT}/usr/lib/${XB_HOST})\n
    set(ZLIB_VERSION_STRING 1.2.11)\n
    include(${CMAKE_TOOLCHAIN})"
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
      LDFLAGS="-Wl,-rpath,${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      CPPFLAGS+=" -I/usr/include -I/usr/local/include"
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
        CPPFLAGS+=" -I${LLVM_MINGW_HOME}/${arch}/include"
        LDFLAGS="-L${LT_SYS_LIBRARY_PATH}/lib -L${SYSROOT}/lib ${LDFLAGS}"
      else
        CROSS_PREFIX="${arch}-"
        TOOLCHAIN="/usr/${arch}/bin"
        SYSROOT="/usr/${arch}"
        $mingw_posix && posix="-posix" || unset posix
        CC="${CROSS_PREFIX}gcc${posix}"
        CXX="${CROSS_PREFIX}g++${posix}"
        LT_SYS_LIBRARY_PATH="/usr/lib/gcc/${arch}/${xv_x64_mingw}"
        LDFLAGS="-L${LT_SYS_LIBRARY_PATH} ${LDFLAGS}"
      fi
      LD="${CROSS_PREFIX}ld" AS="${CROSS_PREFIX}as"
      export RC=${CROSS_PREFIX}windres
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
  local pf="${dir_install_pc}/${pkg}.pc"
  [ -f "$pf" ] && echo $pf
  return 0
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

prompt_remove(){
  while [ -n "${1}" ]; do
    echo -ne "\n  Are you sure you want do remove ${CY1}$(basename $1)?${C0} Type 'Yes' to proceed: "; read q
    if [ "${q}" == "Yes" ]; then
      echo -ne "  > Removing $1... " && rm -rf $1 2>/dev/null && echo -e " ${CG1}done${C0}" || echo -e "${CR1} Fail${C0}"
    else
      break
    fi
    shift
  done
  echo
}

showBanner(){
  if $banner; then
    echo -ne "\n\n${ind}${CW}Cross Builder Scripts ${vsh} for Linux${C0}\n${ind}"
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

menu_tune(){
  case $1 in
    smd855)   CPPFLAGS+=" -mtune=cortex-a76.cortex-a55";;
    smd865)   CPPFLAGS+=" -mtune=cortex-a77.cortex-a55";;
    smd888)   CPPFLAGS+=" -mtune=cortex-a78.cortex-a55";;
    cortex-*) CPPFLAGS+=" -mtune=$1";;
  esac
}

menu_clear(){
  while [ -n "$1" ];do
    case $1 in
      srclib)   prompt_remove ${dir_src};;
      sources)  prompt_remove ${dir_sources};;
      builds)   prompt_remove ${dir_install};;
      packages) prompt_remove ${dir_pkgdist};;
      wipe*)    prompt_remove ${dir_pkgdist} ${dir_install} ${dir_sources};;
    esac
    shift
  done
  return 0
}

menu_get(){
  local pkgfile="${dir_install_pc}/${pkg}.pc"
  case $1 in
    cflags)     [ -f "${pkgfile}" ] && echo "$(pkg-config ${pkgfile} --cflags)";;
    ldflags)    [ -f "${pkgfile}" ] && echo "$(pkg-config ${pkgfile} --libs)";;
    ldstatic)   [ -f "${pkgfile}" ] && echo "$(pkg-config ${pkgfile} --libs --static)";;
    pc-ver)     [ -f "${pkgfile}" ] && echo "$(pkg-config ${pkgfile} --modversion)";;
    pc-path|pc) echo "${pkgfile}";;
    pc-name)    echo "${pkg}";;
    prefix)     echo "${dir_install}";;
    libname)    echo "${lib}";;
    aptname)    echo "${apt}";;
    var)        shift; echo "${!1}";;
    vrs_remote) git_remote_version $src;;
    vrs_local)  git_remote_version $src;;
    vrs_latest) echo "$(github_latest_tgz)";;
    cmake_include) [ -z "$cmake_path" ] || echo "${dir_install}/${cmake_path}";;
  esac
  return 0
}

set_target(){
  cpu_id="${1}"
  target_trip=("${2}" "${3}" "${4}" "${5}" "${6}" "${7}" "${8}")
  arch="${2}${3}-${4}-${5}${6}"
  CT0="${9}"
  CT1="${10}"
  CPU=${2}
  ABI=${7}
  EABI=${6}
  set_env
}

set_env(){
  case ${target_trip[0]} in
    aarch64) host_arm=true;  host_arm32=false; host_arm64=true;  host_x86=false; host_x64=false;;
    arm)     host_arm=true;  host_arm32=true;  host_arm64=true;  host_x86=false; host_x64=false;;
    i686)    host_arm=false; host_arm32=false; host_arm64=false; host_x86=true;  host_x64=false;;
    x86_64)  host_arm=false; host_arm32=false; host_arm64=false; host_x86=false; host_x64=true;;
  esac
  case ${target_trip[3]} in
    android) host_sys=linux;   host_mingw=false; host_os=android; host_ndk=true;  host_clang=true;  PLATFORM="Android";;
    gnu)     host_sys=linux;   host_mingw=false; host_os=gnu;     host_ndk=false; host_clang=false; PLATFORM="Linux";;
    mingw32) host_sys=windows; host_mingw=true;  host_os=mingw32; host_ndk=false; host_clang=true;  PLATFORM="Windows";;
  esac
  #LIBSDIR="$(pwd)/builds/${PLATFORM,,}/${target_trip[5]}"
  export dir_install="${ROOTDIR}/builds/${PLATFORM,,}/${target_trip[5]}"
  export dir_install_bin="${dir_install}/bin"
  export dir_install_include="${dir_install}/include"
  export dir_install_lib="${dir_install}/lib"
  export dir_install_pc="${dir_install_lib}/pkgconfig"
}

# main

while [ $1 ];do
  case $1 in
    aa64|aa8|a*64-*android|android )
      set_target '0' 'aarch64' '' 'linux' 'android' '' 'arm64-v8a' '64' $CG3 $CG6;;
    aa7|arm-*android*eabi|arm-android)
      set_target '1' 'arm' 'v7a' 'linux' 'android' 'eabi' 'armeabi-v7a' '32' $CG2 $CG5;;
    a86|ax86|*86-*android)
      set_target '2' 'i686' '' 'linux' 'android' '' 'x86' '32' $CG0 $CG1;;
    a64|ax64|*64-*android)
      set_target '3' 'x86_64' '' 'linux' 'android' '' 'x86_64' '64' $CG0 $CG1
      ;;
    la8|la64|a*64-linux|a*64-*gnu|a*64-linux-gnu)
      set_target '4' 'aarch64' '' 'linux' 'gnu' '' 'aarch64' '64' $CY0 $CY1;;
    la7|lahf|arm*hf|arm-linux*|rpi*32|rpi2*)
      set_target '5' 'arm' '' 'linux' 'gnu' 'eabihf' 'armv7' '32' $CY0 $CY1;;
    l86|lx86|*86-linux*|linux*32 )
      set_target '6' 'i686' '' 'linux' 'gnu' '' 'x86' '32' $CM0 $CM1;;
    l64|lx64|*64-linux*|linux*64|linux )
      set_target '7' 'x86_64' '' 'linux' 'gnu' '' 'x86_64' '64' $CM0 $CM1
      ;;
    wa8|a*64-w64*|a*64-*mingw*)
      set_target '8' 'aarch64' '' 'w64' 'mingw32' '' 'arm64' '64' $CC0 $CC1;;
    wa7|arm*-w64*|arm*-*mingw*)
      set_target '9' 'arm' 'v7' 'w64' 'mingw32' '' 'armv7' '32' $CC0 $CC1;;
    w86|wx86|*86-win*|*86-*mingw*|w*32)
      set_target '10' 'i686' '' 'w64' 'mingw32' '' 'x86' '32' $CB0 $CB1;;
    w64|wx64|*64-win*|*64-*mingw*|windows|win|w*64)
      set_target '10' 'i686' '' 'w64' 'mingw32' '' 'x86' '32' $CB0 $CB1
      ;;
    
    --help|-h)  showBanner; usage; exit 0
      ;;
    
    --full|--all) build_shared=true; build_static=true; build_bin=true; build_dist=true; dep_build="--both --bin";;
    --shared)   build_shared=true; build_static=false;;
    --static)   build_static=true; build_shared=false;;
    --both)     build_static=true; build_shared=true;;
    --bin)      build_bin=true;;
    --no-bin)   build_bin=false;;
    --no-dist)  build_dist=false;;
    --no-strip) build_strip=false;;
    --api)      shift; export API=$1;;
    --clang)    use_clang=true;;
    --tune)     shift; menu_tune $1
      ;;

    --prefix)   shift; dir_install=$1; LIBSDIR=$1;;
    --stable)   git_stable=true;;
    
    --update)   update=true;;
    --upd-all)  update=true; req_update_deps=true;;
    --opts)     showOpts "$(pwd)/sources/$lib"; exit 0;;
    --checkPkg) checkPkg; exit 0;;
    --libName)  echo "${lib}"; exit 0;;
    --var)      shift; echo "$($1)"; exit 0;;
    --refresh)  update=true;;
    --retry)    retry=true;;
    --force)    [ -f "${dir_install_pc}/${pkg}.pc" ] && rm "${dir_install_pc}/${pkg}.pc" 2>/dev/null;;
    
    --clear)    shift; menu_clear $@; exit 0;;
    --desc )    echo $dsc && exit 0;;
    
    --get)      shift; menu_get $@; exit 0;;
      
    --clone)    only_repo=true;;   
    --cmake)    cfg='cmake';;
    --ndkcmake) ndkcmake=true;;
    --ccmake)   cfg='ccm';;
    --nobanner) banner=false;;
    --nodev)    nodev=true;;
    
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


[ -z ${mingw_posix} ] && mingw_posix=false

# Set default Host

if [ -z "${target_trip}" ];then
  target_trip[5]=$(uname -m)
  arch="${target_trip[5]}-${OSTYPE}"
  target_trip[0]=${target_trip[5]}
  if [ "${target_triple[0]::3}" == "arm" ]; then
    target_trip[1]="${target_triple[0]:3}"
    target_trip[0]="${target_triple[0]::3}"
  fi
  local arr=(${OSTYPE//-/ })
  target_trip[2]=$arr[0]
  target_trip[3]=$arr[1]
  if [ -z "${target_trip[3]##*eabi*}" ] ;then
    local a2=${target_trip[3]%eabi*}
    target_trip[4]=${target_trip[3]#${a2}*}
    target_trip[3]=${a2}
  fi
  set_env
fi

# is cross-compile?
[ "${build_arch}" == "${arch}" ] && host_cross=false || host_cross=true

loadToolchain

if [ -z "$ISRUNNING" ]; then
  showBanner
  export ISRUNNING=1
fi
if [ -n "${sudo}" ] && ! ${sudo} -n true 2>/dev/null; then
  echo -ne "${ind}${CY1}Requesting sudo for tool install "
  ${sudo} echo -ne "\r                                   "
fi


# check build type and set defaults if no cst0 cst1 csh0 or csh1 value provided
case $cfg in
  cm|ccm|cmake|ccmake)
    build_tool=cmake
    [ -n "$cstk" ] && cst0="-D${cstk}=OFF" cst1="-D${cstk}=ON"
    [ -n "$cshk" ] && csh0="-D${cshk}=OFF" csh1="-D${cshk}=ON"
    
    [ -z "$cst1" ] && cst1="-DBUILD_SHARED_LIBS=OFF"
    [ -z "$csh1" ] && csh1="-DBUILD_SHARED_LIBS=ON"
    
    $build_static && ! $build_shared && CSH="${cst1} ${csh0}"
    $build_shared && ! $build_static && CSH="${csh1} ${cst0}"
    $build_static && $build_shared && CSH="${cst1} ${csh1}"
    
    [ -n "$cbk" ] && cb0="-D${cbk}=OFF" cb1="-D${cbk}=ON"

    ;;
  ab|am|ac|ar|ag|auto*)
    build_tool=automake
    [ -z "$cst0" ] && cst0="--disable-static"
    [ -z "$cst1" ] && cst1="--enable-static"
    [ -z "$csh0" ] && csh0="--disable-shared"
    [ -z "$csh1" ] && csh1="--enable-shared"
    $build_static && ! $build_shared && CSH="${cst1} ${csh0}"
    $build_shared && ! $build_static && CSH="${csh1} ${cst0}"
    $build_static && $build_shared && CSH="${cst1} ${csh1}"
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

if [ -z "${CBN}" ];then
  $build_bin && CBN="${cb1}" || CBN="${cb0}"
fi

# reset presets, we don't need them anymore
unset cst0 cst1 csh0 csh1 cb0 cb1 cstk cshk cbk

export arch update retry \
  build_shared build_static build_bin build_tool \
  dir_install \
  CSH CBN LIBSDIR PLATFORM CPU ABI EABI \
  host_arch host_64 host_eabi host_vnd host_arm host_os \
  mingw_posix MAKE_EXECUTABLE=make cmake_includes

main