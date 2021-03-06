# Set target name
set(target osgPop)

# msvc compiler fix
if(MSVC)
	set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /bigobj")
endif(MSVC)


# Set include directories
include_directories(
    ${OPENSCENEGRAPH_INCLUDE_DIRS}
    ${OPENGL_INCLUDE_DIR}
)

# Define source files
set(sources
	ConvertToLevelOfDetailGeometryVisitor.cpp
	ConvertToLevelOfDetailGeometryVisitor.h
	HalfEdge.h
    LevelOfDetailGeometry.cpp
    LevelOfDetailGeometry.h
    LevelOfDetailDrawElements.cpp
    LevelOfDetailDrawElements.h
	Vec3ui.h
)

# Create executable
add_library(${target} SHARED ${sources})
add_definitions(-DOSG_LIBRARY)

IF(MSVC)  
 #   SET(CMAKE_CXX_FLAGS /bigobj)
ENDIF(MSVC)

target_link_libraries(${target}
    ${OPENSCENEGRAPH_LIBRARIES}
    ${OPENGL_LIBRARIES}    
)

# Setup Install Target
install(TARGETS ${target}
	RUNTIME DESTINATION bin CONFIGURATIONS
	LIBRARY DESTINATION lib CONFIGURATIONS
    ARCHIVE DESTINATION lib CONFIGURATIONS
	PUBLIC_HEADER DESTINATION include CONFIGURATIONS)