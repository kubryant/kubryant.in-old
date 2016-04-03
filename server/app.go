package main

import (
	"net/http"

	"github.com/elazarl/go-bindata-assetfs"

	"github.com/labstack/echo"
	"github.com/labstack/echo/engine/standard"
	"github.com/labstack/echo/middleware"
)

type App struct {
}

func NewApp() *App {
	app := &App{}
	// app.Run()

	t := NewTemplate()
	c := NewConfig()
	e := echo.New()

	e.SetRenderer(t)

	e.Use(middleware.Logger())
	e.Use(middleware.Recover())

	e.Get("/", home())
	e.Get("/*", client())

	e.Run(standard.New(":" + c.Get("port")))

	return app
}

// func (app *App) Run() {
// 	fmt.Println("run!")

// 	data, err := Asset("static/home.html")
// 	if err != nil {
// 		fmt.Println("err", err)
// 	}

// 	s := string(data[:])
// 	fmt.Println("s", s)
// }

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
