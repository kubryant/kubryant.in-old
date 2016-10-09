package main

import (
	"fmt"

	"gopkg.in/yaml.v2"
)

type Config struct {
	configMap map[string]string
}

func (c *Config) Get(key string) string {
	data, ok := c.configMap[key]

	if ok {
		return data
	}

	return ""
}

func NewConfig() *Config {
	c := make(map[string]string)
	cs, err := Asset("conf/config.yml/config.yml")

	error := yaml.Unmarshal(cs, &c)
	if error != nil {
		fmt.Println("error parsing config", err)
	}

	return &Config{
		configMap: c,
	}
}
