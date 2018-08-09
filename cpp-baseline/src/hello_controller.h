#pragma once

//
// Created by Graham Brooks on 8/9/18.
//

#include "cpprest/http_listener.h"
#include <iostream>
#include "hello_controller.h"

class HelloController {
protected:
    utility::string_t url;
    web::http::experimental::listener::http_listener listener;

public:
    explicit HelloController(utility::string_t url) : url(url), listener(url) {
        listener.support(web::http::methods::GET, std::__1::bind(&HelloController::handleGet, this, std::__1::placeholders::_1));
    }

    pplx::task<void> accept() {
        return listener.open();
    }

    pplx::task<void> shutdown() {
        return listener.close();
    }

    const utility::string_t endpoint() {
        return url;
    }

    void handleGet(const web::http::http_request& message) {
        message.reply(web::http::status_codes::OK, "Hello");
    }
};