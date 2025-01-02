include(FetchContent)

# Fetch nlohmann/json from Git
FetchContent_Declare(
  nlohmann_json
  GIT_REPOSITORY https://github.com/nlohmann/json.git
  GIT_TAG v3.11.3
)
FetchContent_MakeAvailable(nlohmann_json)

# Fetch json-cpp from Git
FetchContent_Declare(
  yaml_cpp
  GIT_REPOSITORY https://github.com/jbeder/yaml-cpp.git
  GIT_TAG yaml-cpp-0.7.0
)
FetchContent_MakeAvailable(yaml_cpp)

# Find required packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  std_stamped_msgs
)

# find_package(mongocxx REQUIRED)
# find_package(bsoncxx REQUIRED)
find_package(Boost REQUIRED)
# find_package(libmongocxx REQUIRED)
# find_package(libbsoncxx REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(yaml-cpp REQUIRED)

catkin_package(CATKIN_DEPENDS
  roscpp
  std_msgs
  std_stamped_msgs
)

# Include directories
message(STATUS "MONGOCXX_INCLUDE_DIRS: ${Boost_INCLUDE_DIRS}")
message(STATUS "BSONCXX_INCLUDE_DIRS: ${bsoncxx_INCLUDE_DIRS}")

target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  # ${bsoncxx_INCLUDE_DIRS}
  # ${mongocxx_INCLUDE_DIRS}
  # ${bsoncxx_INCLUDE_DIRS}/v_noabi
  # ${mongocxx_INCLUDE_DIRS}/v_noabi
  ${Boost_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
  ${yaml_cpp_SOURCE_DIR}/include
  ${nlohmann_json_SOURCE_DIR}/include
  "/usr/local/include/mongocxx/v_noabi"
  "/usr/local/include/bsoncxx/v_noabi"
  "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc"
  "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc/core"
  "/usr/include/boost"

)

target_sources(${CMAKE_PROJECT_NAME} PRIVATE
  "main.cpp"
  "src/config_manager.cpp"
  "include/config_manager.h"
  "src/backend.cpp"
  "include/backend.h"
  "src/model_buffer.cpp"
  "include/model_buffer.h"
  "src/model_pallet.cpp"
  "include/model_pallet.h"
  "src/model_queue.cpp"
  "include/model_queue.h"
  "include/asyncTasks.h"
  "include/threadPoolManager.h"
  "src/asyncTasks.cpp"
  "src/threadPoolManager.cpp"
  "include/dbManager.h"
  "src/dbManager.cpp"
  "include/ultis.h"
)

target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
  Qt${QT_VERSION_MAJOR}::Core
  Qt${QT_VERSION_MAJOR}::Gui
  Qt${QT_VERSION_MAJOR}::Quick
  Qt${QT_VERSION_MAJOR}::Qml
  Qt${QT_VERSION_MAJOR}::Widgets
  ${catkin_LIBRARIES}
  /usr/local/lib/libmongocxx.so
  /usr/local/lib/libbsoncxx.so
  nlohmann_json::nlohmann_json
  yaml-cpp
)
