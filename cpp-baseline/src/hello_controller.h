#pragma once

#include "cpprest/http_listener.h"
#include <iostream>
#include "hello_controller.h"
#include <boost/lexical_cast.hpp>
#include <algorithm>

static const std::string key = "count";

static const int BUFFER_LENGTH = 1024;

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
            if (paths[0] == "framework") {
                framework(message);
            } else if (paths[0] == "benchmark") {
                auto query = web::http::uri::split_query(message.relative_uri().query());
                long count = 10000;
                if (query.count(key) > 0) {
                    auto it = query.find(key);
                    if (it != query.end())
                        count = stol(it->second);
                }
                benchmark(message, count);
            } else {
                message.reply(web::http::status_codes::BadRequest);
            }
        }
        catch (std::exception &e) {
            std::cerr << "something went wrong processing request! :(" << e.what() << '\n';
            message.reply(web::http::status_codes::InternalError);
        }
    }

    void framework(const web::http::http_request &message) {
        web::json::value response;
        response["hello"] = web::json::value::string("world");
        message.reply(web::http::status_codes::OK, response);
    }

    void benchmark(const web::http::http_request &message, long count) {
        std::vector<web::json::value> data;
        char buffer[BUFFER_LENGTH];
        for (long i = 0; i < count; i++) {
            std::snprintf(buffer, BUFFER_LENGTH, "Index %ld", i);
            data.push_back(web::json::value::string(buffer));
        }

        web::json::value response;
        data.resize((unsigned long) std::min(10L, count));
        response["results"] = web::json::value::array(data);
        message.reply(web::http::status_codes::OK, response);
    }
};
