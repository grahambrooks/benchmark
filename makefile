

all:	clojure-benchmark/target/clojure-benchmark-0.1.0-SNAPSHOT-standalone.jar	\
	cpp-baseline/build/cpp-baseline							\
	golang-baseline/service								\
	java-spring/target/java-spring-boot-0.1.0.jar					\
	rust-benchmark/target/debug/rust-benchmark					\
	swift-kitura/.build/x86_64-apple-macosx10.10/release/swift-kitura



clojure-benchmark/target/clojure-benchmark-0.1.0-SNAPSHOT-standalone.jar:
	cd clojure-benchmark; lein uberjar

cpp-baseline/build/cpp-baseline:
	mkdir -p cpp-baseline/build
	cd build
	cd cpp-baseline/build; cmake -DOPENSSL_ROOT_DIR=/usr/local/opt/openssl -DOPENSSL_INCLUDE_DIR=/usr/local/opt/openssl/include ..
	cd cpp-baseline/build; make

golang-baseline/service:
	go build golang-baseline/service.go

java-spring/target/java-spring-boot-0.1.0.jar:
	cd java-spring; mvn package

rust-benchmark/target/debug/rust-benchmark:
	cd rust-benchmark; cargo build



swift-kitura/.build/x86_64-apple-macosx10.10/release/swift-kitura:
	cd swift-kitura; swift build -c release

clean:
	rm -rf clojure-benchmark/target
	rm -rf cpp-baseline/build
	rm golang-baseline/service
	rm -rf rust-benchmark/target
	rm -rf swift-kitura/.build
