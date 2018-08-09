#pragma once

#include "cpprest/http_listener.h"
#include <iostream>

class InterruptHandler {
public:
    static void hookSIGINT();

    static void handleUserInterrupt(int signal);

    static void waitForUserInterrupt();
};