cmake_minimum_required(VERSION 3.15)
project(zh_laird_server)

set(CMAKE_CXX_STANDARD 14)

include_directories(zh_server/src
        zh_server/src/include
        zh_server/src/common)

add_executable(zh_laird_server
        zh_server/src/include/protocol.h
        zh_server/src/server.cpp
        zh_server/src/zh_server.cpp
        zh_server/src/zh_server.h)
