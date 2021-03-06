#!/bin/bash

lib='libzen'
apt="${lib}-dev"
dsc='Zenlib for MediaInfo'
lic='Zlib'
src='https://github.com/MediaArea/ZenLib.git'
cfg='cmake'
eta='27'
config_dir='Project/CMake'

lst_inc='ZenLib/*.h ZenLib/Format/Html/*.h'
lst_lib='libzen'
lst_bin=''
lst_lic='License.txt'
lst_pc='libzen.pc'

dev_bra='master'
dev_vrs='0.4.39'
stb_bra='tags/v0.4.39'
stb_vrs='0.4.39'

cmake_static='BUILD_STATIC_LIBS'

. xbuilder.sh

start

# patch 01 on Project/CMake/CMakeLists.txt to support dual static shared build
# patch 02 on Project/CMake/libzen.pc.in to set paths relative to prefix 
<<'XB64_PATCH'
LS0tIFByb2plY3QvQ01ha2UvQ01ha2VMaXN0cy50eHQJMjAyMi0wMi0wMyAyMToxNTo0Ny4xNTkwMDAwMDAgKzAwMD
ANCisrKyBQcm9qZWN0L0NNYWtlL0NNYWtlTGlzdHMudHh0CTIwMjItMDItMDMgMjE6Mjk6MjYuMDEyNDc0NDAwICsw
MDAwDQpAQCAtMTA0LDYwICsxMDQsNzMgQEANCiAgICR7WmVuTGliX1NPVVJDRVNfUEFUSH0vWmVuTGliL0Zvcm1hdC
9IdHRwL0h0dHBfUmVxdWVzdC5jcHANCiAgICR7WmVuTGliX1NPVVJDRVNfUEFUSH0vWmVuTGliL0Zvcm1hdC9IdHRw
L0h0dHBfVXRpbHMuY3BwDQogICApDQotDQotYWRkX2xpYnJhcnkoemVuICR7WmVuTGliX1NSQ1N9ICR7WmVuTGliX0
hEUlN9ICR7WmVuTGliX2Zvcm1hdF9odG1sX0hEUlN9ICR7WmVuTGliX2Zvcm1hdF9odHRwX0hEUlN9KQ0KLWlmKEVO
QUJMRV9VTklDT0RFKQ0KLSAgc2V0KFplbkxpYl9Vbmljb2RlICJ5ZXMiKQ0KLSAgc2V0KFplbkxpYl9DWFhGTEFHUy
AtRFVOSUNPREUpICMgRm9yIHBrZy1jb25maWcgdGVtcGxhdGUNCi0gIHRhcmdldF9jb21waWxlX2RlZmluaXRpb25z
KHplbiBQVUJMSUMgVU5JQ09ERSBfVU5JQ09ERSkNCi1lbHNlKCkNCi0gIHNldChaZW5MaWJfVW5pY29kZSAibm8iKQ
0KLWVuZGlmKCkNCi0NCi1GSU5EX1BBQ0tBR0UoVGhyZWFkcykNCi1pZihDTUFLRV9USFJFQURfTElCU19JTklUKQ0K
LSAgdGFyZ2V0X2xpbmtfbGlicmFyaWVzKHplbiBQVUJMSUMgJHtDTUFLRV9USFJFQURfTElCU19JTklUfSkNCi1lbm
RpZigpDQotDQotaWYoTEFSR0VfRklMRVMpDQotICBpbmNsdWRlKFRlc3RMYXJnZUZpbGVzKQ0KLQ0KLSAgdGVzdF9s
YXJnZV9maWxlcyhfTEFSR0VGSUxFUykNCi0gIHRhcmdldF9jb21waWxlX2RlZmluaXRpb25zKHplbiBQVUJMSUMgJH
tMQVJHRV9GSUxFU19ERUZJTklUSU9OU30pDQotZW5kaWYoKQ0KLQ0KLWluY2x1ZGUoQ2hlY2tUeXBlU2l6ZSkNCi1j
aGVja190eXBlX3NpemUoc2l6ZV90IFNJWkVfVF9TSVpFKQ0KLWNoZWNrX3R5cGVfc2l6ZShsb25nIExPTkdfU0laRS
kNCi1pZigoTE9OR19TSVpFIEdSRUFURVIgNCkgQU5EIChTSVpFX1RfU0laRSBFUVVBTCBMT05HX1NJWkUpKQ0KLSAg
dGFyZ2V0X2NvbXBpbGVfZGVmaW5pdGlvbnMoemVuIFBVQkxJQyBTSVpFX1RfSVNfTE9ORykNCi1lbmRpZigpDQotDQ
otaW5jbHVkZShDaGVja1N5bWJvbEV4aXN0cykNCi1jaGVja19zeW1ib2xfZXhpc3RzKGdtdGltZV9yIHRpbWUuaCBI
QVZFX0dNVElNRV9SKQ0KLWlmKEhBVkVfR01USU1FX1IpDQotICB0YXJnZXRfY29tcGlsZV9kZWZpbml0aW9ucyh6ZW
4gUFVCTElDIEhBVkVfR01USU1FX1IpDQotZW5kaWYoKQ0KLWNoZWNrX3N5bWJvbF9leGlzdHMobG9jYWx0aW1lX3Ig
dGltZS5oIEhBVkVfTE9DQUxUSU1FX1IpDQotaWYoSEFWRV9MT0NBTFRJTUVfUikNCi0gIHRhcmdldF9jb21waWxlX2
RlZmluaXRpb25zKHplbiBQVUJMSUMgSEFWRV9MT0NBTFRJTUVfUikNCi1lbmRpZigpDQotDQotdGFyZ2V0X2luY2x1
ZGVfZGlyZWN0b3JpZXMoemVuIFBVQkxJQw0KLSAgJDxCVUlMRF9JTlRFUkZBQ0U6JHtaZW5MaWJfU09VUkNFU19QQV
RIfT4NCi0gICQ8SU5TVEFMTF9JTlRFUkZBQ0U6JHtJTkNMVURFX0lOU1RBTExfRElSfT4pDQotDQotc2V0X3Rhcmdl
dF9wcm9wZXJ0aWVzKHplbiBQUk9QRVJUSUVTDQotICBWRVJTSU9OICR7WmVuTGliX1ZFUlNJT059DQotICBTT1ZFUl
NJT04gJHtaZW5MaWJfTUFKT1JfVkVSU0lPTn0NCi0gIFBVQkxJQ19IRUFERVIgIiR7WmVuTGliX0hEUlN9Ig0KLSAg
KQ0KLQ0KLWluc3RhbGwoVEFSR0VUUyB6ZW4gRVhQT1JUIHplbi1leHBvcnQNCi0gIFBVQkxJQ19IRUFERVIgREVTVE
lOQVRJT04gJHtJTkNMVURFX0lOU1RBTExfRElSfS9aZW5MaWINCi0gIFJVTlRJTUUgREVTVElOQVRJT04gJHtCSU5f
SU5TVEFMTF9ESVJ9DQotICBBUkNISVZFIERFU1RJTkFUSU9OICR7TElCX0lOU1RBTExfRElSfQ0KLSAgTElCUkFSWS
BERVNUSU5BVElPTiAke0xJQl9JTlNUQUxMX0RJUn0pDQorc2V0KGxpYnMgemVuKQ0KK2lmKEJVSUxEX1NIQVJFRF9M
SUJTIEFORCBCVUlMRF9TVEFUSUNfTElCUykNCisgIGxpc3QoQVBQRU5EIGxpYnMgemVuLXN0YXRpYykNCitlbmRpZi
gpDQorZm9yZWFjaCh6ZW5saWIgJHtsaWJzfSkNCisgIGlmKCR7emVubGlifSBNQVRDSEVTICJzdGF0aWMkIikNCisg
ICAgc2V0KGxpYnR5cGUgU1RBVElDKQ0KKyAgICBzZXQobGliYWNjcyBQUklWQVRFKQ0KKyAgZWxzZSgpDQorICAgIH
NldChsaWJ0eXBlICIiKQ0KKyAgICBzZXQobGliYWNjcyBQVUJMSUMpDQorICBlbmRpZigpDQorICBhZGRfbGlicmFy
eSgke3plbmxpYn0gJHtsaWJ0eXBlfSAke1plbkxpYl9TUkNTfSAke1plbkxpYl9IRFJTfSAke1plbkxpYl9mb3JtYX
RfaHRtbF9IRFJTfSAke1plbkxpYl9mb3JtYXRfaHR0cF9IRFJTfSkNCisgIGlmKEVOQUJMRV9VTklDT0RFKQ0KKyAg
ICBzZXQoWmVuTGliX1VuaWNvZGUgInllcyIpDQorICAgIHNldChaZW5MaWJfQ1hYRkxBR1MgLURVTklDT0RFKSAjIE
ZvciBwa2ctY29uZmlnIHRlbXBsYXRlDQorICAgIHRhcmdldF9jb21waWxlX2RlZmluaXRpb25zKCR7emVubGlifSAk
e2xpYmFjY3N9IFVOSUNPREUgX1VOSUNPREUpDQorICBlbHNlKCkNCisgICAgc2V0KFplbkxpYl9Vbmljb2RlICJuby
IpDQorICBlbmRpZigpDQorDQorICBGSU5EX1BBQ0tBR0UoVGhyZWFkcykNCisgIGlmKENNQUtFX1RIUkVBRF9MSUJT
X0lOSVQpDQorICAgIHRhcmdldF9saW5rX2xpYnJhcmllcygke3plbmxpYn0gJHtsaWJhY2NzfSAke0NNQUtFX1RIUk
VBRF9MSUJTX0lOSVR9KQ0KKyAgZW5kaWYoKQ0KKw0KKyAgaWYoTEFSR0VfRklMRVMpDQorICAgIGluY2x1ZGUoVGVz
dExhcmdlRmlsZXMpDQorDQorICAgIHRlc3RfbGFyZ2VfZmlsZXMoX0xBUkdFRklMRVMpDQorICAgIHRhcmdldF9jb2
1waWxlX2RlZmluaXRpb25zKCR7emVubGlifSAke2xpYmFjY3N9ICR7TEFSR0VfRklMRVNfREVGSU5JVElPTlN9KQ0K
KyAgZW5kaWYoKQ0KKw0KKyAgaW5jbHVkZShDaGVja1R5cGVTaXplKQ0KKyAgY2hlY2tfdHlwZV9zaXplKHNpemVfdC
BTSVpFX1RfU0laRSkNCisgIGNoZWNrX3R5cGVfc2l6ZShsb25nIExPTkdfU0laRSkNCisgIGlmKChMT05HX1NJWkUg
R1JFQVRFUiA0KSBBTkQgKFNJWkVfVF9TSVpFIEVRVUFMIExPTkdfU0laRSkpDQorICAgIHRhcmdldF9jb21waWxlX2
RlZmluaXRpb25zKCR7emVubGlifSAke2xpYmFjY3N9IFNJWkVfVF9JU19MT05HKQ0KKyAgZW5kaWYoKQ0KKw0KKyAg
aW5jbHVkZShDaGVja1N5bWJvbEV4aXN0cykNCisgIGNoZWNrX3N5bWJvbF9leGlzdHMoZ210aW1lX3IgdGltZS5oIE
hBVkVfR01USU1FX1IpDQorICBpZihIQVZFX0dNVElNRV9SKQ0KKyAgICB0YXJnZXRfY29tcGlsZV9kZWZpbml0aW9u
cygke3plbmxpYn0gJHtsaWJhY2NzfSBIQVZFX0dNVElNRV9SKQ0KKyAgZW5kaWYoKQ0KKyAgY2hlY2tfc3ltYm9sX2
V4aXN0cyhsb2NhbHRpbWVfciB0aW1lLmggSEFWRV9MT0NBTFRJTUVfUikNCisgIGlmKEhBVkVfTE9DQUxUSU1FX1Ip
DQorICAgIHRhcmdldF9jb21waWxlX2RlZmluaXRpb25zKCR7emVubGlifSBQVUJMSUMgSEFWRV9MT0NBTFRJTUVfUi
kNCisgIGVuZGlmKCkNCisNCisgIHRhcmdldF9pbmNsdWRlX2RpcmVjdG9yaWVzKCR7emVubGlifSAke2xpYmFjY3N9
DQorICAgICQ8QlVJTERfSU5URVJGQUNFOiR7WmVuTGliX1NPVVJDRVNfUEFUSH0+DQorICAgICQ8SU5TVEFMTF9JTl
RFUkZBQ0U6JHtJTkNMVURFX0lOU1RBTExfRElSfT4pDQorDQorICBzZXRfdGFyZ2V0X3Byb3BlcnRpZXMoJHt6ZW5s
aWJ9IFBST1BFUlRJRVMNCisgICAgVkVSU0lPTiAke1plbkxpYl9WRVJTSU9OfQ0KKyAgICBTT1ZFUlNJT04gJHtaZW
5MaWJfTUFKT1JfVkVSU0lPTn0NCisgICAgUFVCTElDX0hFQURFUiAiJHtaZW5MaWJfSERSU30iDQorICAgIE9VVFBV
VF9OQU1FIHplbg0KKyAgICApDQorDQorICBpbnN0YWxsKFRBUkdFVFMgJHt6ZW5saWJ9IEVYUE9SVCB6ZW4tZXhwb3
J0DQorICAgIFBVQkxJQ19IRUFERVIgREVTVElOQVRJT04gJHtJTkNMVURFX0lOU1RBTExfRElSfS9aZW5MaWINCisg
ICAgUlVOVElNRSBERVNUSU5BVElPTiAke0JJTl9JTlNUQUxMX0RJUn0NCisgICAgQVJDSElWRSBERVNUSU5BVElPTi
Ake0xJQl9JTlNUQUxMX0RJUn0NCisgICAgTElCUkFSWSBERVNUSU5BVElPTiAke0xJQl9JTlNUQUxMX0RJUn0pDQor
ZW5kZm9yZWFjaCgpDQogDQogaW5zdGFsbChGSUxFUyAke1plbkxpYl9mb3JtYXRfaHRtbF9IRFJTfSBERVNUSU5BVE
lPTiAke0lOQ0xVREVfSU5TVEFMTF9ESVJ9L1plbkxpYi9Gb3JtYXQvSHRtbCkNCiBpbnN0YWxsKEZJTEVTICR7WmVu
TGliX2Zvcm1hdF9odHRwX0hEUlN9IERFU1RJTkFUSU9OICR7SU5DTFVERV9JTlNUQUxMX0RJUn0vWmVuTGliL0Zvcm
1hdC9IdHRwKQ0KDQotLS0gUHJvamVjdC9DTWFrZS9saWJ6ZW4ucGMuaW4JMjAyMi0wMi0wMyAyMToyNDoyMy41NDcw
MDAwMDAgKzAwMDANCisrKyBQcm9qZWN0L0NNYWtlL2xpYnplbi5wYy5pbgkyMDIyLTAyLTAzIDIxOjI1OjE0Ljk0Mj
Q3NDQwMCArMDAwMA0KQEAgLTEsOSArMSw5IEBADQogcHJlZml4PUBDTUFLRV9JTlNUQUxMX1BSRUZJWEANCiBleGVj
X3ByZWZpeD0ke3ByZWZpeH0NCi1saWJkaXI9QExJQl9JTlNUQUxMX0RJUkANCi1pbmNsdWRlZGlyPUBJTkNMVURFX0
lOU1RBTExfRElSQA0KK2xpYmRpcj0ke3ByZWZpeH0vbGliDQoraW5jbHVkZWRpcj0ke3ByZWZpeH0vaW5jbHVkZQ0K
IFVuaWNvZGU9QFplbkxpYl9Vbmljb2RlQA0KLUxpYnNfU3RhdGljPUBMSUJfSU5TVEFMTF9ESVJAL2xpYnplbi5hIC
1scHRocmVhZA0KK0xpYnNfU3RhdGljPSR7cHJlZml4fS9saWIvbGliemVuLmEgLWxwdGhyZWFkDQogDQogTmFtZTog
bGliemVuDQogVmVyc2lvbjogQFplbkxpYl9WRVJTSU9OQA0K
XB64_PATCH
# cpu av8 av7 x86 x64
# NDK ++   .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

