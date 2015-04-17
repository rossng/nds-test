set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION r44)
set(CMAKE_SYSTEM_PROCESSOR arm-eabi)

set(DEVKITARM $ENV{DEVKITARM})
set(DEVKITPRO $ENV{DEVKITPRO})

if(NOT DEVKITARM)
       message(FATAL_ERROR "Please set DEVKITARM in your environment")
endif()

set(PREFIX arm-none-eabi)

find_program(CMAKE_C_COMPILER ${PREFIX}-gcc ${DEVKITARM}/bin)
find_program(CMAKE_CXX_COMPILER ${PREFIX}-g++ ${DEVKITARM}/bin)
find_program(CMAKE_OBJCOPY ${PREFIX}-objcopy ${DEVKITARM}/bin)
find_program(CMAKE_OBJDUMP ${PREFIX}-objdump ${DEVKITARM}/bin)
find_program(CMAKE_LINKER ${PREFIX}-ld ${DEVKITARM}/bin)
find_program(CMAKE_STRIP ${PREFIX}-strip ${DEVKITARM}/bin)

set(CMAKE_FIND_ROOT_PATH ${DEVKITARM})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CMAKE_FIND_LIBRARY_PREFIXES lib)
set(CMAKE_FIND_LIBRARY_SUFFIXES .a)

include_directories(${DEVKITPRO}/libnds/include)
link_directories(${DEVKITPRO}/libnds/lib)