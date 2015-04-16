# include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(ARM9_FILES
    main.arm9.cpp)

set(ARM9_LIBS nds9)

setup_arm9_target(${PROJECT_NAME} "${ARM9_LIBS}" "${ARM9_FILES}")
