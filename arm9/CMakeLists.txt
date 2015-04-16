# include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(ARM9_NAME "${PROJECT_NAME}_arm9")
set(ARM9_FILES
    template-arm9.cpp)

add_definitions(-DARM9)
  
add_executable(${ARM9_NAME} ${ARM9_FILES})
target_link_libraries(${ARM9_NAME} nds9)
set_target_properties(${ARM9_NAME}
  PROPERTIES
  LINK_FLAGS -specs=ds_arm9.specs
  COMPILER_FLAGS "-mthumb -mthumb-interwork")

objcopy_file(${ARM9_NAME})
