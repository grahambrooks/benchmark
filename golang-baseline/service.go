package main

import (
	"log"
	"net/http"
	"encoding/json"
)

func main() {
	http.HandleFunc("/hello", func(w http.ResponseWriter, r *http.Request) {

		var hello = make(map[string]string);
		hello["hello"] = "world";
		json.NewEncoder(w).Encode(hello)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))

}
