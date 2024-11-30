vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO CADstarGmbH/cupoch
    REF 58601777107d7c386eaec3b31346af7c811e7a65
    SHA512 9c5391a140702336e532ff2dee6f1aaebc5d8183b1a5ac2beca701867eb2439429eef99104eda8acf7d288c9d2030d8706659181de0d18912872fbb041ec0260  
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
        -DCMAKE_CUDA_ARCHITECTURES=all-major
        -DCMAKE_CXX_FLAGS=/utf-8
        -DCMAKE_CUDA_FLAGS=-Xcompiler=/utf-8
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
