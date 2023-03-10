if (DEFINED IN_DOCKER)
    find_package(benchmark REQUIRED)
endif()

add_executable(ndvector_benchmark
    ndvector.cpp
    main.cpp)
target_link_libraries(ndvector_benchmark benchmark::benchmark ndvector)
set_property(TARGET ndvector_benchmark PROPERTY CXX_STANDARD 20)

