#include <iostream>
#include <condition_variable>
#include "cpprest/http_listener.h"
#include "interrupt_handler.hpp"
#include "hello_controller.h"

using namespace std;
using namespace web;
using namespace utility;
using namespace http;
using namespace web::http::experimental::listener;


int main() {
    InterruptHandler::hookSIGINT();

    auto controller = std::make_unique<HelloController>("http://localhost:8080/hello");

    try {
        controller->accept().wait();
        std::cout << "Service running at " << controller->endpoint() << std::endl;

        InterruptHandler::waitForUserInterrupt();

        controller->shutdown().wait();
    }
    catch (std::exception &e) {
        std::cerr << "something went wrong! :(" << '\n';
    }
    return 0;
}