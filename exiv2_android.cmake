# Enable NEON for all ARM processors
set(ANDROID_ARM_NEON TRUE)
include("$ENV{ANDROID_NDK_HOME}/build/cmake/android.toolchain.cmake")
set(CMAKE_SYSTEM_NAME "Android")