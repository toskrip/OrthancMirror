# Orthanc - A Lightweight, RESTful DICOM Store
# Copyright (C) 2012-2016 Sebastien Jodogne, Medical Physics
# Department, University Hospital of Liege, Belgium
# Copyright (C) 2017-2023 Osimis S.A., Belgium
# Copyright (C) 2021-2023 Sebastien Jodogne, ICTEAM UCLouvain, Belgium
#
# This program is free software: you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.


include(CheckIncludeFiles)
include(CheckIncludeFileCXX)
include(CheckLibraryExists)
include(FindPythonInterp)
include(${CMAKE_CURRENT_LIST_DIR}/../../../../OrthancFramework/Resources/CMake/AutoGeneratedCode.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../../../../OrthancFramework/Resources/CMake/DownloadPackage.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../../../../OrthancFramework/Resources/CMake/Compiler.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/OrthancPluginsExports.cmake)


if (CMAKE_COMPILER_IS_GNUCXX)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -pedantic")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -pedantic")
endif()


if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
  # Linking with "pthread" is necessary, otherwise the software crashes
  # http://sourceware.org/bugzilla/show_bug.cgi?id=10652#c17
  link_libraries(dl rt pthread)
endif()

include_directories(${CMAKE_CURRENT_LIST_DIR}/../../Include/)

if (MSVC)
  if (MSVC_VERSION LESS 1600)
  # Starting with Visual Studio >= 2010 (i.e. macro _MSC_VER >=
  # 1600), Microsoft ships a standard-compliant <stdint.h>
  # header. For earlier versions of Visual Studio, give access to a
  # compatibility header.
  # http://stackoverflow.com/a/70630/881731
  # https://en.wikibooks.org/wiki/C_Programming/C_Reference/stdint.h#External_links
  include_directories(${CMAKE_CURRENT_LIST_DIR}/../../../../OrthancFramework/Resources/ThirdParty/VisualStudio/)
  endif()
endif()

add_definitions(
  -DHAS_ORTHANC_EXCEPTION=0
  -DORTHANC_BUILDING_FRAMEWORK_LIBRARY=0
  )
