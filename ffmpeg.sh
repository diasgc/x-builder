#!/bin/bash
# HEADER-----------------------------------
lib='ffmpeg'
dsc='A complete, cross-platform solution to record, convert and stream audio and video.'
lic='LGPL-3.0'
src='git://source.ffmpeg.org/ffmpeg.git'
sty='git'
cfg='ac'
tls=''
dep=''
eta='600'
pkg=

farg=
fgpl=
fnfr=
fvr3=
#archs="aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android aarch64-linux-gnu arm-linux-gnueabihf i686-linux-gnu x86_64-linux-gnu i686-w64-mingw32 x86_64-w64-mingw32"
audioc_opts="codec2 fdk-aac ladspa celt libgme libgsm libilbc lv2 modplug mp3lame opus pulse shine snappy speex twolame vorbis wavpack"
audiof_opts="rubberband chromaprint libbs2b flite soxr"
videoc_opts="aom dav1d rav1e svtav1 davs2 openjpeg rsvg theora vpx webp openh264 x264 kvazaar x265 xavs xavs2 xvidcore"
videof_opts="avisynth vapoursynth frei0r vidstab libcaca mysofa vmaf zimg zvbi"
subtit_opts="aribb24 ass fontconfig freetype fribidi tesseract"
net_opts="openssl libtls gnutls rtmp smbclient libsrt libssh"
misc_opts="bluray decklink dc1394 iec61883 libjack klvanc rabbitmq jni drm opencv openmpt openvino tensorflow v4l2 xml2 zmq mediacodec openal opengl pocketsphinx"
deft_opts="fdk-aac lv2 mp3lame opus pulse shine snappy speex twolame vorbis wavpack rubberband chromaprint libbs2b flite soxr \
  aom davs2 openjpeg theora vpx webp x264 kvazaar x265 xavs xavs2 xvidcore frei0r vidstab zimg aribb24 ass fontconfig freetype fribidi \
  tesseract gnutls bluray libjack openmpt v4l2 xml2 mediacodec openal opengl"
# -----------------------------------------

#echo -ne "\n  Checking all required tools...please wait"
#sudo apt update >/dev/null
#sudo apt -qq install build-essential dialog -y >/dev/null
#echo

archs=""

# check gnu-linux gcc/g++
[ -n "$(which gcc)" ] && [ -n "$(which g++)" ] && \
  archs="i686-linux-gnu x86_64-linux-gnu"

# check ndk linux-android clang/clang++
[ -n "$ANDROID_NDK_HOME" ] && \
  [ -f $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/clang ] && \
  [ -f $ANDROID_NDK_HOME/toolchains/llvm/prebuilt/linux-x86_64/bin/clang++ ] && \
  archs="$archs aarch64-linux-android arm-linux-androideabi i686-linux-android x86_64-linux-android"

# check x86_64-w64-mingw32 gcc/g++
[ -n "$(which x86_64-w64-mingw32-gcc)" ] && [ -n "$(which x86_64-w64-mingw32-g++)" ] && \
  archs="$archs x86_64-w64-mingw32"

# check i686-w64-mingw32 gcc/g++
[ -n "$(which i686-w64-mingw32-gcc)" ] && [ -n "$(which i686-w64-mingw32-g++)" ] && \
  archs="$archs i686-w64-mingw32"

# check aarch64-linux-gnu-gcc gcc/g++
[ -n "$(which aarch64-linux-gnu-gcc)" ] && [ -n "$(which aarch64-linux-gnu-g++)" ] && \
  archs="$archs aarch64-linux-gnu"

# check arm-linux-gnueabihf gcc/g++
[ -n "$(which arm-linux-gnueabihf-gcc)" ] && [ -n "$(which arm-linux-gnueabihf-g++)" ] && \
  archs="$archs arm-linux-gnueabihf"

setArg(){
  farg+=" --enable-$1" && shift
  [ -n "$1" ] && dep+=" $1" && shift
  while [ -n "$1" ];do
    case $1 in
      gpl ) fgpl="--enable-gpl" lic='GPL-3.0';;
      version3 ) fvr3="--enable-version3";;
      nonfree ) fnfr="--enable-nonfree" lic='Non-free';;
    esac
    shift
  done
}

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
  out=$(dialog --clear --backtitle "FFMPEG Configuration Wizard" --title "$wtitle" \
    --menu "$mtitle:" 20 120 $cnt $menu 2>&1 >/dev/tty)
  echo ${vals[$out]}
}

dialogChecklist(){
  local cnt=0
  local i=1
  local wtitle=$1 && shift
  local mtitle=$1 && shift
  local inc="off"
  declare -a arr
  IFS=' ' read -r -a vals <<< "$@"
  while [ -n "$1" ];do
    arr[ $i ]=$cnt
    let cnt=cnt+1
    val=$1
    [ -f $1.sh ] && val="${val}: $(./$1.sh --desc)"
    arr[ ($i + 1) ]=${val}
    inc="off"
    [[ $deft_opts = *$1* ]] && inc="on"
    arr[ ($i + 2) ]=$inc
    (( i=($i+3) ))
    shift  
  done
  local out=$(dialog --clear --backtitle "FFMPEG Configuration Wizard" --title "$wtitle" \
    --checklist "$mtitle:" 20 120 $cnt "${arr[@]}" 2>&1 >/dev/tty)
  local outvals=
  for i in $out;do outvals="$outvals ${vals[$i]}"; done
  echo ${outvals}
}

runwiz(){
  export DIALOGRC="$(pwd)/.dialogrc"
  arch=$(dialogMenu Host 'Select Host Architecture' $archs )
  shared=$(dialogMenu "Build Type" 'Select Build Type' "Static" "Shared" )
  case $shared in
    Static) shared="";;
    Shared) shared="--shared";;
  esac
  pkgs=$(dialogChecklist "Audio Codecs" 'Select Audio Codecs to include' $audioc_opts)
  pkgs="$pkgs $(dialogChecklist "Audio Filters" 'Select Audio Filters to include' $audiof_opts)"
  pkgs="$pkgs $(dialogChecklist "Video Codecs" 'Select Video Codecs to include' $videoc_opts)"
  pkgs="$pkgs $(dialogChecklist "Video Filters" 'Select Video Filters to include' $videof_opts)"
  pkgs="$pkgs $(dialogChecklist "Subtitle" 'Select Subtitle options to include' $subtit_opts)"
  pkgs="$pkgs $(dialogChecklist "Internet" 'Select Internet options to include' $net_opts)"
  pkgs="$pkgs $(dialogChecklist "Miscellaneous" 'Select other options to include' $misc_opts)"
  clear
  ./ffmpeg.sh $arch $shared $pkgs
  exit
}

