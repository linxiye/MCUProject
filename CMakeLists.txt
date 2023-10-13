cmake_minimum_required(VERSION 3.10)

project(out)

set(ENV{PROJECT} ${PROJECT_NAME})
message(STATUS "PROJECT=$ENV{PROJECT}")

set(BOARD $ENV{BOARD})
message(STATUS "BOARD=${BOARD}")

include(${PROJECT_SOURCE_DIR}/board/${BOARD}/board.cmake)

set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/build)
message(STATUS "PROJECT_NAME=${PROJECT_NAME}")
message(STATUS "CMAKE_HOME_DIRECTORY=${CMAKE_HOME_DIRECTORY}")
message(STATUS "PROJECT_SOURCE_DIR=${PROJECT_SOURCE_DIR}")

add_custom_target( 
    menuconfig
    python3 ../scripts/kconfig.py ../Kmenuconfig .config config.h
    
    USES_TERMINAL
)

add_custom_target( 
    download
    openocd -f ../board/${BOARD}/openocd.cfg -c init -c halt -c "flash write_image erase ../build/${PROJECT_NAME}.bin ${OPENOCD_FLASH_START}" -c reset -c shutdown
    USES_TERMINAL
)

include_directories(
    ./board/${BOARD}
    ./build/config.h
)

add_subdirectory(board)
add_subdirectory(App)
add_subdirectory(hal)
add_subdirectory(lichee)

add_executable(${PROJECT_NAME}.elf 
    ${PROJECT_SOURCE_DIR}/board/regio.c
)

target_link_libraries(${PROJECT_NAME}.elf
    -Wl,--whole-archive 
    board 
    app 
    rtthread
    -Wl,--no-whole-archive
)

set(ELF_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.elf)
set(HEX_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex)
set(BIN_FILE ${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin)


add_custom_command(TARGET "${PROJECT_NAME}.elf" POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -Obinary ${ELF_FILE} ${BIN_FILE}
    COMMAND ${CMAKE_OBJCOPY} -Oihex  ${ELF_FILE} ${HEX_FILE}
    COMMENT "Building ${PROJECT_NAME}.bin and ${PROJECT_NAME}.hex"

    COMMAND ${CMAKE_COMMAND} -E copy ${HEX_FILE} "${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.hex"
    COMMAND ${CMAKE_COMMAND} -E copy ${BIN_FILE} "${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.bin"

    COMMAND ${CMAKE_SIZE} --format=berkeley ${PROJECT_NAME}.elf ${PROJECT_NAME}.hex
    COMMENT "Invoking: Cross ARM GNU Print Size"
)

