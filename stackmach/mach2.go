package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"github.com/luigi/golangExperience/stackmach/stack2"
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


