package stack

import (
	"errors"
	"fmt"
	"os"
	"strconv"
	"sync"
)

type stack struct {
	lock  sync.Mutex // Thread safety!!
	elems []string
}

// NewStack returns a pointer to a new empty stack
func NewStack() *stack {
	return &stack{sync.Mutex{}, make([]string, 0)}
}

func (st *stack) Push(v string) {
	st.lock.Lock()
	defer st.lock.Unlock()

	st.elems = append(st.elems, v)
}

func (st *stack) Pop() (string, error) {
	st.lock.Lock()
	defer st.lock.Unlock()

	l := len(st.elems)
	if l == 0 {
		return "", errors.New("Empty Stack")
	}

	res := st.elems[l-1]
	st.elems = st.elems[:l-1]
	return res, nil
}

func (st *stack) PrintStack(out *os.File) {
	for i := len(st.elems) - 1; i >= 0; i-- {
		out.WriteString(st.elems[i] + "\n")
	}
}

func (st *stack) Eval() {
	symbol, err := st.Pop()
	if err != nil {
		fmt.Println("Could not pop from stack, quitting...")
		os.Exit(-1)
	}
	switch symbol {
	case "+":
		handleSum(st)
	case "-":
		handleSub(st)
	case "s":
		handleSwap(st)
	default:
		st.Push(symbol)
	}
}

//handleSum now also supports nested operations
func handleSum(st *stack) {
	str1, _ := st.Pop()
	str2, _ := st.Pop()
	if str2 == "+" {
		handleSum(st)
		str2, _ = st.Pop()
	}
	if str2 == "-" {
		handleSub(st)
		str2, _ = st.Pop()
	}
	val1, err1 := strconv.Atoi(str1)
	val2, err2 := strconv.Atoi(str2)
	if err1 != nil || err2 != nil {
		fmt.Println("I wasn't able to pop a number out of the stack, quitting...")
		os.Exit(-1)
	}
	st.Push(strconv.Itoa(val1 + val2))
}

//handleSub supports subtractions and nested operations
func handleSub(st *stack) {
	str1, _ := st.Pop()
	str2, _ := st.Pop()
	if str2 == "+" {
		handleSum(st)
		str2, _ = st.Pop()
	}
	if str2 == "-" {
		handleSub(st)
		str2, _ = st.Pop()
	}
	val1, err1 := strconv.Atoi(str1)
	val2, err2 := strconv.Atoi(str2)
	if err1 != nil || err2 != nil {
		fmt.Println("I wasn't able to pop a number out of the stack, quitting...")
		os.Exit(-1)
	}
	st.Push(strconv.Itoa(val1 - val2))
}

func handleSwap(st *stack) {
	elem1, err1 := st.Pop()
	elem2, err2 := st.Pop()
	if err1 != nil || err2 != nil {
		fmt.Println("I wasn't able to pop enough elements out of the stack, quitting...")
		os.Exit(-1)
	}
	st.Push(elem1)
	st.Push(elem2)
}