extraOpts(){
  case $1 in
    --wizard )       echo -e "\n  ${CY1}Welcome to FFMPEG Configuration Wizard ${C0}\n" && exit;;
    # gpl external libs
    avisynth )       setArg avisynth avisynth gpl ;;
    frei0r )         setArg frei0r frei0r gpl ;;
    *cdio )          setArg libcdio libcdio gpl ;;
    *davs2 )         setArg libdavs2 davs2 gpl ;;
    *rubberband )    setArg librubberband rubberband gpl ;;
    *vidstab )       setArg libvidstab vidstab gpl ;;
    *x264 )          setArg libx264 x264 gpl ;;
    *x265 )          setArg libx265 x265 gpl ;;
    *xavs )          setArg libxavs xavs gpl ;;
    *xavs2 )         setArg libxavs2 xavs2 gpl ;;
    *xvid* )         setArg libxvid xvidcore gpl ;;

    # non-free external libs
    decklink )       setArg decklink decklink nonfree ;;
    *fdk-aac )       setArg libfdk_aac fdk-aac nonfree ;;
    openssl )        setArg openssl openssl nonfree ;;
    libtls|tls )     setArg libtls tls nonfree ;;

    # version3 external libs
    gmp )            setArg gmp gmp version3 ;;
    *aribb24 )       setArg libaribb24 aribb24 version3 ;;
    *lensfun )       setArg liblensfun lensfun version3 ;;
    *opencore_amr* ) setArg libopencore_amrnb && setArg libopencore_amrwb opencore_amr version3 ;;
    *vo_amrwbenc )   setArg libvo_amrwbenc vo-amrwbenc version3 ;;
    mbedtls )        setArg mbedtls mbedtls version3 ;;
    rkmpp )          setArg rkmpp rkmpp version3 ;;
    
    *smbclient )     setArg libsmbclient smbclient ;;

    chromaprint )    setArg chromaprint chromaprint ;;
    gcrypt )         setArg gcrypt gcrypt ;;
    gnutls )         setArg gmp && setArg gnutls 'gmp nettle gnutls' ;;
    jni )            setArg jni ;;
    ladspa )         setArg ladspa ladspa ;;
    *aom )           setArg libaom aom ;;
    *ass )           setArg libass libass ;;
    *bluray )        setArg libbluray libbluray ;;
    *bs2b )          setArg libbs2b libbs2b ;;
    *caca )          setArg libcaca libcaca ;;
    *celt )          setArg libcelt celt ;;
    *codec2 )        setArg libcodec2 codec2 ;;
    *dav1d )         setArg libdav1d dav1d ;;
    *dc1394 )        setArg libdc1394 dc1394 ;;
    *drm )           setArg libdrm ;;
    *flite )         setArg libflite flite ;;
    *fontconfig )    setArg libfontconfig fontconfig ;;
    *freetype )      setArg libfreetype freetype ;;
    *fribidi )       setArg libfribidi fribidi ;;
    *glslang )       setArg libglslang glslang ;;
    *gme )           setArg libgme libgme ;;
    *gsm )           setArg libgsm libgsm ;;
    *iec61883 )      setArg libiec61883 libiec61883 ;;
    *ilbc )          setArg libilbc libilbc ;;
    *jack )          setArg libjack libjack ;;
    *klvanc )        setArg libklvanc libklvanc ;;
    *kvazaar )       setArg libkvazaar kvazaar ;;
    *modplug )       setArg libmodplug modplug ;;
    *mp3lame|*mp3 )  setArg libmp3lame lame ;;
    *mysofa )        setArg libmysofa libmysofa ;;
    *opencv )        setArg libopencv opencv ;;
    *openh264 )      setArg libopenh264 openh264 ;;
    *openjpeg )      setArg libopenjpeg openjpeg ;;
    *openmpt )       setArg libopenmpt openmpt ;;
    *openvino )      setArg libopenvino openvino ;;
    *opus )          setArg libopus 'ogg vorbis opus' ;;
    *pulse )         setArg libpulse libpulse ;;
    *rabbitmq )      setArg librabbitmq librabbitmq ;;
    *rav1e )         setArg librav1e rav1e ;;
    *rsvg )          setArg librsvg rsvg ;;
    *rtmp )          setArg librtmp rtmp ;;
    *shine )         setArg libshine shine ;;
    *smbclient )     setArg libsmbclient smbclient ;;
    *snappy )        setArg libsnappy snappy ;;
    *soxr )          setArg libsoxr soxr ;;
    *speex )         setArg libspeex speex ;;
    *srt )           setArg libsrt libsrt ;;
    *ssh )           setArg libssh libssh ;; 
    *svtav1 )        setArg libsvtav1 svtav1 ;; 
    *tensorflow )    setArg libtensorflow tensorflow ;; 
    *tesseract )     setArg libtesseract tesseract ;; 
    *theora )        setArg libtheora theora ;; 
    *twolame )       setArg libtwolame twolame ;; 
    *v4l2 )          setArg libv4l2 ;; 
    *vmaf )          setArg libvmaf vmaf ;; 
    *vorbis )        setArg libvorbis vorbis ;; 
    *vpx )           setArg libvpx vpx ;; 
    *wavpack )       setArg libwavpack wavpack ;; 
    *webp )          setArg libwebp libwebp ;; 
    *xml2 )          setArg libxml2 libxml2 ;; 
    *zimg )          setArg libzimg zimg ;; 
    *zmq )           setArg libzmq zmq ;; 
    *zvbi )          setArg libzvbi zvbi ;; 
    lv2 )            setArg lv2 ;; 
    mediacodec )     setArg mediacodec ;; 
    openal )         setArg openal ;; 
    opengl )         setArg opengl ;; 
    pocketsphinx )   setArg pocketsphinx pocketsphinx ;; 
    vapoursynth )    setArg vapoursynth vapoursynth ;;
    * ) echo -e "${CR0}Unknown option ${CR1}${1}${C0}" && exit 1;;
  esac
}

