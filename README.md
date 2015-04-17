# CMake build files for devKitARM

This repository contains the files needed to build Nintendo DS roms using [devKitARM](http://devkitpro.org/).

The CMake build files are tailored for libnds but should be easily adaptable for other devKitPRO toolchains.

## Structure

Project structure is very simple. ARM7 and ARM9 source trees are separate.
A shared folder is symlinked between the two source trees.

    <project root>
    ├── CMakeLists.txt
    ├── README.md
    ├── arm7
    │   ├── CMakeLists.txt
    │   ├── main-arm7.cpp
    │   └── shared -> ../shared
    ├── arm9
    │   ├── CMakeLists.txt
    │   ├── main-arm9.cpp
    │   └── shared -> ../shared
    ├── build
    ├── cmake
    │   ├── nds-base-makefile
    │   ├── nds.macro.cmake
    │   └── nds.platform.cmake
    └── shared
        ├── example.cpp
        └── example.hpp

## TODO

* ~~Add target with commands to automatically compile assets~~
* ~~Copy NDS file to an easily accessible place~~