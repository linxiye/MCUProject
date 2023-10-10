
include_directories(
    ./include
    ./components/finsh
)

aux_source_directory(./src/ RT_SRC)
aux_source_directory(./components/finsh RT_SRC)
aux_source_directory(./libcpu/arm/common RT_SRC)

set_property(SOURCE ./libcpu/arm/cortex-m4/context_gcc.S PROPERTY LANGUAGE C)

add_library (rtthread
    ${RT_SRC}
    ./components/device/device.c
    ./libcpu/arm/cortex-m4/context_gcc.S
    ./libcpu/arm/cortex-m4/cpuport.c
)

target_include_directories(rtthread PUBLIC 
    ./include 
    ./components/finsh
)
