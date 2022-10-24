cmake_minimum_required(VERSION 3.11)
project(opengv)

IF (NOT DEFINED SKIP_INSTALL_HEADERS)
    install(DIRECTORY "opengv-1.0/include/" DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
endif()

install(FILES
        opengv-1.0/lib/opengv.lib
        DESTINATION ${CMAKE_INSTALL_PREFIX}/dbeug/lib)

install(FILES
        opengv-1.0/lib/opengv.lib
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)
