package main

import (
	"fmt"
	"runtime"
)

func main() {
	fmt.Printf("You successfully ran consumer!\nFrom %s\nP.S. From some-project-one", runtime.GOARCH)
}
