#!/bin/bash
# cpu av8 av7 x86 x64
# NDK ..+  .   .   .  clang
# GNU  .   .   .   .  gcc
# WIN  .   .   .   .  clang/gcc

lib='libicu'
dsc='A fully compatible autoconf replacement'
lic='GPL-2.0'
src='https://github.com/radare/acr.git"'
cfg='ac'
mki='install'
mkf='all'

lst_inc=''
lst_lib=''
lst_bin='amr acr acr-install acr-sh acr-cat'

. xbuilder.sh

start

# Filelist
# --------
# share/man/man1/acr.1
# share/man/man1/acr-cat.1
# share/man/man1/amr.1
# share/man/man5/configure.acr.5
# share/man/man5/configure.amr.5
# share/acr/modules/csharp.acr
# share/acr/modules/sizes.acr
# share/acr/modules/java-gtk.acr
# share/doc/acr/developers/adding_new_language
# share/doc/acr/developers/unit-tests
# share/doc/acr/developers/string-mode
# share/doc/acr/developers/using_cvs
# share/doc/acr/endian
# share/doc/acr/syntax
# share/doc/acr/gnumake
# share/doc/acr/flag-arguments
# share/doc/acr/backup
# share/doc/acr/vim/syntax/acr.vim
# share/doc/acr/vim/vimrc
# share/doc/acr/vim/ftplugin/acr.vim
# share/doc/acr/vim/install.sh
# share/doc/acr/pkg-config
# share/doc/acr/examples/sdl.acr
# share/doc/acr/examples/vala.acr
# share/doc/acr/examples/if.acr
# share/doc/acr/examples/x11.acr
# share/doc/acr/examples/ifeqval.acr
# share/doc/acr/examples/and.acr
# share/doc/acr/examples/chaos.acr
# share/doc/acr/examples/endian.acr
# share/doc/acr/examples/cflags.acr
# share/doc/acr/examples/contexts.acr
# share/doc/acr/examples/pkgcfg.acr
# share/doc/acr/examples/check.acr
# share/doc/acr/examples/perl.acr
# share/doc/acr/examples/chklibdl.acr
# share/doc/acr/examples/sizeof.acr
# share/doc/acr/examples/ruby.acr
# share/doc/acr/examples/python.acr
# share/doc/acr/examples/cpu.acr
# share/doc/acr/check-user
# share/doc/acr/amr-tutorial
# share/doc/acr/cmdline
# share/doc/acr/make-tips
# share/doc/acr/sandbox
# share/doc/acr/libtool
# share/doc/acr/keywords
# share/doc/acr/crosspath-build
# share/doc/acr/crosscompile
# share/doc/acr/hello_world
# share/doc/acr/conditionals
# bin/amr
# bin/acr
# bin/acr-install
# bin/acr-sh
# bin/acr-cat
