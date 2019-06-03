project(square)

option(SQUARE_BUILD_SHARED "build dll" Off)
option(MSVC_USE_STATIC_RUNTIME OFF)
option(MSVC_USE_MP OFF)


if(${SQUARE_BUILD_SHARED})
    add_definitions(-DSQUARE_BUILD_SHARED)
    add_library(square SHARED src/square.cpp inc/square/square.h)
else()
add_library(square STATIC src/square.cpp inc/square/square.h)
endif()
target_include_directories(square PUBLIC inc)
