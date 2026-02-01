package main

import (
	"flag"
	"log/slog"
	"net/http"
	"os"
	"strings"
)

type application struct {
	logger *slog.Logger
}

func main() {
	addr := flag.String("addr", ":8080", "HTTP network address")
	flag.Parse()

	logger := slog.New(slog.NewTextHandler(os.Stdout, nil))
	app := &application{
		logger: logger,
	}

	logger.Info("starting server", "addr", *addr)

	err := http.ListenAndServe(*addr, app.routes())
	logger.Error(err.Error())
	os.Exit(1)
}

func neuter(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		if strings.HasSuffix(r.URL.Path, "/") {
			http.NotFound(w, r)
			return
		}

		next.ServeHTTP(w, r)
	})
}
