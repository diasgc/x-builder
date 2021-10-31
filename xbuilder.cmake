# xbuilder.cmake

# 2021 diasgc
# CMake cross-config file for X-Builder

set(XB_HOST $ENV{arch})
set(XB_OS $ENV{host_os})
set(XB_INSTALL $ENV{LIBSDIR})
set(XB_SYSROOT $ENV{SYSROOT})
set(XB_CROSS_PREFIX $ENV{CROSS_PREFIX})
set(XB_LT_SYS_LIBRARY_PATH $ENV{LT_SYS_LIBRARY_PATH})
set(XB_NDK_API $ENV{API})
set(XB_ABI $ENV{ABI})
set(XB_CPU $ENV{CPU})
set(XB_CMAKE_INCLUDES $ENV{cmake_includes})
set(XB_LLVM_MINGW_HOME $ENV{LLVM_MINGW_HOME})
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

if(XB_OS STREQUAL "android")
    set(CMAKE_SYSTEM_NAME "Android")
    set(CMAKE_SYSTEM_PROCESSOR "armv7-a")
    if(XB_HOST MATCHES "^arm")
        set(CMAKE_SYSTEM_PROCESSOR "armv7-a")
    else()
        set(CMAKE_SYSTEM_PROCESSOR "${XB_CPU}")
    endif()
    set(ANDROID_ABI ${XB_ABI})
    set(ANDROID_PLATFORM ${XB_NDK_API})
    set(ANDROID_NDK $ENV{ANDROID_NDK_HOME})
    set(CMAKE_C_COMPILER $ENV{CC})
    set(CMAKE_CXX_COMPILER $ENV{CXX})
    set(CMAKE_FIND_ROOT_PATH ${XB_SYSROOT}/usr
        ${XB_SYSROOT}/usr/lib/${XB_HOST}
        ${XB_SYSROOT}/usr/lib/${XB_HOST}/${XB_NDK_API}
        ${XB_INSTALL})
    
    set(ZLIB_INCLUDE_DIRS ${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/include)
    set(ZLIB_LIBRARIES ${ANDROID_NDK}/toolchains/llvm/prebuilt/linux-x86_64/sysroot/usr/lib/${XB_HOST})
    set(ZLIB_VERSION_STRING 1.2.11)
    include(${ANDROID_NDK}/build/cmake/android.toolchain.cmake)
    
elseif(XB_OS STREQUAL "gnu")

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

elseif(XB_OS STREQUAL "mingw32")
    set(CMAKE_SYSTEM_NAME Windows)
    set(CMAKE_SYSTEM_PROCESSOR ${XB_CPU})
    set(CMAKE_COMPILER_IS_MINGW ON)
    set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
    set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ALWAYS)
    set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    set(CMAKE_AR ${XB_CROSS_PREFIX}ar CACHE FILEPATH Archiver)
    set(CMAKE_RANLIB ${XB_CROSS_PREFIX}ranlib CACHE FILEPATH Indexer)
    set(CMAKE_C_COMPILER_AR "${CMAKE_AR}")
    set(CMAKE_CXX_COMPILER_AR "${CMAKE_AR}")
    set(CMAKE_C_COMPILER_RANLIB "${CMAKE_RANLIB}")
    set(CMAKE_CXX_COMPILER_RANLIB "${CMAKE_RANLIB}")
    set(CMAKE_RC_COMPILER ${XB_CROSS_PREFIX}windres)
    set(CMAKE_MC_COMPILER ${XB_CROSS_PREFIX}windmc)
    set(CMAKE_CXX_STANDARD_LIBRARIES "-static-libgcc -static-libstdc++ -lwsock32 -lws2_32 ${CMAKE_CXX_STANDARD_LIBRARIES}")
    set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,-Bstatic")
    set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
    set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".lib" ".a")
    if (XB_LLVM_MINGW_HOME)
        set(CMAKE_C_COMPILER ${XB_CROSS_PREFIX}clang)
        set(CMAKE_CXX_COMPILER ${XB_CROSS_PREFIX}clang++)
        set(CMAKE_FIND_ROOT_PATH ${XB_SYSROOT}  ${XB_LT_SYS_LIBRARY_PATH} ${XB_INSTALL})
    else()
        set(CMAKE_C_COMPILER ${XB_HOST}-gcc${XB_W64POSIX})
        set(CMAKE_CXX_COMPILER ${XB_HOST}-g++${XB_W64POSIX})
        set(CMAKE_FIND_ROOT_PATH ${XB_SYSROOT} ${XB_LT_SYS_LIBRARY_PATH} ${XB_INSTALL})
    endif()

endif()

set(CMAKE_C_FLAGS "$ENV{CPPFLAGS} $ENV{CFLAGS} ${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS "$ENV{CPPFLAGS} $ENV{CXXFLAGS} ${CMAKE_CXX_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "$ENV{LDFLAGS} ${CMAKE_EXE_LINKER_FLAGS}")

if(XB_CMAKE_INCLUDES)
    include_directories(XB_CMAKE_INCLUDES)
endif()