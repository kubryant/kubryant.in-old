package main

import (
    "net/http"
    "html/template"

    "github.com/julienschmidt/httprouter"
)

var templates *template.Template

func router() *httprouter.Router {
    r := httprouter.New()

    // routes
    r.GET("/", HomeHandler)

    // static files
    r.ServeFiles("/js/*filepath", http.Dir("client/build/js"))
    r.ServeFiles("/image/*filepath", http.Dir("client/build/image"))

    // 404
    r.NotFound = http.HandlerFunc(NotFoundHandler)

    // cache templates
    templates = template.Must(template.ParseFiles("views/home.html", "views/error.html"))

    return r
}

type Page struct {
    Header string
}

func HomeHandler(rw http.ResponseWriter, r *http.Request, p httprouter.Params) {
    err := templates.ExecuteTemplate(rw, "home.html", "")
    if err != nil {
        http.Error(rw, err.Error(), http.StatusInternalServerError)
    }
}

func NotFoundHandler(rw http.ResponseWriter, r *http.Request) {
    rw.WriteHeader(http.StatusNotFound)
    err := templates.ExecuteTemplate(rw, "error.html", "")
    if err != nil {
        http.Error(rw, err.Error(), http.StatusInternalServerError)
    }
}
