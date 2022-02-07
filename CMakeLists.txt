cmake_minimum_required(VERSION 3.22)
PROJECT(dibr)
find_package(OpenGL)
file(GLOB SRC src/*.cpp)

include_directories(include)
add_executable(${PROJECT_NAME} ${SRC})
target_link_libraries(${PROJECT_NAME} GL GLEW glfw )
