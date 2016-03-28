project(HelloCppRESTsdk C CXX)
cmake_minimum_required(VERSION 3.0.0)
get_filename_component(PROJECT_ROOT ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)

# Use C++ 11
set(CMAKE_CXX_STANDARD 11)

# Use high warning levels and treat warnings as errors
if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /W4 /WX")
elseif(CMAKE_COMPILER_IS_GNUCC OR CMAKE_COMPILER_IS_GNUCXX)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Werror -Wconversion -pedantic -Wno-unknown-pragmas")
endif()

# Use custom Find-.cmake path
set(CMAKE_MODULE_PATH "${PROJECT_ROOT}/cmake")

add_definitions(-DBOOST_ALL_DYN_LINK)
SET(BOOST_ROOT "C:/Boost")                             # FindBoost.cmake handles this on its own in the linux case
SET(BOOST_LIBRARYDIR "C:/Boost/lib")
SET(BOOST_INCLUDEDIR "C:/Boost/include/boost-1_60")
find_package(Boost 1.60.0 COMPONENTS system REQUIRED)
list(APPEND INCLUDE_EXT_DIRS ${Boost_INCLUDE_DIRS})

find_package(Threads REQUIRED)

# see ./cmake/FindCppREST.cmake for details
set(CPP_REST_FOUND False)
find_package(CppREST REQUIRED) # populates CPP_REST_INCLUDE_DIR and CPP_REST_LIBRARY

if(MSVC)                        # Microsoft uses magic to handle this
    SET(LINK FLAGS "")
else()
    SET(LINK_FLAGS "-lboost_system -lssl -lcrypto")
endif()

SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${LINK_FLAGS}" )

include_directories(${PROJECT_ROOT}/include)
include_directories(SYSTEM ${CPP_REST_INCLUDE_DIR})

add_executable(helloworldspeaker speak.cpp)
target_link_libraries(helloworldspeaker "${CPP_REST_LIBRARY};${CMAKE_DL_LIBS}")

add_executable(helloworldlistener listen.cpp)
target_link_libraries(helloworldlistener "${CPP_REST_LIBRARY};${CMAKE_DL_LIBS}")
