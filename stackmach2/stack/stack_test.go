package stack

import "testing"

func TestEval(t *testing.T) {
	cases := []struct {
		in   string
		want string
	}{
		{"2 + 2", "4"},
		{"4 - 3", "1"},
		{"1 - 3 + 2", "0"},
		{"1 + 10 - 1", "10"},
		{"3 - 4 + 3 - 2 + 5", "5"},
		{"10 - 10 + 10 - 10", "0"},
		{"120 + 2 - 12+43", "153"},
	}

	for _, c := range cases {
		testStack := NewStack()

		testStack.Convert(c.in)
		res, _ := testStack.Pop()
		if res != c.want {
			t.Errorf("Result: %q | Wants: %q on input: %q", res, c.want, c.in)
		}
	}
}
