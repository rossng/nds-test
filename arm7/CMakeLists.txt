# include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(ARM7_FILES
    template-arm7.cpp)

set(ARM7_LIBS nds7
              dswifi7
              mm7)
  
setup_arm7_target(${PROJECT_NAME} "${ARM7_LIBS}" "${ARM7_FILES}")
