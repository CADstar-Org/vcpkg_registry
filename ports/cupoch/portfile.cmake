vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CADstarGmbH/cupoch
    REF e61c93298548ca6b04b65007e79c2c4a33c5f4b4
    SHA512  da8e83a7f7a87a01112f981ae2f632a7ea1f58a9915b8191b841cbc79094f008a5935d8ea3ac9a497e9e37aede2cc02a7acb41b65ed0968b292f669626ed5730  
)

# TODO: Add options for conditional build
# # Check if one or more features are a part of a package installation.
# # See /docs/maintainers/vcpkg_check_features.md for more details
# vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
#   FEATURES # <- Keyword FEATURES is required because INVERTED_FEATURES are being used
#     tbb   WITH_TBB
#   INVERTED_FEATURES
#     tbb   ROCKSDB_IGNORE_PACKAGE_TBB
# )

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    DISABLE_PARALLEL_CONFIGURE
    #CUDA_TOOLKIT_ROOT_DIR=CUDA_PATH
    OPTIONS
        -DSUPPORT_MAXWELL=OFF
        -DSUPPORT_PASCAL=OFF
        -DSUPPORT_VOLTA=OFF
        -DSUPPORT_AMPERE=OFF
        -DSUPPORT_TURING=ON
        
    )

vcpkg_install_cmake()

# Moves all .cmake files from /debug/share/cupoch/ to /share/cupoch/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake TARGET_PATH share/cupoch)

# Remove duplicated header files
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/cupoch RENAME copyright)

# Post-build test for cmake libraries
vcpkg_test_cmake(PACKAGE_NAME cupoch)
