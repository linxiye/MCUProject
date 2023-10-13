
aux_source_directory(./ BOARD_SRC)
aux_source_directory(./rtthread BOARD_SRC)
aux_source_directory(./Src BOARD_SRC)

set_property(SOURCE ./startup_stm32f407xx.s PROPERTY LANGUAGE C)

add_library(board
    ${BOARD_SRC}
    ./startup_stm32f407xx.s
)

target_link_libraries(board
    hal
    rtthread
)

target_include_directories(board PUBLIC 
    ./rtthread
    ./rtthread/Inc
)
