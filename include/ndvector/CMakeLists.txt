add_library(ndvector INTERFACE)
target_include_directories(ndvector INTERFACE ${CMAKE_SOURCE_DIR}/include)

set_property(TARGET ndvector PROPERTY CXX_STANDARD 20)

if (WIN32)
    file(GLOB_RECURSE NDVECTOR_SRC CONFIGURE_DEPENDS "*.h")
    add_library(ndvector_ ${NDVECTOR_SRC})
    set_target_properties(ndvector_ PROPERTIES LINKER_LANGUAGE CXX)
    target_link_libraries(ndvector_ ndvector)
    set_property(TARGET ndvector_ PROPERTY CXX_STANDARD 20)
endif()

