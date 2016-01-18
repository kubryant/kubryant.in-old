package main

import (
    "net/http"
    "log"
)

func main() {
    r := router()
    log.Fatal(http.ListenAndServe(":8080", r))
}
