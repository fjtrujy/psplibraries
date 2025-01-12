SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_VERSION 1)
SET(CMAKE_SYSTEM_PROCESSOR mips)
SET(CMAKE_C_COMPILER psp-gcc)
SET(CMAKE_CXX_COMPILER psp-g++)
SET(CMAKE_C_FLAGS_INIT "-I$ENV{PSPDEV}/psp/include -I$ENV{PSPDEV}/psp/sdk/include -DPSP -O2 -G0")
SET(CMAKE_CXX_FLAGS_INIT "-I$ENV{PSPDEV}/psp/include -I$ENV{PSPDEV}/psp/sdk/include -DPSP -O2 -G0")
SET(CMAKE_EXE_LINKER_FLAGS_INIT "-L$ENV{PSPDEV}/lib -L$ENV{PSPDEV}/psp/lib -L$ENV{PSPDEV}/psp/sdk/lib -Wl,-zmax-page-size=128")
#SET(CMAKE_SHARED_LINKER_FLAGS_INIT "...")
#SET(CMAKE_STATIC_LINKER_FLAGS_CONFIG_INIT "...")
#SET(CMAKE_STATIC_LINKER_FLAGS_INIT "...")
SET(CMAKE_TARGET_INSTALL_PREFIX $ENV{PSPDEV}/psp/sdk)

SET(CMAKE_FIND_ROOT_PATH $ENV{PSPDEV} $ENV{PSPDEV}/psp $ENV{PSPDEV}/psp/sdk)
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

## Add Default PSPSDK Libraries according to build.mak and add stdc++ for C++ builds so this doesn't need to be done manually later
include_directories($ENV{PSPDEV}/psp/include $ENV{PSPDEV}/psp/sdk/include)
link_directories( $ENV{PSPDEV}/lib $ENV{PSPDEV}/psp/lib $ENV{PSPDEV}/psp/sdk/lib)