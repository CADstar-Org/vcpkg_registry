set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)

if(${PORT} MATCHES "tbb")
  message(STATUS "${PORT} will be built as static")
  set(VCPKG_LIBRARY_LINKAGE static)
else()
set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()
