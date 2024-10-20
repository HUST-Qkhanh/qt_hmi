
cmake_minimum_required(VERSION 3.21.1)

option(LINK_INSIGHT "Link Qt Insight Tracker library" ON)
option(BUILD_QDS_COMPONENTS "Build design studio components" ON)

project(RosQML2App LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
message(STATUS "CMAKE_SOURCE_DIR: ${CMAKE_SOURCE_DIR}")
message(STATUS "BUILDING PROJECT: ${CMAKE_PROJECT_NAME}")


list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
list(APPEND CMAKE_PREFIX_PATH "/opt/ros/noetic")
list(APPEND CMAKE_PREFIX_PATH "/home/khanh/mav_ws/devel" "/usr/local/lib")


set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(QT_QML_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/qml)
set(QML_IMPORT_PATH ${QT_QML_OUTPUT_DIRECTORY}
    CACHE STRING "Import paths for Qt Creator's code model"
    FORCE
)

find_package(Qt6 6.8 REQUIRED COMPONENTS Core Gui Qml Quick Widgets)


if (Qt6_VERSION VERSION_GREATER_EQUAL 6.3)
    qt_standard_project_setup()
endif()

qt_add_executable(${CMAKE_PROJECT_NAME}
${CMAKE_CURRENT_SOURCE_DIR}/RosQML2.qrc)

qt_add_resources(${CMAKE_PROJECT_NAME} "configuration"
    PREFIX "/"
    FILES
		qtquickcontrols2.conf)

include(qds)

if (BUILD_QDS_COMPONENTS)
    include(qmlcomponents OPTIONAL)
endif()

if (LINK_INSIGHT)
    include(insight OPTIONAL)
endif ()

include(GNUInstallDirs)
install(TARGETS ${CMAKE_PROJECT_NAME}
  BUNDLE DESTINATION .
  LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
