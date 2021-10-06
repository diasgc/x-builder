#!/bin/bash

#             a8  a7  x86 x64
# ndk-clang   ++  ... ... ...
# linux-gnu   ... ... ... ...
# mingw-llvm  ... ... ... ...

lib='libcares'
apt='libc-ares2'
dsc='A C library for asynchronous DNS requests'
lic='MIT'
src='https://github.com/c-ares/c-ares.git'
cfg='ar'
eta='10'
mki='install-strip'
mkc='distclean'
#cfg='cmake'
#cshk='CARES_SHARED'
#cstk='CARES_STATIC'
#cbk='CARES_BUILD_TOOLS'
#CFG='-DCARES_STATIC_PIC=ON'

lst_inc='ares_version.h \
	ares.h \
	ares_nameser.h \
	ares_dns.h \
	ares_rules.h \
	ares_build.h'
lst_lib='libcares'

. xbuilder.sh

start

# Filelist
# --------
# include/ares_version.h
# include/ares.h
# include/ares_nameser.h
# include/ares_dns.h
# include/ares_rules.h
# include/ares_build.h
# lib/pkgconfig/libcares.pc
# lib/libcares.so
# lib/libcares.a
# lib/libcares.la
# share/man/man3/ares_library_initialized.3
# share/man/man3/ares_set_local_dev.3
# share/man/man3/ares_cancel.3
# share/man/man3/ares_expand_name.3
# share/man/man3/ares_fds.3
# share/man/man3/ares_library_init.3
# share/man/man3/ares_gethostbyname_file.3
# share/man/man3/ares_send.3
# share/man/man3/ares_library_cleanup.3
# share/man/man3/ares_freeaddrinfo.3
# share/man/man3/ares_version.3
# share/man/man3/ares_parse_srv_reply.3
# share/man/man3/ares_init.3
# share/man/man3/ares_dup.3
# share/man/man3/ares_parse_naptr_reply.3
# share/man/man3/ares_getnameinfo.3
# share/man/man3/ares_gethostbyaddr.3
# share/man/man3/ares_set_socket_callback.3
# share/man/man3/ares_set_local_ip6.3
# share/man/man3/ares_set_servers_ports_csv.3
# share/man/man3/ares_set_servers_csv.3
# share/man/man3/ares_set_servers.3
# share/man/man3/ares_parse_mx_reply.3
# share/man/man3/ares_destroy.3
# share/man/man3/ares_library_init_android.3
# share/man/man3/ares_expand_string.3
# share/man/man3/ares_destroy_options.3
# share/man/man3/ares_set_servers_ports.3
# share/man/man3/ares_save_options.3
# share/man/man3/ares_timeout.3
# share/man/man3/ares_mkquery.3
# share/man/man3/ares_get_servers_ports.3
# share/man/man3/ares_gethostbyname.3
# share/man/man3/ares_parse_uri_reply.3
# share/man/man3/ares_free_string.3
# share/man/man3/ares_query.3
# share/man/man3/ares_set_socket_configure_callback.3
# share/man/man3/ares_inet_pton.3
# share/man/man3/ares_getsock.3
# share/man/man3/ares_set_local_ip4.3
# share/man/man3/ares_getaddrinfo.3
# share/man/man3/ares_parse_soa_reply.3
# share/man/man3/ares_strerror.3
# share/man/man3/ares_parse_ns_reply.3
# share/man/man3/ares_parse_aaaa_reply.3
# share/man/man3/ares_create_query.3
# share/man/man3/ares_inet_ntop.3
# share/man/man3/ares_parse_ptr_reply.3
# share/man/man3/ares_set_socket_functions.3
# share/man/man3/ares_process.3
# share/man/man3/ares_parse_caa_reply.3
# share/man/man3/ares_parse_a_reply.3
# share/man/man3/ares_init_options.3
# share/man/man3/ares_search.3
# share/man/man3/ares_get_servers.3
# share/man/man3/ares_free_hostent.3
# share/man/man3/ares_free_data.3
# share/man/man3/ares_set_sortlist.3
# share/man/man3/ares_parse_txt_reply.3
