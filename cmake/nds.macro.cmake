# Sets up an ARM7 target
# Adds the definition for the libnds headers
macro(SETUP_ARM7_TARGET TARGET_NAME TARGET_LIBS TARGET_FILES)

  add_definitions(-DARM7)

  set(ARM7_TARGET_NAME "${TARGET_NAME}_arm7")

  add_executable(${ARM7_TARGET_NAME} ${TARGET_FILES})
  setup_nds_target(${ARM7_TARGET_NAME} ds_arm7.specs "${TARGET_LIBS}")

  add_dependencies(${ARM7_TARGET_NAME} ${GRIT_TARGET_NAME})
  
endmacro(SETUP_ARM7_TARGET)

# Sets up an ARM9 target
# Adds the definition for the libnds headers
macro(SETUP_ARM9_TARGET TARGET_NAME TARGET_LIBS TARGET_FILES)

  add_definitions(-DARM9)

  set(ARM9_TARGET_NAME "${TARGET_NAME}_arm9")
  
  add_executable(${ARM9_TARGET_NAME} ${TARGET_FILES})
  setup_nds_target(${ARM9_TARGET_NAME} ds_arm9.specs "${TARGET_LIBS}")
  
  add_dependencies(${ARM9_TARGET_NAME} ${GRIT_TARGET_NAME})
  
endmacro(SETUP_ARM9_TARGET)

# Used to set informations for ARM7 and ARM9 targets
macro(SETUP_NDS_TARGET TARGET_NAME LINKER_SPEC TARGET_LIBS)

  # Link all libraries
  foreach(LIB_NAME ${TARGET_LIBS})
    if(NOT DEFINED "LIB_${LIB_NAME}")
      find_library("LIB_${LIB_NAME}" ${LIB_NAME})
    endif()
    target_link_libraries(${TARGET_NAME} ${LIB_NAME})
  endforeach(LIB_NAME)

  # Setup linker and arch flags
  set_target_properties(${TARGET_NAME}
    PROPERTIES
    LINK_FLAGS "-specs=${LINKER_SPEC}"
    COMPILER_FLAGS "-mthumb -mthumb-interwork")

  # Setup objcopy
  objcopy_file(${TARGET_NAME})
  
endmacro(SETUP_NDS_TARGET)

macro(OBJCOPY_FILE EXE_NAME)
 set(FO ${CMAKE_CURRENT_BINARY_DIR}/${EXE_NAME}.bin)
 set(FI ${CMAKE_CURRENT_BINARY_DIR}/${EXE_NAME})
 message(STATUS ${FO})
 add_custom_command(
  OUTPUT "${FO}"
  COMMAND ${CMAKE_OBJCOPY}
  ARGS -O binary ${FI} ${FO}
  DEPENDS ${FI})
 get_filename_component(TGT "${EXE_NAME}" NAME)
 add_custom_target("TargetObjCopy_${TGT}" ALL DEPENDS ${FO} VERBATIM)
 get_directory_property(extra_clean_files ADDITIONAL_MAKE_CLEAN_FILES)
 set_directory_properties(
  PROPERTIES
  ADDITIONAL_MAKE_CLEAN_FILES "${extra_clean_files};${FO}")
 set_source_files_properties("${FO}" PROPERTIES GENERATED TRUE)
endmacro(OBJCOPY_FILE)

if(NOT NDSTOOL_EXE)
 message(STATUS "Looking for arm-eabi-objcopy")
 find_program(NDSTOOL_EXE ndstool ${DEVKITARM}/bin)
 if(NDSTOOL_EXE)
  message(STATUS "Looking for arm-eabi-objcopy -- ${NDSTOOL_EXE}")
 endif(NDSTOOL_EXE)
endif(NOT NDSTOOL_EXE)

