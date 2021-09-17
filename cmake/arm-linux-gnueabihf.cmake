set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)
# where is the target environment
set (CMAKE_FIND_ROOT_PATH /usr/arm-linux-gnueabihf /usr/lib/gcc-cross/arm-linux-gnueabihf/9)
# search for programs in the build host directories
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
# binutils
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
set(CMAKE_AR arm-linux-gnueabihf-ar CACHE FILEPATH Archiver)
set(CMAKE_RANLIB arm-linux-gnueabihf-ranlib CACHE FILEPATH Indexer)


# set(CMAKE_SYSTEM_VERSION 1)
# set(PLATFORM_ARM "1")
# set(PLATFORM_COMPILE_DEFS "COMPILE_GLES")
# Specify raspberry triple
# set(CROSS_FLAGS "--target=${TARGET_TRIPLE}")
# Specify other raspberry related flags
# set(RASP_FLAGS "-D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS")
# Gather and distribute flags specified at prev steps.
# set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${CROSS_FLAGS} ${RASP_FLAGS}")
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${CROSS_FLAGS} ${RASP_FLAGS}")
# set(CMAKE_EXE_LINKER_FLAGS ${CMAKE_EXE_LINKER_FLAGS} -fuse-ld=lld)