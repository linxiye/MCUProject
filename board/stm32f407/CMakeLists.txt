
aux_source_directory(./ BOARD_SRC)

add_library(board
    ${BOARD_SRC}
)

target_link_libraries(board
    hal
)


