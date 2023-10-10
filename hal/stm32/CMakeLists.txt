
string(TOLOWER ${CHIP_TYPE} chip_type)
string(TOLOWER ${CHIP_HAL_TYPE} chip_hal_type)

message(STATUS "DCHIP_HAL_TYPE=${DCHIP_HAL_TYPE}")
message(STATUS "chip_type=${chip_type}")


include_directories(
    ./CMSIS/Include
    ./CMSIS/${CHIP_TYPE}/Include
    ./${CHIP_TYPE}/Inc
)

add_subdirectory(${CHIP_TYPE})

set_property(SOURCE ./CMSIS/${CHIP_TYPE}/Source/Templates/gcc/startup_${chip_hal_type}.s PROPERTY LANGUAGE C)

add_library(hal
    ./CMSIS/${CHIP_TYPE}/Source/Templates/system_${chip_type}.c
    ./CMSIS/${CHIP_TYPE}/Source/Templates/gcc/startup_${chip_hal_type}.s
)

target_link_libraries(hal
    stm32hal
)

target_include_directories(hal PUBLIC 
    ./CMSIS/Include
    ./CMSIS/${CHIP_TYPE}/Include
    ./${CHIP_TYPE}/Inc
)


