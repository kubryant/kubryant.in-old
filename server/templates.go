package main

import (
	"html/template"
	"io"

	"github.com/itsjamie/go-bindata-templates"

	"github.com/labstack/echo"
)

type Template struct {
	templates *template.Template
}

func (t *Template) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

func NewTemplate() *Template {
	b := binhtml.New(Asset, AssetDir)

	return &Template{
		templates: b.MustLoadDirectory("templates"),
	}
}
