#include <iostream>
#include "cpprest/http_listener.h"
#include "interrupt_handler.hpp"

static std::condition_variable _condition;
static std::mutex _mutex;

void InterruptHandler::hookSIGINT() {
    signal(SIGINT, handleUserInterrupt);
}

void InterruptHandler::handleUserInterrupt(int signal) {
    if (signal == SIGINT) {
        std::__1::cout << "SIGINT trapped ..." << '\n';
        _condition.notify_one();
    }
}

void InterruptHandler::waitForUserInterrupt() {
    std::__1::unique_lock<std::__1::mutex> lock{_mutex};
    _condition.wait(lock);
    std::__1::cout << "user has signaled to interrup program..." << '\n';
    lock.unlock();
}
