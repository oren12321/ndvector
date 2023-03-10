if (DEFINED IN_DOCKER)
    find_package(GTest REQUIRED)
endif()

add_subdirectory(ndvector)

