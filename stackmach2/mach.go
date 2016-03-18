package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"

	"github.com/asolda/golangExperience/stackmach2/stack"
)

var pushToStack = regexp.MustCompile("^[0-9]*$")

func main() {

	scanner := bufio.NewScanner(os.Stdin)
	fmt.Printf("> ")
	s := stack.NewStack()
	for scanner.Scan() {
		in := scanner.Text()
		s.Convert(in)
		fmt.Printf("> ")
	}
}
