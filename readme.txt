Build status:
    bit 0   build static ok
    bit 1   build shared ok
    bit 2   build bin ok
    *       build static OR shared at a time

            android      linux        windows
            a8 a7 86 64  a8 a7 86 64  86 64 
    aom     3  3  3  3   3  3  3  3   3  3
aribb24     3  3  3  3   3  3  F  3   .  3
avisynth    2
bzip        
celt        ok
chromaprint 3* 3* 3* 3*
cmake
codec2      3  3  3  3   3  3  3  3   .  3
daala       3
dav1d       7  7  7  7
davs2       7  7  7  7   7  7  F  7   .  .

libde265
libheif
libjpeg
libpng
ogg
vorbis
x265
zlib


todo:
json package-stat file