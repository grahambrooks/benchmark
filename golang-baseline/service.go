package main

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
)

func main() {
	http.HandleFunc("/framework", func(w http.ResponseWriter, r *http.Request) {
		var hello = make(map[string]string)
		hello["hello"] = "world"
		json.NewEncoder(w).Encode(hello)
	})
	http.HandleFunc("/benchmark", func(w http.ResponseWriter, r *http.Request) {
		var data []string
		for i := 0; i < 10000; i++ {
			data = append(data, fmt.Sprintf("Index %d", i))
		}

		var result []string
		for i := 0; i < 10; i++ {
			result = append(result, data[i])
		}
		var response = make(map[string][]string)
		response["results"] = result
		json.NewEncoder(w).Encode(response)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))

}
