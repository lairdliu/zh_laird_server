cmake_minimum_required(VERSION 3.12)
project(zh_laird_server)

set(CMAKE_CXX_STANDARD 14)

include_directories(zh_server/src)

add_executable(zh_laird_server
        zh_server/src/protocol.h
        zh_server/src/server.cpp)
