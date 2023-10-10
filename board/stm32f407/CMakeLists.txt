
add_library(board
    ./stm32_hal_init.c
)

target_link_libraries(board
    hal
)


