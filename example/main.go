package main

import (
    "fmt"
    rustadd "github.com/canyon-project/test-rust"
)

func main() {
    // 测试整数加法
    result := rustadd.Add(5, 3)
    fmt.Printf("5 + 3 = %d\n", result)
    
    result2 := rustadd.Add(-10, 15)
    fmt.Printf("-10 + 15 = %d\n", result2)
    
    // 测试浮点数加法
    floatResult := rustadd.AddFloat(2.5, 3.7)
    fmt.Printf("2.5 + 3.7 = %f\n", floatResult)
    
    floatResult2 := rustadd.AddFloat(-1.5, 2.8)
    fmt.Printf("-1.5 + 2.8 = %f\n", floatResult2)
}