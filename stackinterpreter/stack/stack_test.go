package stack

import "testing"

func TestEval(t *testing.T) {
	cases := []struct {
		in   []string
		want string
	}{
		{[]string{"2", "2", "+"}, "4"},
		{[]string{"4", "3", "-"}, "-1"},
		{[]string{"1", "3", "-", "2", "+"}, "4"},
		{[]string{"3", "4", "-", "3", "+", "2", "-", "5", "+"}, "3"},
	}

	for _, c := range cases {
		testStack := NewStack()
		for _, elem := range c.in {
			testStack.Push(elem)
		}
		testStack.Eval()
		res, _ := testStack.Pop()
		if res != c.want {
			t.Errorf("Result: %q | Wants: %q on input: %q", res, c.want, c.in)
		}
	}
}
