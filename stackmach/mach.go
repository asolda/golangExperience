package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"

	"github.com/asolda/stackmach/stack"
)

var pushToStack = regexp.MustCompile("^[0-9]*$")

func main() {
	s := stack.NewStack()
	scanner := bufio.NewScanner(os.Stdin)
	fmt.Printf("> ")
	for scanner.Scan() {
		in := scanner.Text()
		switch {
		case pushToStack.MatchString(in), in == "+", in == "-", in == "s":
			s.Push(in)
		case in == "e":
			s.Eval()
		case in == "d":
			s.PrintStack(os.Stdout)
		case in == "x":
			fmt.Println("bye")
			os.Exit(0)
		}
		fmt.Printf("> ")
	}
}
