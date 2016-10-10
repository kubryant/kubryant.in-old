package main_test

import (
	"fmt"
	"testing"

	. "github.com/kubryant/kubryant.in/server"
)

func TestConfigs(t *testing.T) {
	c := NewConfig()
	fmt.Println(c)
}
