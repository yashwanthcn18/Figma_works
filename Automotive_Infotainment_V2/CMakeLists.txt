cmake_minimum_required(VERSION 3.16)

project(Automotive_Infotainment_V2 VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 6.5 REQUIRED COMPONENTS Quick)

qt_standard_project_setup(REQUIRES 6.5)

qt_add_executable(appAutomotive_Infotainment_V2
    main.cpp
)

# Only include actual QML files here
qt_add_qml_module(appAutomotive_Infotainment_V2
    URI Automotive_Infotainment_V2
    VERSION 1.0
    QML_FILES
        Main.qml
        SOURCES screensaver.h screensaver.cpp
)

# Separate section to add the .qrc file
qt_add_resources(appAutomotive_Infotainment_V2 "appImages"
    PREFIX "/"
    FILES
        Main.qml
        logo.png
)

set_target_properties(appAutomotive_Infotainment_V2 PROPERTIES
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

target_link_libraries(appAutomotive_Infotainment_V2
    PRIVATE Qt6::Quick
)

include(GNUInstallDirs)
install(TARGETS appAutomotive_Infotainment_V2
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
