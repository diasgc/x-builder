set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR i686)
set(CMAKE_C_COMPILER gcc)
set (CMAKE_C_FLAGS "-m32")
set(CMAKE_CXX_COMPILER g++)
set (CMAKE_CXX_FLAGS "-m32")
# where is the target environment
set (CMAKE_FIND_ROOT_PATH /usr)
# search for programs in the build host directories
set (CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# for libraries and headers in the target directories
set (CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set (CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)