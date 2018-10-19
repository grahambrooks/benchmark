#!/bin/bash

make

figlet Java Spring Boot

java -jar java-spring/target/java-spring-boot-0.1.0.jar&

APP_PID=$!

echo "Spring boot API started as process $APP_PID"

sleep 10

locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/java-spring-locust.txt

kill -9 $APP_PID

figlet JavaSpark

java -jar java-spark/target/java-spark-1.0-SNAPSHOT.jar&
APP_PID=$!

sleep 2

locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/java-spark-locust.txt

kill -9 $APP_PID

sleep 2

figlet GoLang

golang-baseline/service&
APP_PID=$!

sleep 5
locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/golang-locust.txt
kill -9 $APP_PID

sleep 2

figlet C++

cpp-baseline/build/cpp-baseline & 
APP_PID=$!

sleep 5
locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/cpp-locust.txt
kill -9 $APP_PID
sleep 2

figlet Rust

ROCKET_PORT=8080 ROCKET_LOG=critical rust-benchmark/target/release/rust-benchmark&
APP_PID=$!

sleep 5
locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/rust-locust.txt
kill -9 $APP_PID
sleep 2
figlet Swift Kitura

swift-kitura/.build/x86_64-apple-macosx10.10/release/swift-kitura&
APP_PID=$!

sleep 5
locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/swift-kitura-locust.txt
kill -9 $APP_PID
sleep 2

figlet Clojure

cd clojure-benchmark
lein ring server-headless 8080&
APP_PID=$!
cd ..

sleep 15
locust -f framework-locust.py --host http://localhost:8080 -c 40 -r 40 -t 1m --no-web --only-summary 2> data/benchmark/clojure-locust.txt
kill -9 $APP_PID

sleep 2
