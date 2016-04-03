package main

import (
	"net/http"

	"github.com/elazarl/go-bindata-assetfs"

	"github.com/labstack/echo"
	"github.com/labstack/echo/engine/standard"
	"github.com/labstack/echo/middleware"
)

type App struct {
	Config    *Config
	Templates *Template
	Echo      *echo.Echo
}

func NewApp() *App {
	c := NewConfig()
	t := NewTemplate()
	e := echo.New()

	return &App{
		Config:    c,
		Templates: t,
		Echo:      e,
	}
}

func (app *App) Run() {
	app.Echo.SetRenderer(app.Templates)

	app.Echo.Use(middleware.Logger())
	app.Echo.Use(middleware.Recover())

	app.Echo.Get("/", home())
	app.Echo.Get("/*", client())

	app.Echo.Run(standard.New(":" + app.Config.Get("port")))
}

// route handlers
func home() echo.HandlerFunc {
	return func(c echo.Context) error {
		return c.Render(http.StatusOK, "home.html", "")
	}
}

func client() echo.HandlerFunc {
	clientFS := http.FileServer(
		&assetfs.AssetFS{
			Asset:     Asset,
			AssetDir:  AssetDir,
			AssetInfo: AssetInfo,
			Prefix:    "client",
		},
	)

	return standard.WrapHandler(clientFS)
}
