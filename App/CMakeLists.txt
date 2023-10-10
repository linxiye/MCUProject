

aux_source_directory(./ APP_SRC)
add_library (app ${APP_SRC})

target_link_libraries(app
    hal
    board
)