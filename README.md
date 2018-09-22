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

The following results were collected on:

    Mac Pro (Late 2013)
    Processor: 3.5 GHz 6-Core Intel Xeon E5
    Memory: 16 GB 1866 MHz DDR3

The /benchmark enpoint was used with the default 10000 strings being created and returning the first 10 entries

Performance tests were run for 1 minute with 40 concurrent users. Why 40? The cpprestsdk framework has a hard coded thread limit of 40 for it's thread pool so for basic comparisons 40 user connections was used for all the tests below using https://locust.io All times are in ms.

    locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary


### C++ / cpprestsdk

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 21780     0(0.00%)       8       5      30  |       7  365.50
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                          21780     0(0.00%)                                     365.50

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  21780      7      8      9     10     11     13     15     17     30
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                           21780      7      8      9     10     11     13     15     17     30
```

### Rust 

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 13296     0(0.00%)       6       5      21  |       6  221.90
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                          13296     0(0.00%)                                     221.90

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  13296      6      6      7      7      8      9     10     11     21
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                           13296      6      6      7      7      8      9     10     11     21

```

### Go

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 21866     0(0.00%)       7       3      36  |       6  369.00
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                          21866     0(0.00%)                                     369.00

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  21866      6      8      9     10     13     15     18     20     36
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                           21866      6      8      9     10     13     15     18     20     36
```

### Swift Kitura

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  8651     0(0.00%)     172      38     247  |     170  145.80
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                           8651     0(0.00%)                                     145.80

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                   8651    170    180    180    180    190    190    200    200    250
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                            8651    170    180    180    180    190    190    200    200    250
```

### Java Spring Boot

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 21082     0(0.00%)      12       6     351  |      10  357.90
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                          21082     0(0.00%)                                     357.90

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  21082     10     12     13     14     17     19     24     29    350
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                           21082     10     12     13     14     17     19     24     29    350

```

### Clojure & Compojure

lein ring server-headless 8080

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                   511     0(0.00%)    4367    1755    6868  |    4400    9.20
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                            511     0(0.00%)                                       9.20

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                    511   4400   4700   4900   5000   5300   5600   5900   6100   6900
--------------------------------------------------------------------------------------------------------------------------------------------
 Total                                                             511   4400   4700   4900   5000   5300   5600   5900   6100   6900

```


# Comparison


```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 C++ cpprestsdk                                                 21780     0(0.00%)       8       5      30  |       7  365.50
 Rust                                                           13296     0(0.00%)       6       5      21  |       6  221.90
 Go                                                             21866     0(0.00%)       7       3      36  |       6  369.00
 Swift Kitura                                                    8651     0(0.00%)     172      38     247  |     170  145.80
 Java Spring Boot                                               21082     0(0.00%)      12       6     351  |      10  357.90
 Clojure                                                          511     0(0.00%)    4367    1755    6868  |    4400    9.20
--------------------------------------------------------------------------------------------------------------------------------------------
```

## Percentile data

```
Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 C++ cpprestsdk                                                  21780      7      8      9     10     11     13     15     17     30
 Rust                                                            13296      6      6      7      7      8      9     10     11     21
 Go                                                              21866      6      8      9     10     13     15     18     20     36
 Swift Kitura                                                     8651    170    180    180    180    190    190    200    200    250
 Java Spring Boot                                                21082     10     12     13     14     17     19     24     29    350
 Clojure                                                           511   4400   4700   4900   5000   5300   5600   5900   6100   6900
--------------------------------------------------------------------------------------------------------------------------------------------
```
