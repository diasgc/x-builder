#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   +.+ ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='openexr'
pkg='OpenEXR'
apt="${lib}-dev"
dsc='Specification and reference implementation of the EXR file format'
lic='BSD-2c'
src='https://github.com/AcademySoftwareFoundation/openexr.git' #src_opt='--recurse-submodules'
cfg='cmake'
eta='10'
cbk='OPENEXR_BUILD_TOOLS'
CFG="-DBUILD_TESTING=OFF -DOPENEXR_INSTALL_EXAMPLES=OFF"
lst_inc=''
lst_lib=''
lst_bin=''

. xbuilder.sh

start

# Filelist
# --------
# include/OpenEXR/ImfFlatImageLevel.h
# include/OpenEXR/ImfHuf.h
# include/OpenEXR/ImfChromaticitiesAttribute.h
# include/OpenEXR/IexExport.h
# include/OpenEXR/openexr_debug.h
# include/OpenEXR/ImfDeepImageIO.h
# include/OpenEXR/ImfRgbaYca.h
# include/OpenEXR/ImfArray.h
# include/OpenEXR/ImfFramesPerSecond.h
# include/OpenEXR/openexr_context.h
# include/OpenEXR/openexr_conf.h
# include/OpenEXR/ImfOpaqueAttribute.h
# include/OpenEXR/ImfRgbaFile.h
# include/OpenEXR/IlmThreadMutex.h
# include/OpenEXR/ImfDeepScanLineInputPart.h
# include/OpenEXR/IlmThreadExport.h
# include/OpenEXR/ImfDeepTiledInputFile.h
# include/OpenEXR/ImfFrameBuffer.h
# include/OpenEXR/ImfMatrixAttribute.h
# include/OpenEXR/ImfVersion.h
# include/OpenEXR/IexMathFloatExc.h
# include/OpenEXR/ImfStandardAttributes.h
# include/OpenEXR/IlmThreadSemaphore.h
# include/OpenEXR/ImfImage.h
# include/OpenEXR/ImfFlatImageChannel.h
# include/OpenEXR/ImfFloatVectorAttribute.h
# include/OpenEXR/ImfDeepCompositing.h
# include/OpenEXR/ImfForward.h
# include/OpenEXR/ImfIntAttribute.h
# include/OpenEXR/IexConfig.h
# include/OpenEXR/openexr_decode.h
# include/OpenEXR/ImfRgba.h
# include/OpenEXR/IlmThread.h
# include/OpenEXR/IexThrowErrnoExc.h
# include/OpenEXR/ImfDeepScanLineInputFile.h
# include/OpenEXR/ImfIDManifest.h
# include/OpenEXR/IexBaseExc.h
# include/OpenEXR/ImfDeepImage.h
# include/OpenEXR/ImfWav.h
# include/OpenEXR/ImfHeader.h
# include/OpenEXR/IexForward.h
# include/OpenEXR/ImfImageLevel.h
# include/OpenEXR/IexMacros.h
# include/OpenEXR/ImfCompression.h
# include/OpenEXR/ImfPartHelper.h
# include/OpenEXR/ImfDeepTiledOutputFile.h
# include/OpenEXR/ImfIO.h
# include/OpenEXR/ImfImageDataWindow.h
# include/OpenEXR/ImfChannelListAttribute.h
# include/OpenEXR/ImfName.h
# include/OpenEXR/OpenEXRConfig.h
# include/OpenEXR/ImfMultiPartOutputFile.h
# include/OpenEXR/ImfTiledOutputFile.h
# include/OpenEXR/ImfDeepScanLineOutputFile.h
# include/OpenEXR/ImfStringVectorAttribute.h
# include/OpenEXR/ImfInt64.h
# include/OpenEXR/ImfTiledRgbaFile.h
# include/OpenEXR/ImfTestFile.h
# include/OpenEXR/ImfTileDescription.h
# include/OpenEXR/ImfSampleCountChannel.h
# include/OpenEXR/ImfNamespace.h
# include/OpenEXR/ImfFlatImageIO.h
# include/OpenEXR/openexr_errors.h
# include/OpenEXR/ImfInputFile.h
# include/OpenEXR/openexr.h
# include/OpenEXR/IexMathExc.h
# include/OpenEXR/ImfUtilExport.h
# include/OpenEXR/ImfLineOrder.h
# include/OpenEXR/ImfDoubleAttribute.h
# include/OpenEXR/ImfLut.h
# include/OpenEXR/openexr_chunkio.h
# include/OpenEXR/ImfKeyCodeAttribute.h
# include/OpenEXR/ImfConvert.h
# include/OpenEXR/ImfTiledInputFile.h
# include/OpenEXR/ImfImageChannel.h
# include/OpenEXR/IlmThreadPool.h
# include/OpenEXR/ImfDeepImageState.h
# include/OpenEXR/ImfAttribute.h
# include/OpenEXR/IlmThreadNamespace.h
# include/OpenEXR/IexErrnoExc.h
# include/OpenEXR/ImfGenericOutputFile.h
# include/OpenEXR/ImfPreviewImageAttribute.h
# include/OpenEXR/ImfKeyCode.h
# include/OpenEXR/ImfDeepImageChannel.h
# include/OpenEXR/ImfTiledInputPart.h
# include/OpenEXR/ImfStdIO.h
# include/OpenEXR/openexr_std_attr.h
# include/OpenEXR/ImfDeepScanLineOutputPart.h
# include/OpenEXR/ImfIDManifestAttribute.h
# include/OpenEXR/ImfCheckFile.h
# include/OpenEXR/ImfImageChannelRenaming.h
# include/OpenEXR/ImfTileDescriptionAttribute.h
# include/OpenEXR/ImfBoxAttribute.h
# include/OpenEXR/ImfRational.h
# include/OpenEXR/IlmThreadConfig.h
# include/OpenEXR/ImfChromaticities.h
# include/OpenEXR/ImfDeepTiledInputPart.h
# include/OpenEXR/ImfDeepFrameBuffer.h
# include/OpenEXR/ImfTiledOutputPart.h
# include/OpenEXR/ImfPartType.h
# include/OpenEXR/ImfTimeCodeAttribute.h
# include/OpenEXR/ImfExport.h
# include/OpenEXR/ImfDeepTiledOutputPart.h
# include/OpenEXR/ImfMultiView.h
# include/OpenEXR/ImfGenericInputFile.h
# include/OpenEXR/ImfLineOrderAttribute.h
# include/OpenEXR/ImfEnvmapAttribute.h
# include/OpenEXR/ImfFloatAttribute.h
# include/OpenEXR/openexr_part.h
# include/OpenEXR/ImfCompressionAttribute.h
# include/OpenEXR/ImfMultiPartInputFile.h
# include/OpenEXR/Iex.h
# include/OpenEXR/openexr_attr.h
# include/OpenEXR/ImfCompositeDeepScanLine.h
# include/OpenEXR/ImfStringAttribute.h
# include/OpenEXR/IexNamespace.h
# include/OpenEXR/openexr_base.h
# include/OpenEXR/ImfPreviewImage.h
# include/OpenEXR/IlmThreadForward.h
# include/OpenEXR/ImfThreading.h
# include/OpenEXR/ImfCRgbaFile.h
# include/OpenEXR/ImfFlatImage.h
# include/OpenEXR/ImfEnvmap.h
# include/OpenEXR/ImfChannelList.h
# include/OpenEXR/ImfOutputFile.h
# include/OpenEXR/ImfDeepImageLevel.h
# include/OpenEXR/ImfXdr.h
# include/OpenEXR/ImfRationalAttribute.h
# include/OpenEXR/ImfTimeCode.h
# include/OpenEXR/ImfImageIO.h
# include/OpenEXR/ImfVecAttribute.h
# include/OpenEXR/ImfInputPart.h
# include/OpenEXR/ImfPixelType.h
# include/OpenEXR/openexr_encode.h
# include/OpenEXR/ImfOutputPart.h
# include/OpenEXR/IexMathIeeeExc.h
# include/OpenEXR/ImfAcesFile.h
# include/OpenEXR/ImfDeepImageStateAttribute.h
# include/OpenEXR/openexr_coding.h
# lib/pkgconfig/OpenEXR.pc
# lib/cmake/OpenEXR/OpenEXRConfigVersion.cmake
# lib/cmake/OpenEXR/OpenEXRTargets.cmake
# lib/cmake/OpenEXR/OpenEXRTargets-release.cmake
# lib/cmake/OpenEXR/OpenEXRConfig.cmake
# lib/libOpenEXRCore-3_1.a
# lib/libIex-3_1.a
# lib/libOpenEXRUtil-3_1.a
# lib/libOpenEXR-3_1.a
# lib/libIlmThread-3_1.a
# bin/exrmultipart
# bin/exrmakepreview
# bin/exrenvmap
# bin/exrmaketiled
# bin/exrmultiview
# bin/exrheader
# bin/exrinfo
# bin/exrstdattr
# bin/exr2aces
