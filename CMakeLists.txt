PROJECT(CxImage)
CMAKE_MINIMUM_REQUIRED (VERSION 2.8 FATAL_ERROR)

set (${PROJECT_NAME}_VERSION_MAJOR 7)
set (${PROJECT_NAME}_VERSION_MINOR 0)
set (${PROJECT_NAME}_VERSION_PATCH 1)

#include(${PROJECT_SOURCE_DIR}/CMake/SubversionVersionInfo.cmake)

set (${PROJECT_NAME}_VERSION_STRING "${${PROJECT_NAME}_VERSION_MAJOR}.${${PROJECT_NAME}_VERSION_MINOR}.${${PROJECT_NAME}_VERSION_PATCH}")

#########################################################################################

IF (REDUCE_MASK_SIZE)
add_definitions(-DREDUCE_MASK_SIZE)
ENDIF(REDUCE_MASK_SIZE)

#########################################################################################

include(${PROJECT_SOURCE_DIR}/CMake/GetCompilerVersion.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SiteConfig.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SetupDefaultInstallPath.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/HelperMacros.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SetCompilerOptions.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SelectDefaultConfigurations.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/DisableMSVCWarn.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/MSVCPCHSupport.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/MSVC64BitPortability.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/NamingConvention.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SetupDefaultInstallPath.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/DisableBufferSecurityCheck.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/NamingConvention.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SupportRunJobs.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/GenerateInstallScript.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/GenerateUpdateScript.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/GenerateConfigureScript.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/GetRuntime.cmake)
include(${PROJECT_SOURCE_DIR}/CMake/SupportLibraryMacros.cmake)
include(${CMAKE_ROOT}/Modules/GenerateExportHeader.cmake)

setup_naming_convention( ${PROJECT_NAME} )

#########################################################################################

SET (LIBRARY_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin CACHE INTERNAL "Single output directory for building all libraries.")
SET (EXECUTABLE_OUTPUT_PATH ${PROJECT_BINARY_DIR}/bin CACHE INTERNAL "Single output directory for building all executables.")

#IF(WIN32)
#	configure_file (
#		"${PROJECT_SOURCE_DIR}/install.bat.in"
#		"${PROJECT_BINARY_DIR}/Batch/install.bat"
#	)
#ENDIF(WIN32)

if (WIN32)
	add_definitions(-DWIN32)
endif(WIN32)

SET( ${PROJECT_NAME}_SRCS
	./tif_xfile.cpp
	./ximabmp.cpp
	./ximadsp.cpp
	./ximaenc.cpp
	./ximaexif.cpp
	./ximage.cpp
	./ximagif.cpp
	./ximahist.cpp
	./ximaico.cpp
	./ximainfo.cpp
	./ximaint.cpp
	./ximajas.cpp
	./ximajbg.cpp
	./ximajpg.cpp
	./ximalpha.cpp
	./ximalyr.cpp
	./ximamng.cpp
	./ximapal.cpp
	./ximapcx.cpp
	./ximapng.cpp
	./ximapsd.cpp
	./ximaraw.cpp
	./ximasel.cpp
	./ximaska.cpp
	./ximatga.cpp
	./ximath.cpp
	./ximatif.cpp
	./ximatran.cpp
	./ximawbmp.cpp
	./ximawmf.cpp
	./ximawnd.cpp
	./xmemfile.cpp
)

SET( ${PROJECT_NAME}_EXT_HDRS 
	./stdint.h
	./xfile.h
	./ximabmp.h
	./ximacfg.h
	./ximadef.h
	./ximage.h
	./ximagif.h
	./ximaico.h
	./ximaiter.h
	./ximajas.h
	./ximajbg.h
	./ximajpg.h
	./ximamng.h
	./ximapcx.h
	./ximapng.h
	./ximapsd.h
	./ximaraw.h
	./ximaska.h
	./ximatga.h
	./ximath.h
	./ximatif.h
	./ximawbmp.h
	./ximawmf.h
	./xiofile.h
	./xmemfile.h
)

SET( ${PROJECT_NAME}_INT_HDRS
	"${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.h"
)

configure_file (
	"${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}Config.h.in"
	"${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.h"
)

include_directories( ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_BINARY_DIR}/.. ${CMAKE_CURRENT_SOURCE_DIR}/include )

add_library(${PROJECT_NAME} ${LIB_TYPE} ${${PROJECT_NAME}_SRCS} ${${PROJECT_NAME}_EXT_HDRS} ${${PROJECT_NAME}_INT_HDRS} )

set( ${PROJECT_NAME}_INCLUDE_DIRS 
	${CMAKE_CURRENT_SOURCE_DIR}/include 
	${CMAKE_CURRENT_BINARY_DIR}
) 

configure_library_for_export(${PROJECT_NAME})

install (TARGETS ${PROJECT_NAME} DESTINATION lib)
install (FILES ${${PROJECT_NAME}_EXT_HDRS} DESTINATION include)