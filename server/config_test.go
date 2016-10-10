package main_test

import (
	"fmt"
	"github.com/kubryant/kubryant.in/server"
	"testing"
)

func TestConfigs(t *testing.T) {
	c := main.NewConfig()
	fmt.Println(c)
}
