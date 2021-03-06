option (MAKE_DEBUGRELEASE 			"Add support for building a Release Target with debug info" ON)

IF (MAKE_DEBUGRELEASE)
SET (CMAKE_CONFIGURATION_TYPES "Debug;RelWithDebInfo" CACHE STRING "Debug;RelWithDebInfo" FORCE)
SET (RELEASE_BUILD_NAME "RelWithDebInfo")
ELSE(MAKE_DEBUGRELEASE)
SET (CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "Debug;Release" FORCE)
SET (RELEASE_BUILD_NAME "Release")
ENDIF (MAKE_DEBUGRELEASE)
