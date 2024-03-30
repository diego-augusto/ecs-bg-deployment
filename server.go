package main

import "net/http"

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("OK"))
}

func main() {
	http.HandleFunc("/api/v1/health", healthHandler)
	http.ListenAndServe(":8080", nil)
}
