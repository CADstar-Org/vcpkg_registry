cmake_minimum_required(VERSION 3.11)
project(opengv)

IF (NOT DEFINED SKIP_INSTALL_HEADERS)
    install(FILES "opengv/include/opengv" DESTINATION ${CMAKE_INSTALL_PREFIX}/include)
endif()

install(FILES
        opengv/lib/opengv.lib
        DESTINATION ${CMAKE_INSTALL_PREFIX}/lib)