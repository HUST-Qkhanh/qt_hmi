# include(FetchContent)

# FetchContent_Declare(json URL https://github.com/nlohmann/json/releases/download/v3.11.3/json.tar.xz)
# FetchContent_MakeAvailable(json)

# Find required packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  std_stamped_msgs
)

find_package(libmongocxx REQUIRED)
find_package(libbson-1.0 REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(nlohmann_json 3.2.0 REQUIRED)
find_package(yaml-cpp REQUIRED)

catkin_package(CATKIN_DEPENDS
  roscpp
  std_msgs
  std_stamped_msgs
)

# Include directories
target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE
  ${CMAKE_CURRENT_SOURCE_DIR}/include
  "/usr/local/include/mongocxx/v_noabi"
  "/usr/local/include/bsoncxx/v_noabi"
  "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc"
  "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc/core"
  "/usr/include/boost"
  ${catkin_INCLUDE_DIRS}
  /home/khanh/mav_ws/devel/include
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
    # nlohmann_json::nlohmann_json
    /usr/lib/x86_64-linux-gnu/libyaml-cpp.so
    )