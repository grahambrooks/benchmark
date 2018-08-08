wrk2 -t2 -c100 -d30s -R2000 --latency http://127.0.0.1:8080/hello > out/30-second-benchmark.txt