# Filelist
# --------
# include/ZenLib/BitStream_LE.h
# include/ZenLib/int128u.h
# include/ZenLib/Translation.h
# include/ZenLib/Dir.h
# include/ZenLib/ZtringListList.h
# include/ZenLib/BitStream.h
# include/ZenLib/Trace.h
# include/ZenLib/int128s.h
# include/ZenLib/Format/Html/Html_Handler.h
# include/ZenLib/Format/Html/Html_Request.h
# include/ZenLib/Format/Http/Http_Cookies.h
# include/ZenLib/Format/Http/Http_Request.h
# include/ZenLib/Format/Http/Http_Utils.h
# include/ZenLib/Format/Http/Http_Handler.h
# include/ZenLib/File.h
# include/ZenLib/Ztring.h
# include/ZenLib/CriticalSection.h
# include/ZenLib/ZtringList.h
# include/ZenLib/MemoryDebug.h
# include/ZenLib/Utils.h
# include/ZenLib/OS_Utils.h
# include/ZenLib/InfoMap.h
# include/ZenLib/Conf_Internal.h
# include/ZenLib/ZtringListListF.h
# include/ZenLib/Conf.h
# include/ZenLib/BitStream_Fast.h
# include/ZenLib/Thread.h
# include/ZenLib/FileName.h
# include/ZenLib/PreComp.h
# lib/libzen.so
# lib/pkgconfig/libzen.pc
# lib/cmake/zenlib/ZenLibTargets-release.cmake
# lib/cmake/zenlib/ZenLibConfig.cmake
# lib/cmake/zenlib/ZenLibTargets.cmake
# lib/cmake/zenlib/ZenLibConfigVersion.cmake
# lib/libzen.a
# share/doc/libzen/License.txt
