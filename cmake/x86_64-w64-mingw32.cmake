set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)
# where is the target environment
set (CMAKE_FIND_ROOT_PATH /usr/x86_64-w64-mingw32 /usr/lib/gcc/x86_64-w64-mingw32/9.3-posix)
# search for programs in the build host directories
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
# binutils
set(CMAKE_C_COMPILER x86_64-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER x86_64-w64-mingw32-g++)
set(CMAKE_AR x86_64-w64-mingw32-ar CACHE FILEPATH Archiver)
set(CMAKE_RANLIB x86_64-w64-mingw32-ranlib CACHE FILEPATH Indexer)
set(CMAKE_RC_COMPILER x86_64-w64-mingw32-windres)
set(CMAKE_MC_COMPILER x86_64-w64-mingw32-windmc)

set(CMAKE_FIND_LIBRARY_PREFIXES "lib" "")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".dll" ".dll.a" ".lib" ".a")