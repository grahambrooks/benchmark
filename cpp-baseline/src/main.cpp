#include <iostream>
#include <condition_variable>
#include "cpprest/http_listener.h"
#include "interrupt_handler.hpp"
using namespace std;
using namespace web;
using namespace utility;
using namespace http;
using namespace web::http::experimental::listener;


class HelloController {
protected:
    http_listener listener;

public:
    explicit HelloController(utility::string_t url) : listener(url) {
        listener.support(methods::GET, std::bind(&HelloController::handleGet, this, std::placeholders::_1));
    }

    pplx::task<void> accept() {
        return listener.open();
    }

    pplx::task<void> shutdown() {
        return listener.close();
    }

    void handleGet(const web::http::http_request& message) {
        message.reply(web::http::status_codes::OK, "Hello");
    }
};

int main() {
    std::cout << "Hello, World!" << std::endl;
    InterruptHandler::hookSIGINT();

    auto controller = std::make_unique<HelloController>("http://localhost:8080/hello");

    try {
        controller->accept().wait();
        std::cout << "Service running" << std::endl;

        InterruptHandler::waitForUserInterrupt();

        controller->shutdown().wait();
    }
    catch (std::exception &e) {
        std::cerr << "somehitng wrong happen! :(" << '\n';
    }
    return 0;
}