vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO stotko/stdgpu
    REF 3b7d712b5c3a5e0db71cf690df7b94bb470a397b
    SHA512 867794aa6628ebfcc3e898e3e16b7f2b826ae904b9bd697554a50f68a51de829aa15f65bec6f60e1f00d6a020de204e2c2733d777b21dcbad16eb06c0c80e136
    HEAD_REF master
    PATCHES fix-buildsystem.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS 
        -DSTDGPU_BUILD_SHARED_LIBS:BOOL=OFF
        -DCMAKE_CUDA_ARCHITECTURES:STRING="all-major"
        -DSTDGPU_BUILD_BENCHMARKS:BOOL=OFF
        -DSTDGPU_BUILD_EXAMPLES:BOOL=OFF
        -DSTDGPU_BUILD_TESTS:BOOL=OFF
        -DSTDGPU_ENABLE_CONTRACT_CHECKS:BOOL=OFF
        # TODO: Make backend optional
        -DSTDGPU_BACKEND:STRING=STDGPU_BACKEND_CUDA
)

vcpkg_install_cmake()

#vcpkg_fixup_cmake_targets()
#vcpkg_copy_pdbs()

# Moves all .cmake files from /debug/share/stdgpu/ to /share/stdgpu/
# See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/${PORT} TARGET_PATH share/${PORT})
#vcpkg_fixup_cmake_targets(CONFIG_PATH lib TARGET_PATH share/${PORT})
#vcpkg_fixup_cmake_targets(CONFIG_PATH share/${PORT} TARGET_PATH share/${PORT})
						  
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
#file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/lib")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