if(NDSTOOL_EXE)
 macro(NDSTOOL_FILE EXE_NAME)
  set(FO ${CMAKE_CURRENT_BINARY_DIR}/${EXE_NAME}.nds)
  set(I9 ${CMAKE_CURRENT_BINARY_DIR}/${EXE_NAME}.bin)
  add_custom_command(
   OUTPUT ${FO}
   COMMAND ${NDSTOOL_EXE}
   ARGS -c ${FO} -9 ${I9}
   MAIN_DEPENDENCY ${I9}
   )
  get_filename_component(TGT "${EXE_NAME}" NAME)
  add_custom_target("Target9_${TGT}" ALL DEPENDS ${FO} VERBATIM)
  get_directory_property(extra_clean_files ADDITIONAL_MAKE_CLEAN_FILES)
  set_directory_properties(
   PROPERTIES
   ADDITIONAL_MAKE_CLEAN_FILES "${extra_clean_files};${FO}")
  set_source_files_properties(${FO} PROPERTIES GENERATED TRUE)
 endmacro(NDSTOOL_FILE)
endif(NDSTOOL_EXE)

macro(NDSTOOL_FILES arm7_NAME arm9_NAME exe_NAME)
  set(FO ${CMAKE_CURRENT_BINARY_DIR}/${exe_NAME}.nds)
  set(I9 ${CMAKE_CURRENT_BINARY_DIR}/${arm9_NAME}.bin)
  set(I7 ${CMAKE_CURRENT_BINARY_DIR}/${arm7_NAME}.bin)
  
  add_custom_command(
    OUTPUT ${FO}
    COMMAND ${NDSTOOL_EXE}
    ARGS -c ${FO} -9 ${I9} -7 ${I7})
    
  get_filename_component(TGT "${exe_NAME}" NAME)
  get_filename_component(TGT7 "${arm7_NAME}" NAME)
  get_filename_component(TGT9 "${arm9_NAME}" NAME)

  add_custom_target("Target97_${TGT}" ALL DEPENDS ${FO} VERBATIM)
  add_dependencies("Target97_${TGT}"
                   "TargetObjCopy_${TGT7}"
                   "TargetObjCopy_${TGT9}")
                   
  get_directory_property(extra_clean_files ADDITIONAL_MAKE_CLEAN_FILES)
  set_directory_properties(PROPERTIES
                           ADDITIONAL_MAKE_CLEAN_FILES "${extra_clean_files};${FO}")
endmacro(NDSTOOL_FILES)

if(NOT GRIT_EXE)
 message(STATUS "Looking for grit")
 find_program(GRIT_EXE grit ${DEVKITARM}/bin)
 if(GRIT_EXE)
  message(STATUS "Looking for grit -- ${GRIT_EXE}")
 endif(GRIT_EXE)
endif(NOT GRIT_EXE)

if(GRIT_EXE)
  macro(ADD_GRIT_TARGET NAME SRC_PATH GEN_PATH)
    # Create variable with target name
    set(GRIT_TARGET_NAME ${NAME})
    
    # Find all PNG files
    file(GLOB FILES "${SRC_PATH}/*.png")

    # Create target directory
    file(MAKE_DIRECTORY ${GEN_PATH})
    
    # Add a command to process each file with grit
    foreach(FILE_PNG ${FILES})
      get_filename_component(FILE_NAME ${FILE_PNG} NAME)
      
      # Compute output files
      string(REPLACE ".png" ".h" FILE_H ${FILE_PNG})
      string(REPLACE ".png" ".c" FILE_C ${FILE_PNG})

      set(IMAGE_FILES_C ${IMAGE_FILES_C} ${FILE_C})
      set(IMAGE_FILES_H ${IMAGE_FILES_H} ${FILE_H})
      
      # Create grit command
      add_custom_command(OUTPUT ${FILE_H} ${FILE_C}
                         COMMAND ${GRIT_EXE}
                         ARGS ${FILE_PNG} -ftc -o${GEN_PATH}/${FILE_NAME})
      
    endforeach(FILE_PNG)
    
    # Create a target with those files
    # So IDEs can recognize them
    add_custom_target(${GRIT_TARGET_NAME}
                      SOURCES ${FILES}
                              ${IMAGE_FILES_C}
                              ${IMAGES_FILES_H})

    include_directories(${GEN_PATH})
    
  endmacro(ADD_GRIT_TARGET)
endif(GRIT_EXE)