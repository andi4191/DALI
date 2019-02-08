cmake_minimum_required(VERSION 3.5)
set(CMAKE_SYSTEM_NAME QNX)
set(CMAKE_SYSTEM_VERSION 1)
set(CMAKE_SYSTEM_PROCESSOR aarch64)

set(QNX_VERSION "qnx7.0.0")
set(CMAKE_AS "$ENV{QNX_HOST}/usr/bin/${CMAKE_SYSTEM_PROCESSOR}-unknown-nto-${QNX_VERSION}-as")
set(CMAKE_C_COMPILER "$ENV{QNX_HOST}/usr/bin/${CMAKE_SYSTEM_PROCESSOR}-unknown-nto-${QNX_VERSION}-gcc")
set(CMAKE_CXX_COMPILER "$ENV{QNX_HOST}/usr/bin/${CMAKE_SYSTEM_PROCESSOR}-unknown-nto-${QNX_VERSION}-g++")


add_definitions(-D__AARCH64_QNX__)
add_definitions(-D_POSIX_C_SOURCE=200112L -D_QNX_SOURCE -D_FILE_OFFSET_BITS=64)
message("Compiler settings for qnx ${CMAKE_CXX_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -fexceptions -fPIC -D_XOPEN_SOURCE=600 -std=gnu++0x")
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fPIC -D_XOPEN_SOURCE=600 -std=gnu99")

set(CMAKE_CXX_COMPILER_TARGET_FORCED TRUE)
set(CMAKE_C_COMPILER_TARGET_FORCED TRUE)
set(CMAKE_C_COMPILER_TARGET aarch64)
set(CMAKE_CXX_COMPILER_TARGET aarch64)
set(CMAKE_LINKER $ENV{QNX_HOST}/usr/bin/${CMAKE_SYSTEM_PROVESSOR}-unknown-nto-${QNX_VERSION}-ld)
set(LINKER_FLAGS "-Wl,--no-undefined -Wl,--gc-sections -Wl,-z,noexecstack -Wl,-z,relro -Wl,-z,now,-lc")    

set(CMAKE_FIND_LIBRARY_PREFIXES "lib")
set(CMAKE_FIND_LIBRARY_SUFFIXES ".so,.a")

set(CMAKE_SHARED_LINKER_FLAGS "${LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${LINKER_FLAGS} ${CMAKE_MODULE_LINKER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS "${LINKER_FLAGS} ${CMAKE_EXE_LINKER_FLAGS}")

if(NOT DEFINED CMAKE_LINKER)
    if(${ARCH} MATCHES "qnx")
        find_program(CMAKE_LINKER NAMES $ENV{QNX_HOST}/usr/bin/${CMAKE_SYSTEM_PROCESSOR}-unkown-nto-${QNX_VERSION}-ld)
    endif()
endif()

message("Including the header directories")
include_directories(
     $ENV{QNX_TARGET}/usr/include
     $ENV{QNX_TARGET}/usr/include/aarch64
     $ENV{QNX_TARGET}/usr/include/c++/v1
     set(CMAKE_FIND_ROOT_PATH  $ENV{QNX_TARGET})
     set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
     set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
    )