# always run wizard if no args supplied
if [ $# -eq 0 ];then
  runwiz
  exit
fi

# enable main toolchain util
. tcutils.sh

# requided defs
CFG="--disable-doc --disable-htmlpages --disable-manpages --disable-txtpages --disable-podpages \
  --enable-version3 --enable-iconv --enable-optimizations"
CSH="--enable-static --disable-shared --enable-pic"
CBN=
dbld=$SRCDIR

if [[ $bshared ]];then
  [[ $bshared -eq 1 ]] && CSH="--disable-static --enable-shared"
  [[ $bshared -eq 0 ]] && CSH="--enable-static --disable-shared --enable-pic"
fi
if [[ $bbin ]];then
  [[ $bbin -eq 1 ]] && CBN=
  [[ $bbin -eq 0 ]] && CBN=
fi

# HEADER-----------------------------------

loadToolchain
case $arch in
  aarch64-linux-android )CFG="--cpu=armv8-a --arch=aarch64 --target-os=android --enable-neon --enable-asm --enable-inline-asm --cc=$CC --cxx=$CXX --cross-prefix=${CROSS_PREFIX} --sysroot=$SYSROOT $CFG";;
  arm-linux-androideabi )CFG="--cpu=armv7-a --arch=armv7-a --target-os=android --enable-neon --enable-asm --enable-inline-asm --cc=$CC --cxx=$CXX --cross-prefix=${CROSS_PREFIX} --sysroot=$SYSROOT $CFG";;
  i686-linux-android )CFG="--cpu=i686 --arch=i686 --target-os=android --disable-neon --disable-asm --disable-inline-asm --cc=$CC --cxx=$CXX --cross-prefix=${CROSS_PREFIX} --sysroot=$SYSROOT $CFG";;
  x86_64-linux-android )CFG="--cpu=x86_64 --arch=x86_64 --target-os=android --disable-neon --enable-asm --enable-inline-asm --cc=$CC --cxx=$CXX --cross-prefix=${CROSS_PREFIX} --sysroot=$SYSROOT $CFG";;
  *-w64-mingw32 )CFG="--arch=${ABI} --target-os=mingw32 --cross-prefix=${CROSS_PREFIX} $CFG";;
  x86_64-linux-gnu ) CFG="--arch=amd64 $CFG";;
  xi686-linux-gnu ) CFG="--arch=x86 $CFG";;
esac

# Required function buildSrc
buildSrc(){
	gitClone $src $lib
}

# Required function buildLib
buildLib(){
  
  ${MAKE_EXECUTABLE} distclean >/dev/null 2>&1

  for i in $dep; do
    cp -rf $LIBSDIR/$i/* $INSTALL_DIR
  done

  export PKG_CONFIG_PATH=$PKGDIR
  export CFLAGS+=" -march=native -I$INSTALL_DIR/include"
  export LDFLAGS+=" -L$INSTALL_DIR/lib"

  log configure
  logme $SRCDIR/configure --prefix=${INSTALL_DIR} --pkg-config="$(which pkg-config)" $CFG \
    $CSH $CBN $farg $fgpl $fnfr $fvr3 --extra-libs="-lpthread -lm" --pkg-config-flags="--static"
  
  log make
  logme ${MAKE_EXECUTABLE} -j${HOST_NPROC}

  log install
  logme ${MAKE_EXECUTABLE} install
}
start