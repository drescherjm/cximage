IF(MSVC)
	SET(CMAKE_CXX_FLAGS "/MP /WL /GR /EHa /Zm1000" ) 
  	
	IF(CMAKE_SIZEOF_VOID_P MATCHES 4)
		# Detect 64 bit portability problems.
		option (DETECT_64BIT_PORTABILITY 	"Warn on portability issues for 64 bit compiles" OFF)
		IF(DETECT_64BIT_PORTABILITY)
			SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /Wp64")
		ENDIF(DETECT_64BIT_PORTABILITY)
	ENDIF(CMAKE_SIZEOF_VOID_P MATCHES 4)

ENDIF(MSVC)