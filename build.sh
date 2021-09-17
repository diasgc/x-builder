#!/bin/bash
C0="\e[0m" CW="\e[97m" CD="\e[90m"
CR0="\e[31m" CR1="\e[91m"
CG0="\e[32m" CG1="\e[92m"
CY0="\e[33m" CY1="\e[93m"
CB0="\e[34m" CB1="\e[94m"
CM0="\e[35m" CM1="\e[95m"
CC0="\e[36m" CC1="\e[96m"

[ "${1}" == "--debug" ] && shift && set -x

archs=
sh=$1 && shift
args=
while test ${#} -gt 0; do
    case $1 in
        android) archs="aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android";;
        linux) archs="aarch64-linux-gnu arm-linux-gnuhfeabi i686-linux-gnu x86_64-linux-gnu";;
        windows) archs="i686-w64-mingw32 x86_64-w64-mingw32";;
        all) archs="aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android i686-linux-gnu x86_64-linux-gnu i686-w64-mingw32 x86_64-w64-mingw32";;
        *-android*|*-linux-gnu*|*-mingw32) archs="$archs $1";;
        --*) args="$args $1";;
    esac
    shift
done

echo -e "  Build ${sh}.sh <${args}> for ${CG0}${archs}${C0}"

opts=
for arch in $archs; do
    ./${sh}.sh ${arch} ${args} ${opts}
    opts="--nobanner"
done