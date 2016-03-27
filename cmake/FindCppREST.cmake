IF(UNIX)
    FIND_PATH(CPP_REST_INCLUDE_DIR http_client.h
      "$ENV{LIB_DIR}/include"
      "$ENV{LIB_DIR}/include/cpprest"
      "${CMAKE_SOURCE_DIR}/include"
      "${CMAKE_SOURCE_DIR}/include/cpprest"
      #mingw
      c:/msys/local/include
      NO_DEFAULT_PATH
      )

    SET(CMAKE_FIND_LIBRARY_PREFIXES "" "lib")
    SET(CMAKE_FIND_LIBRARY_SUFFIXES ".so" ".a" ".lib")
    FIND_LIBRARY(CPP_REST_LIBRARY NAMES cpprest PATHS
      $ENV{LIB}
      /usr/lib
      "$ENV{LIB_DIR}/lib"
      "${CMAKE_SOURCE_DIR}/lib"
      #mingw
      c:/msys/local/lib
      NO_DEFAULT_PATH
      )
ELSE()
    FIND_PATH(CPP_REST_INCLUDE_DIR http_client.h
        "${PROJECT_ROOT}/include/cpprest"
      )

    FILE(GLOB CPP_REST_LIBRARY NAMES
        "${PROJECT_ROOT}/lib/cpprest*.lib"
        "${PROJECT_ROOT}/lib/cpprest*.a"
        )
ENDIF()


IF (CPP_REST_INCLUDE_DIR AND CPP_REST_LIBRARY)
    SET(CPP_REST_FOUND TRUE)
ENDIF (CPP_REST_INCLUDE_DIR AND CPP_REST_LIBRARY)


IF (CPP_REST_FOUND)

   IF (NOT CPP_REST_FIND_QUIETLY)
       MESSAGE(STATUS "Found C++ REST: ${CPP_REST_LIBRARY}")
   ENDIF (NOT CPP_REST_FIND_QUIETLY)

ELSE (CPP_REST_FOUND)

    IF (CPP_REST_FIND_REQUIRED)
        MESSAGE(FATAL_ERROR "Could not find C++ REST")
  ENDIF (CPP_REST_FIND_REQUIRED)

ENDIF (CPP_REST_FOUND)
