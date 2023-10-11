# GCC
set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)
set(CMAKE_OBJCOPY arm-none-eabi-objcopy)
set(CMAKE_SIZE arm-none-eabi-size)

# build
set(CMAKE_BUILD_TYPE "Debug")
#set(CMAKE_BUILD_TYPE "Release")
set(MCU_FLAGS "-mcpu=cortex-m4 -mfloat-abi=soft -mfpu=fpv4-sp-d16")
set(CMAKE_C_FLAGS "${MCU_FLAGS} -w -Wno-unknown-pragmas -std=c99")
set(CMAKE_C_FLAGS_DEBUG "-O0 -g2 -ggdb")
set(CMAKE_C_FLAGS_RELEASE "-O3")

#LD
set(LINKER_SCRIPT ${PROJECT_SOURCE_DIR}/board/$ENV{BOARD}/board.ld)
set(CMAKE_EXE_LINKER_FLAGS
"--specs=nano.specs -specs=nosys.specs -T${LINKER_SCRIPT} -Wl,-Map=${PROJECT_SOURCE_DIR}/build/${PROJECT_NAME}.map,--cref -Wl,--gc-sections,--no-warn-rwx-segments"
)

# OS CHIP
set(ARCH arm)
set(ARCH_TYPE cortex-m4)
# CHIP
set(CHIP stm32)
# STM32 CHIP TYPE
set(CHIP_TYPE STM32F4xx)
# STM32 HALLIB CHIP TYPE
set(CHIP_HAL_TYPE STM32F407xx)

set(DCHIP_HAL_TYPE -D${CHIP_HAL_TYPE})
# STM32 HAL define
add_definitions(
    -DUSE_HAL_DRIVER
    ${DCHIP_HAL_TYPE}
)