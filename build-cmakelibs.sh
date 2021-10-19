#!/bin/bash

## Determine the maximum number of processes that Make can work with.
## Also make preparations for different toolchains
PROC_NR=$(getconf _NPROCESSORS_ONLN)
XTRA_OPTS=""
MAKECMD=make
OSVER=$(uname)
if [ ${OSVER:0:5} == MINGW ]; then
  XTRA_OPTS=(. -G"MinGW Makefiles")
  MAKECMD=${OSVER:0:7}-make
else
  XTRA_OPTS=(. -G"Unix Makefiles")
fi

CMAKE_OPTIONS="-Wno-dev -DCMAKE_TOOLCHAIN_FILE=$PSPDEV/psp/share/pspdev.cmake -DCMAKE_INSTALL_PREFIX=$PSPDEV/psp/sdk/ -DBUILD_SHARED_LIBS=OFF "
#CMAKE_OPTIONS+="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON "

function build {
    cd $1
    mkdir -p build
    cd build
    cmake $CMAKE_OPTIONS $2 "${XTRA_OPTS[@]}" .. || { exit 1; }
    ${MAKECMD} --quiet -j $PROC_NR clean || { exit 1; }
    ${MAKECMD} --quiet -j $PROC_NR || { exit 1; }
    ${MAKECMD} --quiet -j $PROC_NR install || { exit 1; }
    cd ../..
}

## Add ps2dev.cmake
mkdir -p $PSPDEV/psp/share/
cp pspdev.cmake $PSPDEV/psp/share/ || { exit 1; }

##
## Remove build folder
##
rm -rf build
mkdir build
cd build

##
## Clone repos
##
git clone --depth 1 -b v1.2.11 https://github.com/madler/zlib || { exit 1; }
git clone --depth 1 -b v1.6.37 https://github.com/glennrp/libpng || { exit 1; }
git clone --depth 1 -b VER-2-10-4 https://github.com/freetype/freetype || { exit 1; }
git clone --depth 1 -b 0.2.5 https://github.com/yaml/libyaml || { exit 1; }
git clone --depth 1 -b 2.1.0 https://github.com/libjpeg-turbo/libjpeg-turbo || { exit 1; }

##
## Build cmake projects
##
build zlib "-DUNIX:BOOL=ON"
build libpng "-DPNG_SHARED=OFF -DPNG_STATIC=ON"
build freetype
build libyaml
build libjpeg-turbo "-DCMAKE_BUILD_TYPE=Release -DENABLE_SHARED=FALSE -DWITH_SIMD=0"
cd ..
