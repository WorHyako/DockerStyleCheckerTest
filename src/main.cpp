#include <iostream>
#include "Include/HeaderExample.hpp"
#include <map>
namespace
NumFooBar{
namespace {enum Numbers {One,Two,Three};}

class
Foo {};

template<typename T>
class Bar :
        public
        Foo
        {
        public:
            Bar()
            =
                    default;
            [[nodiscard]] std::map<    std::string,T> Do() noexcept;
};
}

template<typename T>std::map<std::string, T> NumFooBar::Bar<T>::Do() noexcept {return {};}

int main() {
    std::cout << "Hello, style checker!" << std::endl;
    return 0;
}
