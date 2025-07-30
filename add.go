package rustadd

/*
#cgo LDFLAGS: -L. -lrust_add
#include <stdlib.h>

int add(int a, int b);
double add_float(double a, double b);
*/
import "C"

// Add 添加两个整数
func Add(a, b int) int {
	return int(C.add(C.int(a), C.int(b)))
}

// AddFloat 添加两个浮点数
func AddFloat(a, b float64) float64 {
	return float64(C.add_float(C.double(a), C.double(b)))
}
