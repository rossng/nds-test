# include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(ARM7_NAME "${PROJECT_NAME}_arm7")
set(ARM7_FILES
    template-arm7.cpp)

add_definitions(-DARM7)
  
add_executable(${ARM7_NAME} ${ARM7_FILES})
target_link_libraries(${ARM7_NAME} nds7)
target_link_libraries(${ARM7_NAME} dswifi7)
target_link_libraries(${ARM7_NAME} mm7)
set_target_properties(${ARM7_NAME}
  PROPERTIES
  LINK_FLAGS -specs=ds_arm7.specs)

objcopy_file(${ARM7_NAME})
