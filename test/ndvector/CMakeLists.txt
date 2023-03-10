add_executable(ndvector_test
    ndvector.cpp
    main.cpp)
target_link_libraries(ndvector_test GTest::gtest GTest::gtest_main ndvector)
set_property(TARGET ndvector_test PROPERTY CXX_STANDARD 20)

