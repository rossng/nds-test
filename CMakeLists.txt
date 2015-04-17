cmake_minimum_required(VERSION 3.0)

set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
#set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/cmake/nds.platform.cmake")
include(nds.platform)
include(nds.macro)

project(hello_world)

set(ASSETS_PATH "${CMAKE_SOURCE_DIR}/assets")
set(ASSETS_GEN  "${ASSETS_PATH}/gen")
add_grit_target("${PROJECT_NAME}_assets" "${ASSETS_PATH}/images" ${ASSETS_GEN})

add_subdirectory(arm7)
add_subdirectory(arm9)

ndstool_files("arm7/${PROJECT_NAME}_arm7" "arm9/${PROJECT_NAME}_arm9" hello-world)
