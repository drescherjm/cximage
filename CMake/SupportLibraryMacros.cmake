#########################################################################################
#
#	This module contains a few Macros that help with creating libraries.
#
#########################################################################################

# Allow the developer to select if Dynamic or Static libraries are built
OPTION (BUILD_SHARED_LIBS "Build Shared Libraries" OFF)

if (BUILD_SHARED_LIBS)
	# User wants to build Dynamic Libraries, so change the LIB_TYPE variable to CMake keyword 'SHARED'
	SET (LIB_TYPE SHARED)
else(BUILD_SHARED_LIBS)
	SET (LIB_TYPE STATIC)
	
endif (BUILD_SHARED_LIBS)

#########################################################################################

macro( add_library_module ModuleName )
	get_property(is_defined GLOBAL PROPERTY MODULE_LIST DEFINED)
	if(NOT is_defined)
		define_property(GLOBAL PROPERTY MODULE_LIST
			BRIEF_DOCS "List of library modules"
			FULL_DOCS "List of library modules")
	endif()
	set_property(GLOBAL APPEND PROPERTY MODULE_LIST "${ModuleName}")	
endmacro( add_library_module )

#########################################################################################

macro( configure_library_for_export LibraryName )
	configure_file (
		"${CMAKE_SOURCE_DIR}/CMake/DefaultLibraryConfig.cmake.in"
		"${CMAKE_CURRENT_BINARY_DIR}/${LibraryName}Config.cmake"
	)

	if (NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${LibraryName}USE.cmake.in") 
		configure_file ( 
			"${CMAKE_SOURCE_DIR}/CMake/DefaultLibraryUSE.cmake.in"
			"${CMAKE_CURRENT_BINARY_DIR}/${LibraryName}USE.cmake"
			@ONLY
		)
	else(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${LibraryName}USE.cmake.in")
		configure_file ( 
			"${CMAKE_CURRENT_SOURCE_DIR}/${LibraryName}USE.cmake.in"
			"${CMAKE_CURRENT_BINARY_DIR}/${LibraryName}USE.cmake"
			@ONLY
		)
	endif(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/${LibraryName}USE.cmake.in")
	
	export( TARGETS ${LibraryName} FILE ${LibraryName}Exported.cmake)

	GENERATE_EXPORT_HEADER( ${LibraryName} 
		BASE_NAME ${LibraryName}
		EXPORT_MACRO_NAME ${LibraryName}_EXPORT
		EXPORT_FILE_NAME "${CMAKE_CURRENT_BINARY_DIR}/${LibraryName}LibraryDefines.h"
		STATIC_DEFINE ${LibraryName}_STATIC
	)
	
endmacro( configure_library_for_export )