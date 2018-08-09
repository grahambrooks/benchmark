cmake_minimum_required(VERSION 3.12)
set(CMAKE_CXX_STANDARD 14)

project(cpp-baseline)
file(GLOB OPENSSL_ROOT_DIR /usr/local/opt/openssl/)

find_package(Boost REQUIRED COMPONENTS system thread log program_options chrono)
find_package(Threads REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(cpprestsdk REQUIRED)

add_executable(${PROJECT_NAME} src/main.cpp)

target_link_libraries(${PROJECT_NAME} PRIVATE cpprestsdk::cpprest ${Boost_LIBRARIES})