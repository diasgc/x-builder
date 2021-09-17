set(CMAKE_SYSTEM_NAME Android)
set(CMAKE_SYSTEM_PROCESSOR armv7-a)
set(ANDROID_ABI armeabi-v7a)
set(ANDROID_PLATFORM 24)
set(ANDROID_NDK $ENV{ANDROID_NDK_HOME})
include($ENV{ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake)