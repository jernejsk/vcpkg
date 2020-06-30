include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO ignitionrobotics/ign-common
    REF ignition-common3_3.6.0
    SHA512 1aa7751573468b8d804845e9c49beeb5b33a31d5bb54f31ea2fa766fe7928ee9257f3ec38680ac12584ee9397f4fe6659e05140ee86cc8337766d48e5d68ff74
    HEAD_REF ign-common3
    PATCHES fix-import.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DBUILD_TESTING=OFF -DIGN_PROFILER_REMOTERY:BOOL=OFF
)

vcpkg_install_cmake()

# If necessary, move the CMake config files
if(EXISTS "${CURRENT_PACKAGES_DIR}/lib/cmake")
    # Some ignition libraries install library subcomponents, that are effectively additional cmake packages
    # with name ignition-common3-${COMPONENT_NAME}, so it is needed to call vcpkg_fixup_cmake_targets for them as well
    file(GLOB COMPONENTS_CMAKE_PACKAGE_NAMES
          LIST_DIRECTORIES TRUE
          RELATIVE "${CURRENT_PACKAGES_DIR}/lib/cmake/"
          "${CURRENT_PACKAGES_DIR}/lib/cmake/*")

    foreach(COMPONENT_CMAKE_PACKAGE_NAME IN LISTS COMPONENTS_CMAKE_PACKAGE_NAMES)
        vcpkg_fixup_cmake_targets(CONFIG_PATH "lib/cmake/${COMPONENT_CMAKE_PACKAGE_NAME}"
                                  TARGET_PATH "share/${COMPONENT_CMAKE_PACKAGE_NAME}"
                                  DO_NOT_DELETE_PARENT_CONFIG_PATH)
    endforeach()

    file(GLOB_RECURSE CMAKE_RELEASE_FILES
                      "${CURRENT_PACKAGES_DIR}/lib/cmake/ignition-common3/*")

    file(COPY ${CMAKE_RELEASE_FILES} DESTINATION
              "${CURRENT_PACKAGES_DIR}/share/ignition-common3/")
endif()

# Remove unused files files
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/cmake
                    ${CURRENT_PACKAGES_DIR}/debug/include
                    ${CURRENT_PACKAGES_DIR}/debug/lib/cmake
                    ${CURRENT_PACKAGES_DIR}/debug/share)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig
                    ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)

# Find the relevant license file and install it
if(EXISTS "${SOURCE_PATH}/LICENSE")
    set(LICENSE_PATH "${SOURCE_PATH}/LICENSE")
elseif(EXISTS "${SOURCE_PATH}/README.md")
    set(LICENSE_PATH "${SOURCE_PATH}/README.md")
endif()
file(INSTALL ${LICENSE_PATH} DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
