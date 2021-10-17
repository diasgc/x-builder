#!/bin/bash
#     Aa8 Aa7 A86 A64
# NDK + +  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='ffmpeg'
dsc='FFmpeg is the leading multimedia framework'
lic='GLP-2.0'
vrs='n4.5-dev^{}'
src='https://github.com/FFmpeg/FFmpeg.git'
cfg='ac'
eta='777'
mki='install'
cbk='able-programs'
ac_nohost=true
ac_nosysroot=true
ac_nopic=true

lst_inc=''
lst_lib=''
lst_bin=''

include_pkg(){
     extlibs+=" $1"
     dep+=" $2"
}

extraOpts(){
     if [ -f "${1}.sh" ];then
          extlibs+=" --enable-${1}"
          dep+=" $1"
     elif [ -f "lib${1}.sh" ]
     case $1 in
          aom|libaom) extlibs+=" --enable-libaom"; dep+=" aom";;
          aribb24|libaribb24) extlibs+=" --enable-libaribb24"; dep+=" aribb24";;
          celt|libcelt
          *) [ -f "${1}.sh" ] && extlibs+=" --enable-${1}"; dep+=" $1";;
     esac

}

. xbuilder.sh

$build_shared && CSH="--enable-shared --disable-static" || CSH="--disable-shared --enable-static"
extlibs="--enable-libmp3lame --enable-libvorbis --enable-libx265 --enable-libopus --enable-libaom --enable-jni --enable-frei0r --enable-gpl --enable-version3"
CFG="--arch=$CPU --target-os=${PLATFORM,,} --cc=$CC --ar=$AR --strip=$STRIP --enable-cross-compile --disable-inline-asm \
     --enable-lto --enable-runtime-cpudetect --disable-doc --disable-htmlpages --disable-ffplay --enable-opencl --enable-pic $extlibs" # --enable-opengl

[ "$host_os" == "android" ] && CPPFLAGS+=" -Ofast -fPIC -fPIE"
# make the log cleaner
CPPFLAGS+=" -Wno-implicit-const-int-float-conversion -Wno-deprecated-declarations"

start

