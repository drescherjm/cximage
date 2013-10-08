OPTION(DEBUG_COMPILER_VERSION "Debug the compiler version determinarion" OFF)

# Attempt to guess the compiler suffix
# NOTE: this is not perfect yet, if you experience any issues
# please report them and use the PROJECT_COMPILER_VERSION variable
# to work around the problems.
if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel"
	OR "${CMAKE_CXX_COMPILER}" MATCHES "icl"
	OR "${CMAKE_CXX_COMPILER}" MATCHES "icpc")
  if(WIN32)
	set (PROJECT_COMPILER_VERSION "iw")
  else()
	set (PROJECT_COMPILER_VERSION "il")
  endif()
elseif (MSVC90)
  set(PROJECT_COMPILER_VERSION "vc90")
elseif (MSVC10)
  set(PROJECT_COMPILER_VERSION "vc100")
 elseif (MSVC11)
  set(PROJECT_COMPILER_VERSION "vc110")
elseif (MSVC80)
  set(PROJECT_COMPILER_VERSION "vc80")
elseif (MSVC71)
  set(PROJECT_COMPILER_VERSION "vc71")
elseif (MSVC70) # Good luck!
  set(PROJECT_COMPILER_VERSION "vc7") # yes, this is correct
elseif (MSVC60) # Good luck!
  set(PROJECT_COMPILER_VERSION "vc6") # yes, this is correct
elseif (BORLAND)
  set(PROJECT_COMPILER_VERSION "bcb")
elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "SunPro")
  set(PROJECT_COMPILER_VERSION "sw")
elseif (MINGW)
  set(PROJECT_COMPILER_VERSION "mgw") # no GCC version encoding prior to 1.34
elseif (UNIX)
  if (CMAKE_COMPILER_IS_GNUCXX)
	set(PROJECT_COMPILER_VERSION "gcc") # no GCC version encoding prior to 1.34
  endif (CMAKE_COMPILER_IS_GNUCXX)
endif()
if(DEBUG_COMPILER_VERSION)
#  message(STATUS "compiler is : ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER} ${CMAKE_CXX_COMPILER_ABI}")
  message(STATUS "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] "
	"guessed PROJECT_COMPILER_VERSION = ${PROJECT_COMPILER_VERSION}")
endif()

if (CMAKE_SIZEOF_VOID_P MATCHES 8)
	set( PROJECT_ARCH "x86_64" ) 
else(CMAKE_SIZEOF_VOID_P MATCHES 8)
	set( PROJECT_ARCH "x86" ) 
endif(CMAKE_SIZEOF_VOID_P MATCHES 8)

if (NOT "${PROJECT_COMPILER_VERSION}" STREQUAL "")
	set (${PROJECT_NAME}_VERSION_PATCH "${${PROJECT_NAME}_VERSION_PATCH}.${PROJECT_COMPILER_VERSION}")
endif (NOT "${PROJECT_COMPILER_VERSION}" STREQUAL "")

IF (CMAKE_SIZEOF_VOID_P MATCHES 8)
	set (${PROJECT_NAME}_VERSION_PATCH "${${PROJECT_NAME}_VERSION_PATCH}.${PROJECT_ARCH}")
ENDIF(CMAKE_SIZEOF_VOID_P MATCHES 8)
