package main

import (
	"net/http"

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

	e.Run(standard.New(":" + c["port"]))

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
