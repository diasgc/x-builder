# xbuilder.cmake

# 2021 diasgc
# CMake cross-config file for X-Builder

set(XB_HOST $ENV{arch})
set(XB_OS $ENV{host_os})
set(XB_INSTALL $ENV{LIBSDIR})
set(XB_SYSROOT $ENV{SYSROOT})
set(XB_NDK_API $ENV{API})
set(XB_ABI $ENV{ABI})
set(XB_CPU $ENV{CPU})
set(XB_CMAKE_INCLUDES $ENV{cmake_includes})
set(XB_ARMLINUX_TCVERSION 11)
set(XB_X86LINUX_TCVERSION 10)
set(XB_W64MINGW_TCVERSION 10)

if($ENV{f_win_posix})
    set(XB_W64POSIX "-posix")
else()
    set(XB_W64POSIX "")
endif()

if(NOT XB_NDK_API)
    set(XB_NDK_API 24)
endif()

# message("XB_CMAKE_INCLUDES=${XB_CMAKE_INCLUDES} XB_POSIX=${XB_POSIX}")

if(XB_OS STREQUAL "android")

    set(CMAKE_SYSTEM_NAME Android)
    if(XB_HOST MATCHES "^arm")
        set(CMAKE_SYSTEM_PROCESSOR armv7-a)
    else()
        set(CMAKE_SYSTEM_PROCESSOR ${XB_CPU})
    endif()
    set(ANDROID_ABI ${XB_ABI})
    set(ANDROID_PLATFORM ${XB_NDK_API})
    set(ANDROID_NDK $ENV{ANDROID_NDK_HOME})
    set(CMAKE_FIND_ROOT_PATH ${XB_SYSROOT}/usr 
        ${XB_SYSROOT}/usr/lib/${XB_HOST} ${XB_SYSROOT}/usr/lib/${XB_HOST}/${XB_NDK_API} ${XB_INSTALL})
    include(${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
    
elseif(XB_OS STREQUAL "gnu")

    set(CMAKE_SYSTEM_NAME Linux)
    set(CMAKE_SYSTEM_PROCESSOR ${XB_CPU})
    if(XB_HOST MATCHES "^a")
        set(CMAKE_FIND_ROOT_PATH /usr/${XB_HOST} ${XB_INSTALL}
            /usr/lib/gcc-cross/${XB_HOST}/${XB_ARMLINUX_TCVERSION})
    elseif(XB_HOST MATCHES "^i")
        set(CMAKE_C_FLAGS "-m32")
        set(CMAKE_CXX_FLAGS "-m32")
        set(CMAKE_FIND_ROOT_PATH /usr/${XB_HOST} ${XB_INSTALL}
            /usr/lib/gcc-cross/${XB_HOST}/${XB_X86LINUX_TCVERSION})
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

elseif(XB_OS STREQUAL "mingw32")

    set(CMAKE_SYSTEM_NAME Windows)
    set(CMAKE_SYSTEM_PROCESSOR ${XB_CPU})
    set(CMAKE_FIND_ROOT_PATH /usr/${XB_HOST} ${XB_INSTALL}
        /usr/lib/gcc/${XB_HOST}/${XB_W64MINGW_TCVERSION})
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
    set(CMAKE_C_COMPILER ${XB_HOST}-gcc${XB_W64POSIX})
    set(CMAKE_CXX_COMPILER ${XB_HOST}-g++${XB_W64POSIX})
    set(CMAKE_AR ${XB_HOST}-ar CACHE FILEPATH Archiver)
    set(CMAKE_RANLIB ${XB_HOST}-ranlib CACHE FILEPATH Indexer)
    set(CMAKE_RC_COMPILER ${XB_HOST}-windres)
    set(CMAKE_MC_COMPILER ${XB_HOST}-windmc)
    set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic")
    set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".lib" ".a")

endif()

if(XB_CMAKE_INCLUDES)
    include_directories(XB_CMAKE_INCLUDES)
endif()