package rustadd

import "testing"

func TestAdd(t *testing.T) {
	tests := []struct {
		a, b, expected int
	}{
		{2, 3, 5},
		{-1, 1, 0},
		{0, 0, 0},
		{100, 200, 300},
	}

	for _, test := range tests {
		result := Add(test.a, test.b)
		if result != test.expected {
			t.Errorf("Add(%d, %d) = %d; expected %d", test.a, test.b, result, test.expected)
		}
	}
}

func TestAddFloat(t *testing.T) {
	tests := []struct {
		a, b, expected float64
	}{
		{2.5, 3.5, 6.0},
		{-1.1, 1.1, 0.0},
		{0.0, 0.0, 0.0},
		{100.25, 200.75, 301.0},
	}

	for _, test := range tests {
		result := AddFloat(test.a, test.b)
		if result != test.expected {
			t.Errorf("AddFloat(%f, %f) = %f; expected %f", test.a, test.b, result, test.expected)
		}
	}
}
