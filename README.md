# CMake build files for devKitARM

This repository contains the files needed to build Nintendo DS roms using [devKitARM](http://devkitpro.org/).

The CMake build files are tailored for libnds but should be easily adaptable for other devKitPRO toolchains.

## Structure

.
├── CMakeLists.txt
├── arm7
│   ├── CMakeLists.txt
│   └── main-arm7.cpp
├── arm9
│   ├── CMakeLists.txt
│   └── main-arm9.cpp
├── build
└── cmake
    ├── nds-base-makefile
    ├── nds.macro.cmake
    └── nds.platform.cmake
