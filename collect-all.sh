#!/bin/bash

figlet Java Spring Boot

cd java-spring

mvn spring-boot:run &

APP_PID=$!

cd ..

echo "Spring boot API started as process $APP_PID"

duration=60

sleep 10


ab -c 3 -t $duration -g data/benchmark/java-spring-framework.tsv http://localhost:8080/framework

ab -c 3 -t $duration -g data/benchmark/java-spring-benchmark.tsv http://localhost:8080/benchmark

function chart() {
    title=$1
    name=$2

    echo "Generating chart data/images/$name.jpg from data/benchmark/$name.tsv"
    
    gnuplot -persist <<-EOFMarker
set terminal jpeg size 500,500
set size 1, 1
set output "data/images/$name.jpg"
set title "$title"
set key left top
set grid y
set xdata time
set timefmt "%s"
set format x "%S"
set xlabel 'seconds'
set ylabel "response time (ms)"
set datafile separator '\t'
plot "data/benchmark/$name.tsv" every ::2 using 2:5 title 'response time' with points
#plot "data/benchmark/$name.tsv" every ::2 using 2:5 title 'response time' with lines
EOFMarker
}

chart "Java Framework test" java-spring-framework
chart "Java Benchmark test" java-spring-benchmark

kill -9 $APP_PID

figlet GoLang

golang-baseline/service &
APP_PID=$!

sleep 5

ab -c 3 -t $duration -g data/benchmark/golang-framework.tsv http://localhost:8080/framework

ab -c 3 -t $duration -g data/benchmark/golang-benchmark.tsv http://localhost:8080/benchmark

chart "Go Framework test" golang-framework
chart "Go Benchmark test" golang-benchmark

kill -9 $APP_PID

figlet C++

cpp-baseline/build/cpp-baseline & 
APP_PID=$!

sleep 5

ab -c 3 -t $duration -g data/benchmark/cpp-framework.tsv http://localhost:8080/framework

ab -c 3 -t $duration -g data/benchmark/cpp-benchmark.tsv http://localhost:8080/benchmark

chart "C++ Framework test" cpp-framework
chart "C++ Benchmark test" cpp-benchmark

kill -9 $APP_PID

