# benchmark

Simple web services that can be used for basic benchmarking

Each benchmark target application implements the same Restful interface.

## /framework

This endpoint can be used to understand the execution costs of the framework in use. Any data collected would also include any network latency but that should be relatively constant across frameworks and language choices.

    {
        Hello: "world"
    }

## /benchmark?count=10000

This endpoint creates the specified number of unique strings and then returns the first 10.

    {
    results: [
        "Index 0",
        "Index 1",
        "Index 2",
        "Index 3",
        "Index 4",
        "Index 5",
        "Index 6",
        "Index 7",
        "Index 8",
        "Index 9"
        ]
    }

The idea behind this endpoint is that it simulates some server side processing and resource allocation while still maintaining a very low over the wire transport costs. This can be useful to evaluate the runtime for the chosen language and framework for any jitter in responses due to garbage collection events.

## 

## cpp-baseline
C++ / Microsoft cpprestsdk [https://github.com/Microsoft/cpprestsdk]()

Build and Run

    cd cpp-baseline
    mkdir build
    cd build
    cmake -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include ..
    make
    ./cpp-baseline

## Languages and frameworks

C++ / cpprestsdk


This example is in cpp-baseline

