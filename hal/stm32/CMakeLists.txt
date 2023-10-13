
string(TOLOWER ${CHIP_TYPE} chip_type)
string(TOLOWER ${CHIP_HAL_TYPE} chip_hal_type)

message(STATUS "DCHIP_HAL_TYPE=${DCHIP_HAL_TYPE}")
message(STATUS "chip_type=${chip_type}")


include_directories(
    ./CMSIS/Include
    ./CMSIS/${CHIP_TYPE}/Include
    ./${CHIP_TYPE}/Inc
)


aux_source_directory(./${CHIP_TYPE}/Src/ HAL_SRC)
add_library (hal ${HAL_SRC})


target_include_directories(hal PUBLIC 
    ./CMSIS/Include
    ./CMSIS/${CHIP_TYPE}/Include
    ./${CHIP_TYPE}/Inc
)


