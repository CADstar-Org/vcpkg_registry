vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CADstarGmbH/cupoch
    REF 6ced8f6fa66d45f74e39aee5195d73dbfcbf7835
    SHA512 656cfe3b6ba241a5e9ee6ca63791462bf5af97f14afce1058ad39b6f6eb7d9970d205f29e53bf39a662774dcca1327d2493ab4f1e3aab453ffdf10cc69f8c9b2  
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
