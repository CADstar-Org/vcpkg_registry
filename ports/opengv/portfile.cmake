vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO laurentkneip/opengv
    REF 91f4b19c73450833a40e463ad3648aae80b3a7f3
    SHA512  4d733b0c29cfd262926ceb7e0a666f50b2e493e50a4aba98090bd7aa398f4181f5a023961103a0ed6045e5b0193b40bb68c31bbc97a9d1fd1f06499e17a24535  
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/libvh)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/opengv RENAME copyright)