# Filelist
# --------
# include/libavfilter/avfilter.h
# include/libavfilter/version.h
# include/libavfilter/buffersrc.h
# include/libavfilter/buffersink.h
# include/libswresample/swresample.h
# include/libswresample/version.h
# include/libavutil/hwcontext_vdpau.h
# include/libavutil/attributes.h
# include/libavutil/replaygain.h
# include/libavutil/opt.h
# include/libavutil/sha.h
# include/libavutil/parseutils.h
# include/libavutil/dict.h
# include/libavutil/hwcontext_opencl.h
# include/libavutil/error.h
# include/libavutil/pixfmt.h
# include/libavutil/hmac.h
# include/libavutil/buffer.h
# include/libavutil/hwcontext_videotoolbox.h
# include/libavutil/hwcontext_qsv.h
# include/libavutil/murmur3.h
# include/libavutil/avutil.h
# include/libavutil/intfloat.h
# include/libavutil/avassert.h
# include/libavutil/audio_fifo.h
# include/libavutil/mem.h
# include/libavutil/pixdesc.h
# include/libavutil/samplefmt.h
# include/libavutil/tx.h
# include/libavutil/tree.h
# include/libavutil/ripemd.h
# include/libavutil/film_grain_params.h
# include/libavutil/hwcontext_drm.h
# include/libavutil/blowfish.h
# include/libavutil/timecode.h
# include/libavutil/display.h
# include/libavutil/log.h
# include/libavutil/threadmessage.h
# include/libavutil/xtea.h
# include/libavutil/aes.h
# include/libavutil/md5.h
# include/libavutil/lzo.h
# include/libavutil/spherical.h
# include/libavutil/hwcontext_vulkan.h
# include/libavutil/hwcontext_dxva2.h
# include/libavutil/eval.h
# include/libavutil/base64.h
# include/libavutil/fifo.h
# include/libavutil/hwcontext_vaapi.h
# include/libavutil/file.h
# include/libavutil/channel_layout.h
# include/libavutil/common.h
# include/libavutil/hwcontext_d3d11va.h
# include/libavutil/cast5.h
# include/libavutil/downmix_info.h
# include/libavutil/mastering_display_metadata.h
# include/libavutil/bswap.h
# include/libavutil/dovi_meta.h
# include/libavutil/twofish.h
# include/libavutil/rc4.h
# include/libavutil/version.h
# include/libavutil/imgutils.h
# include/libavutil/ffversion.h
# include/libavutil/timestamp.h
# include/libavutil/video_enc_params.h
# include/libavutil/des.h
# include/libavutil/pixelutils.h
# include/libavutil/frame.h
# include/libavutil/hwcontext_cuda.h
# include/libavutil/hash.h
# include/libavutil/macros.h
# include/libavutil/tea.h
# include/libavutil/adler32.h
# include/libavutil/sha512.h
# include/libavutil/intreadwrite.h
# include/libavutil/bprint.h
# include/libavutil/encryption_info.h
# include/libavutil/motion_vector.h
# include/libavutil/random_seed.h
# include/libavutil/lfg.h
# include/libavutil/mathematics.h
# include/libavutil/hwcontext_mediacodec.h
# include/libavutil/hdr_dynamic_metadata.h
# include/libavutil/aes_ctr.h
# include/libavutil/stereo3d.h
# include/libavutil/avstring.h
# include/libavutil/rational.h
# include/libavutil/crc.h
# include/libavutil/cpu.h
# include/libavutil/time.h
# include/libavutil/avconfig.h
# include/libavutil/hwcontext.h
# include/libavutil/camellia.h
# include/libavdevice/avdevice.h
# include/libavdevice/version.h
# include/libswscale/swscale.h
# include/libswscale/version.h
# include/libavcodec/xvmc.h
# include/libavcodec/ac3_parser.h
# include/libavcodec/jni.h
# include/libavcodec/avcodec.h
# include/libavcodec/codec_desc.h
# include/libavcodec/vaapi.h
# include/libavcodec/packet.h
# include/libavcodec/dxva2.h
# include/libavcodec/codec_id.h
# include/libavcodec/d3d11va.h
# include/libavcodec/vdpau.h
# include/libavcodec/dirac.h
# include/libavcodec/avdct.h
# include/libavcodec/qsv.h
# include/libavcodec/version.h
# include/libavcodec/avfft.h
# include/libavcodec/mediacodec.h
# include/libavcodec/videotoolbox.h
# include/libavcodec/codec_par.h
# include/libavcodec/vorbis_parser.h
# include/libavcodec/dv_profile.h
# include/libavcodec/adts_parser.h
# include/libavcodec/codec.h
# include/libavcodec/bsf.h
# include/libavformat/avio.h
# include/libavformat/avformat.h
# include/libavformat/version.h
# lib/pkgconfig/libavcodec.pc
# lib/pkgconfig/libswscale.pc
# lib/pkgconfig/libavfilter.pc
# lib/pkgconfig/libavformat.pc
# lib/pkgconfig/libavdevice.pc
# lib/pkgconfig/libavutil.pc
# lib/pkgconfig/libswresample.pc
# lib/libavfilter.a
# lib/libavdevice.a
# lib/libavutil.a
# lib/libavcodec.a
# lib/libavformat.a
# lib/libswscale.a
# lib/libswresample.a
# share/ffmpeg/libvpx-1080p.ffpreset
# share/ffmpeg/ffprobe.xsd
# share/ffmpeg/libvpx-720p.ffpreset
# share/ffmpeg/libvpx-360p.ffpreset
# share/ffmpeg/libvpx-1080p50_60.ffpreset
# share/ffmpeg/examples/muxing.c
# share/ffmpeg/examples/transcode_aac.c
# share/ffmpeg/examples/filtering_video.c
# share/ffmpeg/examples/metadata.c
# share/ffmpeg/examples/resampling_audio.c
# share/ffmpeg/examples/encode_audio.c
# share/ffmpeg/examples/decode_video.c
# share/ffmpeg/examples/http_multiclient.c
# share/ffmpeg/examples/remuxing.c
# share/ffmpeg/examples/filter_audio.c
# share/ffmpeg/examples/extract_mvs.c
# share/ffmpeg/examples/vaapi_transcode.c
# share/ffmpeg/examples/hw_decode.c
# share/ffmpeg/examples/demuxing_decoding.c
# share/ffmpeg/examples/filtering_audio.c
# share/ffmpeg/examples/qsvdec.c
# share/ffmpeg/examples/avio_reading.c
# share/ffmpeg/examples/transcoding.c
# share/ffmpeg/examples/avio_list_dir.c
# share/ffmpeg/examples/Makefile
# share/ffmpeg/examples/vaapi_encode.c
# share/ffmpeg/examples/scaling_video.c
# share/ffmpeg/examples/encode_video.c
# share/ffmpeg/examples/README
# share/ffmpeg/examples/decode_audio.c
# share/ffmpeg/libvpx-720p50_60.ffpreset
# bin/ffmpeg
# bin/ffprobe
