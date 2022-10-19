vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO soroush/libvh
    REF 0d9298971b4b9b73fe8de99bf432cd33ffc3bf3b
    SHA512 af69104c6b30ebd1a40778321472b47787d1f972f30a20c373f296416ffa99b8a1db14c4aac046daf857b7d5e8dec10058294e2c530b1fede224429d433b7fd3
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/libvh/ to /share/libvh/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/libvh)
file(REMOVE_RECURSE 
    "${CURRENT_PACKAGES_DIR}/debug/"
    "${CURRENT_PACKAGES_DIR}/lib")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/libvh RENAME copyright)

# Post-build test for cmake libraries
# vcpkg_test_cmake(PACKAGE_NAME libvh)
