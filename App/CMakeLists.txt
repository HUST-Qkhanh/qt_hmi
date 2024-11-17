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

  # /home/mkac/mav_ws/devel/include
  /home/mkac/amr_ws/devel/include
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


# BUILD TEST
# add_executable(singleton_db_test
#   test/singletonDb.cpp
#   include/dbManager.h
#   src/dbManager.cpp)

# target_include_directories(singleton_db_test PRIVATE
#   ${CMAKE_CURRENT_SOURCE_DIR}/include
#   "/usr/local/include/mongocxx/v_noabi"
#   "/usr/local/include/bsoncxx/v_noabi"
#   "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc"
#   "/usr/local/include/bsoncxx/v_noabi/bsoncxx/third_party/mnmlstc/core"
#   "/usr/include/boost"
#   ${catkin_INCLUDE_DIRS}
# )

# target_link_libraries(singleton_db_test
#   ${catkin_LIBRARIES}
#   /usr/local/lib/libmongocxx.so # Thay đổi đường dẫn tuyệt đối này nếu cần thiết
#   /usr/local/lib/libbsoncxx.so # Thay đổi đường dẫn tuyệt đối này nếu cần thiết
#   nlohmann_json::nlohmann_json

#   # ${libbsoncxx_LIBRARIES}
#   # ${libmongocxx_LIBRARIES}
# )
# set_target_properties(singleton_db_test PROPERTIES
#   RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/test
# )