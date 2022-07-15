cmake_minimum_required(VERSION 2.8.3)

FIND_PACKAGE(PythonInterp)
FIND_PACKAGE(PythonLibs)
FIND_PACKAGE(Boost COMPONENTS python)

INCLUDE_DIRECTORIES(${Boost_INCLUDE_DIRS} ${PYTHON_INCLUDE_DIRS})
LINK_LIBRARIES(${BOOST_LIBRARIES} ${PYTHON_LIBARIES})

add_library(foo SHARED
    pymodule.cc
    foo.cc)

# set prefix otherwise the output will be libfoo.so instead of foo.so
set_target_properties(foo PROPERTIES PREFIX "")

target_link_libraries(foo
    ${BOOST_LIBRARIES}
    ${PYTHON_LIBARIES}
    )
