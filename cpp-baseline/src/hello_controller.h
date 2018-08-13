#pragma once

#include "cpprest/http_listener.h"
#include <iostream>
#include "hello_controller.h"
#include <boost/lexical_cast.hpp>

class HelloController {
protected:
    utility::string_t url;
    web::http::experimental::listener::http_listener listener;

public:
    explicit HelloController(utility::string_t url) : url(url), listener(url) {
        listener.support(web::http::methods::GET,
                         std::__1::bind(&HelloController::handleGet, this, std::__1::placeholders::_1));
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

    void handleGet(const web::http::http_request &message) {
        try {
            auto paths = web::http::uri::split_path(web::http::uri::decode(message.relative_uri().path()));
            web::json::value response;


            if (paths.empty()) {
                response["hello"] = web::json::value::string("world");
                message.reply(web::http::status_codes::OK, response);
            } else {
                response["request"] = web::json::value::string(paths[0]);
                auto count = boost::lexical_cast<int>(paths[0]);
                response["fibonacci"] = fibonacci(count);
                message.reply(web::http::status_codes::OK, response);
            }
        }
        catch (std::exception &e) {
            std::cerr << "something went wrong processing request! :(" << e.what() << '\n';
            message.reply(web::http::status_codes::InternalError);
        }
    }

    web::json::value fibonacci(int n) {
        web::json::value result;
        int t1 = 0;
        int t2 = 1;
        int nextTerm = 0;
        int index = 0;

        nextTerm = t1 + t2;

        while (nextTerm <= n) {
            result[index++] = web::json::value::number(nextTerm);
            t1 = t2;
            t2 = nextTerm;
            nextTerm = t1 + t2;
        }
        return result;
    }
};