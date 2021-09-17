set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_PROCESSOR aarch64)
set(ANDROID_ABI arm64-v8a)
set(ANDROID_PLATFORM 24)
set(ANDROID_NDK $ENV{ANDROID_NDK_HOME})
include($ENV{ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake)