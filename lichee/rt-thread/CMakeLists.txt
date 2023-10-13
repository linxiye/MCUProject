
include_directories(
    ./include
    ./components/finsh
)

aux_source_directory(./src/ RT_SRC)
aux_source_directory(./components/finsh RT_SRC)
aux_source_directory(./libcpu/${ARCH}/common RT_SRC)

set_property(SOURCE ./libcpu/${ARCH}/${ARCH_TYPE}/context_gcc.S PROPERTY LANGUAGE C)

add_library (rtthread
    ${RT_SRC}
    ./components/device/device.c
    ./libcpu/${ARCH}/${ARCH_TYPE}/context_gcc.S
    ./libcpu/${ARCH}/${ARCH_TYPE}/cpuport.c
)

target_link_libraries(rtthread
    board
)

target_include_directories(rtthread PUBLIC 
    ./include 
    ./components/finsh
)
