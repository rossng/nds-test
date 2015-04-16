# CMake build files for devKitARM

This repository contains the files needed to build Nintendo DS roms using [devKitARM](http://devkitpro.org/).

The CMake build files are tailored for libnds but should be easily adaptable for other devKitPRO toolchains.

## Structure

Project structure is very simple. ARM7 and ARM9 source trees are separate

    myproject
    ├── CMakeLists.txt
    ├── arm7 <-- ARM7 source files
    │   ├── CMakeLists.txt
    │   └── main-arm7.cpp
    ├── arm9 <-- ARM9 source files
    │   ├── CMakeLists.txt
    │   └── main-arm9.cpp
    └── cmake <-- Platform & Macros definitions
        ├── nds-base-makefile
        ├── nds.macro.cmake
        └── nds.platform.cmake
