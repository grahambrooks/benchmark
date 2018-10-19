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
 GET /benchmark                                                 21759     0(0.00%)       8       5      41  |       7  365.90
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  21759      7      9      9     10     12     14     16     18     41
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Rust 

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 13664     0(0.00%)       4       2      18  |       3  228.20
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  13664      3      4      4      5      6      7      8     10     18
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Go

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 21952     0(0.00%)       7       3      34  |       6  369.30
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  21952      6      7      9      9     12     14     17     19     34
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Swift Kitura

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  8423     0(0.00%)     180      36     309  |     180  143.70
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                   8423    180    190    190    190    200    210    220    230    310
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Java Spring Boot

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 20914     0(0.00%)      12       6     338  |      10  356.50
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  20914     10     12     13     14     17     20     25     29    340
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Clojure & Compojure


```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                   498     0(0.00%)    4490    2475    7403  |    4500    8.80
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                    498   4500   4800   5000   5100   5500   5800   6200   6500   7400
--------------------------------------------------------------------------------------------------------------------------------------------

```

### Java Spark

```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                 20886     0(0.00%)      12       6     458  |      10  360.60
--------------------------------------------------------------------------------------------------------------------------------------------

Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 GET /benchmark                                                  20886     10     11     12     13     15     18     23     45    460
--------------------------------------------------------------------------------------------------------------------------------------------

```


# Comparison


```
 Name                                                          # reqs      # fails     Avg     Min     Max  |  Median   req/s
--------------------------------------------------------------------------------------------------------------------------------------------
 C++ cpprestsdk                                                 21759     0(0.00%)       8       5      41  |       7  365.90
 Rust                                                           13664     0(0.00%)       4       2      18  |       3  228.20
 Go                                                             21952     0(0.00%)       7       3      34  |       6  369.30
 Swift Kitura                                                    8423     0(0.00%)     180      36     309  |     180  143.70
 Java Spring Boot                                               20914     0(0.00%)      12       6     338  |      10  356.50
 Java Spark                                                     20886     0(0.00%)      12       6     458  |      10  360.60
 Clojure                                                          498     0(0.00%)    4490    2475    7403  |    4500    8.80
--------------------------------------------------------------------------------------------------------------------------------------------
```

## Percentile data

```
Percentage of the requests completed within given times
 Name                                                           # reqs    50%    66%    75%    80%    90%    95%    98%    99%   100%
--------------------------------------------------------------------------------------------------------------------------------------------
 C++ cpprestsdk                                                  21759      7      9      9     10     12     14     16     18     41
 Rust                                                            13664      3      4      4      5      6      7      8     10     18
 Go                                                              21952      6      7      9      9     12     14     17     19     34
 Swift Kitura                                                     8423    180    190    190    190    200    210    220    230    310
 Java Spring Boot                                                20914     10     12     13     14     17     20     25     29    340
 Java Spark                                                      20886     10     11     12     13     15     18     23     45    460
 Clojure                                                           498   4500   4800   5000   5100   5500   5800   6200   6500   7400
--------------------------------------------------------------------------------------------------------------------------------------------
```
