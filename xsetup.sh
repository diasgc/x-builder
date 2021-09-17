#!/bin/bash
# ................................................
# setup util 1.0 2021-diasgc
# ................................................

# def colors
C0="\e[0m" CW="\e[97m" CD="\e[90m"
CR0="\e[31m" CR1="\e[91m"
CG0="\e[32m" CG1="\e[92m"
CY0="\e[33m" CY1="\e[93m"
CB0="\e[34m" CB1="\e[94m"
CM0="\e[35m" CM1="\e[95m"
CC0="\e[36m" CC1="\e[96m"

vsh="1.0"
#b="\u25ba"
b="\u2605"

sudo echo -ne "\r" || exit 1

[ "$1" == "--debug" ] && shift && set -x

banner(){
    echo -ne "\n\n  ${CW}Setup Utility for XSh Scripts ${vsh}${C0}\n  "
    echo -ne "Running on $(uname -m) $(uname -o) "
    [ -n $(which lsb_release) ] && echo -ne "$(lsb_release -sd) "
    if [ -n "$(uname -r | grep 'microsoft')" ];then
        echo -ne "${CD}WSL2 "
    elif [ -n "$(uname -r | grep 'Microsoft')" ];then
        echo -ne "${CD}WSL "
    else
        echo -ne "${CD} "
    fi
    echo -e "$(uname -r)${C0}\n"
}

aptInstall(){
    local showV=1
    [ "$1" == "--nover" ] && showV= && shift
    local v=
    if [ $showV ]; then
        while [ "$1" != "" ];do
            v="${C0}install ${1}"
            echo -ne "  ${v} "
            sudo apt -qq install $1 -y >/dev/null 2>&1
            echo -ne "\e[${#v}D${CC0}${1}${C0} $(apt-cache show $1 | grep Version)"
            shift
        done
    else
        while [ "$1" != "" ];do
            v="${C0}${1}"
            echo -ne " ${v}    "
            sudo apt -qq install $1 -y >/dev/null 2>&1
            echo -ne "\e[${#v}D${CC0}${1}${C0} "
            shift
        done
    fi
    echo
}

# usage: check4Pkg label binName pkgName
checkPackage(){
    if [ $(which ${2}) ];then
        local v0=$(apt-cache policy ${3} | grep -Po '(Installed:).\K.*')
        local v1=$(apt-cache policy ${3} | grep -Po '(Candidate:).\K.*')
        if [ $v0=$v1 ]; then
            echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0} (latest)"
        else
            echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0}\t\t${v1}"
        fi
    else
        echo -ne "${CR0}  ${b} ${1}${C0}\t" && tput sc && echo -ne "not installed.\t" && read -p 'Install now? [Y|n]' ca
        [ $ca=y ] && tput rc && shift && shift && aptInstall --nover $@
    fi
}

# usage: check4Pkg [--pkg] label [binName] pkgName...
check4Pkg(){
    if [ "${1}" == "--pkg" ];then
        shift
        local v0=$(dpkg-query -W ${2} 2>/dev/null | cut -f2)
        if [ -n "${v0}" ];then
            local v1=$(apt-cache madison ${2} | cut -d'|' -f2 | xargs)
            if [ $v0=$v1 ]; then
                echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0} (latest)"
            else
                echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0}\t\t${v1}"
            fi
        else
            echo -ne "${CR0}  ${b} ${1}${C0}\t" && tput sc && echo -ne "not installed.\t" && read -p 'Install now? [Y|n]' ca
            [ $ca=y ] && tput rc && shift && aptInstall --nover $@
        fi
    else
        if [ $(which $2) ];then
            local v0=$(dpkg-query -W ${3} 2>/dev/null | cut -f2)
            local v1=$(apt-cache madison ${3} | cut -d'|' -f2 | xargs)
            #local v0=$(apt-cache policy ${3} | grep -Po '(Installed:).\K.*')
            #local v1=$(apt-cache policy ${3} | grep -Po '(Candidate:).\K.*')
            if [ "$v0" == "$v1" ]; then
                echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0} (latest)"
            else
                echo -e "${CC0}  ${b} ${1}${C0}\t\t${v0}\t\t${v1}"
            fi
        else
            echo -ne "${CR0}  ${b} ${1}${C0}\t" && tput sc && echo -ne "not installed.\t" && read -p 'Install now? [Y|n]' ca
            [ $ca=y ] && tput rc && shift && shift && aptInstall --nover $@
        fi
    fi
}


