vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO fixstars/libSGM
    REF 5ec81dbd273007a004c545a6b08c6656eca27362
    SHA512 011cc5a9a2d39564877be6a153039f0f920c040f972b792a0218c3579dffafb134a3d60fbb26335d1c2a1e2c7b225956cc95f00c23b6864906ca35ede02707f4
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 

)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()
#vcpkg_copy_pdbs()

# Moves all .cmake files from /debug/share/stdgpu/ to /share/stdgpu/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/${PORT})
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib TARGET_PATH share/${PORT})
#vcpkg_fixup_cmake_targets(CONFIG_PATH share/${PORT} TARGET_PATH share/${PORT})

#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

# Post-build test for cmake libraries
#vcpkg_test_cmake(PACKAGE_NAME stdgpu)