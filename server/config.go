package main

import (
	"fmt"

	"gopkg.in/yaml.v2"
)

func NewConfig() map[string]string {
	c := make(map[string]string)
	cs, err := Asset("config.yaml/config.yaml")

	error := yaml.Unmarshal(cs, &c)
	if error != nil {
		fmt.Println("error parsing config", err)
	}

	return c
}
