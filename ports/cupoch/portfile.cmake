vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO neka-nat/cupoch
    REF 17a8f13e9355e7634a8155b211f8ba1dd53dfefc
    SHA512 5dad938d7c9510a44f03d3f2bded0dbaa2e068f37d1a4a039e2da15fa9c329c7c700ad4f2a5bcce9965ee59cf6783b6cccc411ce479695a9d98f2a0b073ef79f  
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
