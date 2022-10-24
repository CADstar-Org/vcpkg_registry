set(OPENGV_VERSION 1.0)

vcpkg_download_distfile(ARCHIVE
    URLS "https://cadstar.dental/development/opengv-${OPENGV_VERSION}.7z"
    FILENAME "opengv-${OPENGV_VERSION}.7z"
    SHA512 73574b25745196ac1fb8362f14ce8c91956fcd5319d7d7c8e734ff22610e4e022ea8675128bb3fe431724ed0d1986e9ac2c23c9953646ffe0eccdd732db54a08
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    NO_REMOVE_ONE_LEVEL
    ARCHIVE ${ARCHIVE}
    REF opengv_1
)

file(COPY "${CMAKE_CURRENT_LIST_DIR}/CMakeLists.txt" DESTINATION ${SOURCE_PATH})
file(INSTALL ${SOURCE_PATH}/opengv-${OPENGV_VERSION}/share/copyright DESTINATION ${CURRENT_PACKAGES_DIR}/share/opengv RENAME copyright)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
