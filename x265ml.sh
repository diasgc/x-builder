#!/bin/bash
arch=$1
shift
./x265.sh $arch --multilib $@ && ln -s $(pwd)/builds/$arch/x265 $(pwd)/builds/$arch/x265ml