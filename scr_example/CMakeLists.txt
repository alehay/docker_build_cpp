cmake_minimum_required(VERSION 3.5)
cmake_policy(SET CMP0079 NEW)
cmake_policy(SET CMP0060 NEW)

string(ASCII 27 ESC)

##############################################################
##########          Метаданыне проекта         ###############
##############################################################

project(test_hello_world )

set(CMAKE_BUILD_TYPE Release) # <------------------ поставь режим сборки!!!!!

set(CPACK_PACKAGE_VENDOR "test")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "/usr/bin" )
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "test")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "0")
set(CPACK_PACKAGE_VERSION_PATCH "0")

add_definitions(-D MAJOR=${CPACK_PACKAGE_VERSION_MAJOR})
add_definitions(-D MINOR=${CPACK_PACKAGE_VERSION_MINOR})
add_definitions(-D PATCH=${CPACK_PACKAGE_VERSION_PATCH})
add_definitions(-DTYPE=" ${CMAKE_BUILD_TYPE}")

##############################################################
##########          Опции компиляции           ###############
##############################################################

set(C_HEADER_SUFFIX "h")
set(C_SOURCE_SUFFIX "c")
set(CXX_HEADER_SUFFIX "hpp")
set(CXX_SOURCE_SUFFIX "cpp")

set(CMAKE_C_COMPILER /usr/bin/gcc-10)
set(CMAKE_CPP_COMPILER /usr/bin/g++-10)


set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# debag options 
message("${ESC}[31m${ESC}")
message("CMAKE_BUILD_TYPE = ${CMAKE_BUILD_TYPE}")
message("${ESC}[0m${ESC}")

IF(CMAKE_BUILD_TYPE MATCHES Debug)
  message("${ESC}[31m${ESC}")
  message(" ——————————► DEBUG ◄—————————— ")
  message("${ESC}[0m${ESC} -")

  #add_compile_options(-Werror)
  add_compile_options(-pedantic-errors)
  add_compile_options(-Wall)
  add_compile_options(-Wextra)
  add_compile_options(-pg -ggdb -O0 -g3 -pg)
  add_compile_options(-Wfloat-equal) 
  add_compile_options( -Wpointer-arith)
  add_compile_options( -Wstrict-overflow=5) 
  add_compile_options( -Wwrite-strings) 
  add_compile_options( -Waggregate-return)
  add_compile_options( -Wswitch-default -Wswitch-enum)
  add_compile_options( -Wconversion) 
  add_compile_options( -Wunreachable-code)
  add_compile_options( -fstack-clash-protection -fstack-protector	-fcf-protection)
  add_compile_options( -fasynchronous-unwind-tables)
  
  add_compile_definitions(DEBUG)
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a")


ELSEIF(CMAKE_BUILD_TYPE MATCHES Release)
message("${ESC}[32m${ESC}")
message("\t————————► RELEASE ◄————————")
message("${ESC}[0m${ESC}")
  add_compile_options( -O2  -std=c++2a )
  SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++2a")

  add_compile_definitions(RELEASE)

ELSE()
   message("${ESC}[31m${ESC}")
  message( FATAL_ERROR "ALARM Build type abort")
  message("${ESC}[0m${ESC} ")
ENDIF()


##############################################################
##########          Включение исходников       ###############
##############################################################


message(" scr load ")
add_subdirectory(scr)


##############################################################
##########          Настройки DEB пакета       ###############
##############################################################
INSTALL(TARGETS ${PROJECT_NAME} DESTINATION /usr/bin)
#INSTALL(FILES Icons/RQExhib.png DESTINATION /reetiPrograms/RApplications/Icons)

#Cpak - deb пакет
set(CPACK_GENERATOR "DEB")
#set(CPACK_GENERATOR "deb")
set(CPACK_PACKAGE_NAME ${PROJECT_NAME})





message("${ESC}[35m${ESC}")
message("————————► VER ${CPACK_PACKAGE_VERSION_MAJOR}.${CPACK_PACKAGE_VERSION_MINOR}.${CPACK_PACKAGE_VERSION_PATCH} ◄————————")
message("${ESC}[0m${ESC}")

set(CPACK_PACKAGE_INSTALL_DIRECTORY /usr/bin)

set(CPACK_COMPONENTS_ALL ${PROJECT_NAME})
# Include CPack to introduce the appropriate targets
include(CPack)
