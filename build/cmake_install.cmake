# Install script for directory: /home/khanh/mav_ws/src/qt_hmi

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/khanh/Qt/6.8.0/gcc_64")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/khanh/mav_ws/src/qt_hmi/build/RosQML2Content/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/khanh/mav_ws/src/qt_hmi/build/RosQML2/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/khanh/mav_ws/src/qt_hmi/build/App/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/khanh/mav_ws/src/qt_hmi/build/_deps/ds-build/cmake_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHECK
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           RPATH "\$ORIGIN:\$ORIGIN/../lib")
    endif()
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/khanh/mav_ws/src/qt_hmi/build/Debug/RosQML2App")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHANGE
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           OLD_RPATH "/home/khanh/Qt/6.8.0/gcc_64/lib:/opt/ros/noetic/lib:/usr/local/lib:"
           NEW_RPATH "\$ORIGIN:\$ORIGIN/../lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      endif()
    endif()
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHECK
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           RPATH "\$ORIGIN:\$ORIGIN/../lib")
    endif()
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/khanh/mav_ws/src/qt_hmi/build/Release/RosQML2App")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHANGE
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           OLD_RPATH "/home/khanh/Qt/6.8.0/gcc_64/lib:/opt/ros/noetic/lib:/usr/local/lib:"
           NEW_RPATH "\$ORIGIN:\$ORIGIN/../lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      endif()
    endif()
  elseif("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHECK
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           RPATH "\$ORIGIN:\$ORIGIN/../lib")
    endif()
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/home/khanh/mav_ws/src/qt_hmi/build/RelWithDebInfo/RosQML2App")
    if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App" AND
       NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      file(RPATH_CHANGE
           FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App"
           OLD_RPATH "/home/khanh/Qt/6.8.0/gcc_64/lib:/opt/ros/noetic/lib:/usr/local/lib:"
           NEW_RPATH "\$ORIGIN:\$ORIGIN/../lib")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/RosQML2App")
      endif()
    endif()
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/khanh/mav_ws/src/qt_hmi/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