#usage getAndroidNdkHomeVersion <androidNdkHomePath>
getAndroidNdkHomeVersion(){
    cat ${1}/source.properties | grep "^Pkg.Revision = " | sed 's/Pkg.Revision = //'
}

getAndroidNdkLatestAvailableVersion(){
    echo $(wget -qO- https://developer.android.com/ndk/downloads | grep ndkVersion | tr ' ' '\n' | tail -n1 | sed 's/"//g')
}

getAndroidNdkLatestDownloadUrl(){
    wget -qO- https://developer.android.com/ndk/downloads | grep -Po "https://dl.google.com/android/repository/android-ndk-r..-linux.zip"
}

# usage installNdk <version>
installNdk(){
    [ $(which unzip) ] || sudo apt -qq install unzip -y >/dev/null 2>&1
    echo -ne "${CM0} downloading... ${C0}"
    tput sc && echo -ne "\e[$(tput lines);0H${CY1}"
    [ -z "$ANDROID_HOME" ] && ANDROID_HOME="~/Android"
    [ ! -d "$ANDROID_HOME" ] && mkdir -p $ANDROID_HOME
    pushd $ANDROID_HOME >/dev/null
    wget --progress=dot $1 -O tmp.zip 2>&1 | grep --line-buffered "%" | sed -u -e "s,\.,,g" | awk '{printf("\r%4s %s eta:%s  ",$2,$1,$4)}'
    tput rc
    echo -ne "${CM0} decompressing... ${C0}"
    unzip tmp.zip >/dev/null 2>&1
    rm tmp.zip
    mv android-ndk-* android-ndk
    popd >/dev/null
    echo -ne "${CC0} done. ${C0}\r"
    export ANDROID_HOME ANDROID_NDK_HOME="$ANDROID_HOME/android-ndk"
    printf "\nexport ANDROID_HOME=$ANDROID_HOME\nexport ANDROID_NDK_HOME=$ANDROID_NDK_HOME\n" >> ~/.bashrc && source ~/.bashrc
    check4Ndk
}

function version_gt() { test "$(echo "$@" | tr " " "n" | sort -V | head -n 1)" != "$1"; }

#usage <toolchain-bin-dir> <clang-prefix> <binutil-prefix>
linkNdkBinR23(){
    ln -s "${1}/${2}-clang" "/usr/bin/${2}-clang"
    ln -s "${1}/${2}-clang++" "/usr/bin/${2}-clang++"
    ln -s "${1}/${2}-clang" "/usr/bin/${2}-as"
    ln -s "${1}/ld.lld" "/usr/bin/${2}-ld"
    ln -s "${1}/llvm-ar" "/usr/bin/${2}-ar"
    ln -s "${1}/llvm-nm" "/usr/bin/${2}-nm"
    ln -s "${1}/llvm-addr2line" "/usr/bin/${2}-addr2line"
    ln -s "${1}/llvm-objcopy" "/usr/bin/${2}-objcopy"
    ln -s "${1}/llvm-objdump" "/usr/bin/${2}-objdump"
    ln -s "${1}/llvm-ranlib" "/usr/bin/${2}-ranlib"
    ln -s "${1}/llvm-readelf" "/usr/bin/${2}-"
    ln -s "${1}/llvm-size" "/usr/bin/${2}-size"
    ln -s "${1}/llvm-strings" "/usr/bin/${2}-strings"
    ln -s "${1}/llvm-strip" "/usr/bin/${2}-strip"
    ln -s "${1}/llvm-windres" "/usr/bin/${2}-windres"
}

check4Ndk(){
    local latestNdk=$(getAndroidNdkLatestAvailableVersion)
    if [ ${ANDROID_NDK_HOME} ];then
        echo -e "${CC0}  ${b} Android NDK${C0}\t\t$(getAndroidNdkHomeVersion $ANDROID_NDK_HOME)\t\t${latestNdk}"
    else
        testVer=0
        ndkVer=
        testDir=
        ndkDir=
        files=$(find ~ -name "ndk-lldb")
        for file in $files; do
            testDir="$(dirname "$file")"
            testVer=$(getAndroidNdkHomeVersion $testDir)
            [ -z $ndkVer ] && ndkVer=$testVer && ndkDir=$testDir
            test "$(echo "$testVer $ndkVer" | tr " " "n" | sort -V | head -n 1)" != "$testVer" && ndkVer=$testVer && ndkDir=$testDir
        done
        if [ -n "$ndkDir" ] && [ -d "$ndkDir" ]; then
            echo -e "${CC0}  ${b} Android NDK${C0}\t\tfound at $ndkDir $ndkVer"
            [ -z "$(cat ~/.bashrc | grep 'ANDROID_NDK_HOME')" ] && printf "\nexport ANDROID_NDK_HOME=$ndkDir\n" >> ~/.bashrc && source ~/.bashrc
        else
            echo -e "${CR0}  ${b} Android NDK not found. ${C0}" && tput sc && read -p 'Install now? [Y|n]' ca
            [ $ca=y ] && tput rc && installNdk $latestNdk
        fi
    fi

    #if [ ! -f "/usr/bin/aarch64-linux-android-clang" ]; then
    #    #ln -s <src> <lnk>
    #    tc=${ANDROID_NDK_HOME}/toolchains/llvm/prebuilt/linux-x86_64
    #    linkNdkBinR23 ${tc}/bin aarch64-linux-android${api} aarch64-linux-android
    #    linkNdkBinR23 ${tc}/bin armv7a-linux-androideabi${api} arm-linux-androideabi
    #    linkNdkBinR23 ${tc}/bin i686-linux-android${api} i686-linux-android
    #    linkNdkBinR23 ${tc}/bin x86_64-linux-android${api} x86_64-linux-android
    #fi
}

banner

#ANDROID NDK
check4Ndk

#MINGW
check4Pkg 'MinGW-w64' 'x86_64-w64-mingw32-gcc' 'mingw-w64'

#ARM-GNU
check4Pkg 'Aarch64-GNU' 'aarch64-linux-gnu-gcc' 'gcc-aarch64-linux-gnu' 'g++-aarch64-linux-gnu' 'libstdc++-11-dev-arm64-cross'
check4Pkg 'Armhf-GNU' 'arm-linux-gnueabihf-gcc' 'gcc-arm-linux-gnueabihf' 'g++-arm-linux-gnueabihf' 'libstdc++6-armhf-cross'

#CMAKE
check4Pkg 'Cmake  ' 'cmake' 'cmake'
check4Pkg 'CCmake ' 'ccmake' 'cmake-curses-gui'
#Build Essential
check4Pkg --pkg 'BuildTools' 'build-essential'
#Automake
check4Pkg 'Automake ' 'automake' 'automake'
check4Pkg 'Autoconf ' 'autoconf' 'autoconf'
check4Pkg 'Autogen  ' 'autogen' 'autogen'
check4Pkg 'Autopoint' 'autopoint' 'autopoint'
check4Pkg 'Libtool  ' 'libtool' 'libtool-bin'
check4Pkg 'M4       ' 'm4' 'm4'
echo
check4Pkg 'NASM     ' 'nasm' 'nasm'
check4Pkg 'YASM     ' 'yasm' 'yasm'
check4Pkg 'PkgConfig' 'pkg-config' 'pkg-config'
check4Pkg 'Git      ' 'git' 'git'
check4Pkg 'Subversion' 'svn' 'subversion'
check4Pkg 'LZip     ' 'lzip' 'lzip'
check4Pkg 'Unzip    ' 'unzip' 'unzip'
echo
check4Pkg --pkg 'Gperf    ' 'gperf'
check4Pkg --pkg 'Bison    ' 'bison'
check4Pkg --pkg 'Texinfo  ' 'texinfo'
check4Pkg --pkg 'Patch  ' 'patch'

echo -e "\n${CC0}Done${C0}\n"