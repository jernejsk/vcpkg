include(${CURRENT_INSTALLED_DIR}/share/ignitionmodularscripts/ignition_modular_library.cmake)

ignition_modular_library(NAME fuel-tools
                         VERSION "4.1.0"
                         CMAKE_PACKAGE_NAME ignition-fuel_tools4
                         SHA512 7116460749870968508a0368435edfcc28f54128b2def0d93fa48e6f6ac961d27e0f0ff52ff70979ee4e626ee4cc0d5b421180487c1973ed844a1b16479466d3
                         # This can  be removed when the pc file of curl is fixed
                         DISABLE_PKGCONFIG_INSTALL
                         )
