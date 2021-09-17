#!/bin/bash
# Aa8 Aa7 A86 A64 L64 W64 La8 La7 Wa8 W86 L86
#  .   .   .   .   .   .   .   .   .   .   .  static
#  .   .   .   .   .   .   .   .   .   .   .  shared
#  .   .   .   .   .   .   .   .   .   .   .  bin

lib='glslang'
dsc='OpenGL and OpenGL ES shader front end and validator'
lic='BSD-3c'
src='https://github.com/KhronosGroup/glslang.git'
sty='git'
cfg='cm'
eta='72'

. xbuilder.sh

CFG="-DBUILD_TESTING=OFF -DENABLE_OPT=OFF -DINSTALL_GTEST=OFF"

build_pkgconfig_file(){
  [ -z "$vrs" ] || setGitVrs
  cat <<-EOF >>$PKGDIR/${lib}.pc
		prefix=${INSTALL_DIR}
		exec_prefix=\${prefix}
		libdir=\${exec_prefix}/lib
		includedir=\${prefix}/include
		Name: ${lib}
		Description: ${dsc}
		Version: ${vrs}
		Requires:
		Libs: -L${libdir} -lglslang -lOSDependent -lHLSL -lOGLCompiler -lSPVRemapper
		Cflags: -I${includedir}
		EOF
}

start


# Filelist
# --------

# include/glslang/Include/SpirvIntrinsics.h
# include/glslang/Include/InfoSink.h
# include/glslang/Include/ShHandle.h
# include/glslang/Include/BaseTypes.h
# include/glslang/Include/intermediate.h
# include/glslang/Include/Types.h
# include/glslang/Include/InitializeGlobals.h
# include/glslang/Include/Common.h
# include/glslang/Include/ConstantUnion.h
# include/glslang/Include/glslang_c_shader_types.h
# include/glslang/Include/glslang_c_interface.h
# include/glslang/Include/PoolAlloc.h
# include/glslang/Include/arrays.h
# include/glslang/Include/ResourceLimits.h
# include/glslang/MachineIndependent/glslang_tab.cpp.h
# include/glslang/MachineIndependent/localintermediate.h
# include/glslang/MachineIndependent/SymbolTable.h
# include/glslang/MachineIndependent/Versions.h
# include/glslang/MachineIndependent/reflection.h
# include/glslang/MachineIndependent/ScanContext.h
# include/glslang/MachineIndependent/LiveTraverser.h
# include/glslang/MachineIndependent/RemoveTree.h
# include/glslang/MachineIndependent/attribute.h
# include/glslang/MachineIndependent/preprocessor/PpContext.h
# include/glslang/MachineIndependent/preprocessor/PpTokens.h
# include/glslang/MachineIndependent/iomapper.h
# include/glslang/MachineIndependent/gl_types.h
# include/glslang/MachineIndependent/parseVersions.h
# include/glslang/MachineIndependent/ParseHelper.h
# include/glslang/MachineIndependent/propagateNoContraction.h
# include/glslang/MachineIndependent/Initialize.h
# include/glslang/MachineIndependent/Scan.h
# include/glslang/build_info.h
# include/glslang/Public/ShaderLang.h
# include/glslang/SPIRV/GlslangToSpv.h
# include/glslang/SPIRV/SpvTools.h
# include/glslang/SPIRV/spirv.hpp
# include/glslang/SPIRV/GLSL.ext.EXT.h
# include/glslang/SPIRV/doc.h
# include/glslang/SPIRV/Logger.h
# include/glslang/SPIRV/GLSL.ext.KHR.h
# include/glslang/SPIRV/GLSL.std.450.h
# include/glslang/SPIRV/SpvBuilder.h
# include/glslang/SPIRV/spvIR.h
# include/glslang/SPIRV/GLSL.ext.NV.h
# include/glslang/SPIRV/NonSemanticDebugPrintf.h
# include/glslang/SPIRV/GLSL.ext.AMD.h
# include/glslang/SPIRV/bitutils.h
# include/glslang/SPIRV/disassemble.h
# include/glslang/SPIRV/SPVRemapper.h
# include/glslang/SPIRV/hex_float.h
# include/glslang/HLSL/hlslGrammar.h
# include/glslang/HLSL/hlslParseHelper.h
# include/glslang/HLSL/hlslTokens.h
# include/glslang/HLSL/hlslAttributes.h
# include/glslang/HLSL/hlslParseables.h
# include/glslang/HLSL/hlslScanContext.h
# include/glslang/HLSL/hlslTokenStream.h
# include/glslang/HLSL/hlslOpMap.h
# lib/pkgconfig/glslang.pc
# lib/libSPIRV.so
# lib/libOSDependent.a
# lib/libSPVRemapper.so
# lib/cmake/glslang-default-resource-limitsTargets-release.cmake
# lib/cmake/OSDependentTargets-release.cmake
# lib/cmake/spirv-remapTargets-release.cmake
# lib/cmake/HLSLTargets-release.cmake
# lib/cmake/spirv-remapTargets.cmake
# lib/cmake/glslangTargets.cmake
# lib/cmake/SPIRVTargets.cmake
# lib/cmake/SPVRemapperTargets-release.cmake
# lib/cmake/OSDependentTargets.cmake
# lib/cmake/glslangTargets-release.cmake
# lib/cmake/glslang-default-resource-limitsTargets.cmake
# lib/cmake/SPIRVTargets-release.cmake
# lib/cmake/glslangValidatorTargets.cmake
# lib/cmake/OGLCompilerTargets.cmake
# lib/cmake/SPVRemapperTargets.cmake
# lib/cmake/HLSLTargets.cmake
# lib/cmake/OGLCompilerTargets-release.cmake
# lib/cmake/glslangValidatorTargets-release.cmake
# lib/libglslang-default-resource-limits.so
# lib/libOGLCompiler.a
# lib/libHLSL.so
# lib/libglslang.so.11.6.0
# bin/spirv-remap
# bin/glslangValidator
