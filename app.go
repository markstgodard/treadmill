package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", index)
	err := http.ListenAndServe(":"+os.Getenv("PORT"), nil)
	if err != nil {
		panic(err)
	}
}

func index(res http.ResponseWriter, req *http.Request) {
	fmt.Fprintln(res, "¯\\_(ツ)_/¯")
}
