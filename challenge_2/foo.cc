#include <string>
#include <iostream>

class Foo{
public:
	Foo(int a, int b, std::string c){
		x = a;
		y = b;
		z = c;
	}
	std::string bar(){
		std::cout << "Hello World!" << std::endl;
	}

private:
	int x, y;
	std::string z;
};
