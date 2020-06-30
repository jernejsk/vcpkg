include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO osrf/gazebo
    REF gazebo11_11.0.0
    SHA512 b97f5617b813acfc783ccf966f9e2f0d4b18a0b2409eb1b12b7a7b092f46f4c5d5803223f59f5e505300fd97fca874c7a6a4b767d45145fe417a7f59805e06a5
    HEAD_REF gazebo11
    PATCHES fixes.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
#    OPTIONS -DBUILD_TESTING=OFF -DIGN_PROFILER_REMOTERY:BOOL=OFF
)

vcpkg_install_cmake()

# Find the relevant license file and install it
if(EXISTS "${SOURCE_PATH}/LICENSE")
    set(LICENSE_PATH "${SOURCE_PATH}/LICENSE")
elseif(EXISTS "${SOURCE_PATH}/README.md")
    set(LICENSE_PATH "${SOURCE_PATH}/README.md")
endif()
file(INSTALL ${LICENSE_PATH} DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
