#!/bin/bash

lib='glslang'
dsc='OpenGL and OpenGL ES shader front end and validator'
lic='BSD-3c'
src='https://github.com/KhronosGroup/glslang.git'
cfg='cmake'
eta='72'
pc_llib='-lglslang -lOSDependent -lHLSL -lOGLCompiler -lSPVRemapper'

lst_inc='glslang/*.h glslang/Public/*.h glslang/Include/*.h glslang/MachineIndependent/*.h glslang/SPIRV/*.h glslang/HLSL/*.h'
lst_lib='libSPIRV.* libOSDependent.* libSPVRemapper.* libOGLCompiler.* libHLSL.* libglslang.* libglslang-default-resource-limits.*'
lst_bin='spirv-remap glslangValidator'
lst_lic='LICENSE.txt'
lst_pc='libSPIRV.pc libOSDependent.pc libSPVRemapper.pc libOGLCompiler.pc libHLSL.pc libglslang.pc libglslang-default-resource-limits.pc'

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF -DENABLE_OPT=OFF -DINSTALL_GTEST=OFF"

start

# cpu av8 av7 x86 x64
# NDK  .   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc