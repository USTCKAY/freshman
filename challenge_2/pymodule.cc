#include <boost/python.hpp>
#include "foo.h"

using namespace boost::python;

BOOST_PYTHON_MODULE(foo){
        class_<Foo>("Foo",
                     init<int, int, std::string>())
                .def("bar", &Foo::bar)
        ;

        def("duh",duh);
}
