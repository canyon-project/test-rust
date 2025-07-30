# 使用指南

## 快速开始

### 1. 下载预编译版本（推荐）

从 [Releases页面](https://github.com/canyon-project/test-rust/releases) 下载对应平台的文件：

- **Linux**: `rust-add-linux-x86_64.tar.gz`
- **macOS Intel**: `rust-add-macos-x86_64.tar.gz`
- **macOS Apple Silicon**: `rust-add-macos-aarch64.tar.gz`

### 2. 解压并使用

```bash
# Linux/macOS
tar -xzf rust-add-*.tar.gz
cd rust-add-*

# 设置库路径并测试
if [[ "$OSTYPE" == "darwin"* ]]; then
    export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH
else
    export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
fi
go test -v
```

### 3. 在你的项目中使用

```go
package main

import (
    "fmt"
    rustadd "github.com/canyon-project/test-rust"
)

func main() {
    // 整数加法
    result := rustadd.Add(10, 20)
    fmt.Printf("10 + 20 = %d\n", result)
    
    // 浮点数加法
    floatResult := rustadd.AddFloat(3.14, 2.86)
    fmt.Printf("3.14 + 2.86 = %f\n", floatResult)
}
```

## 从源码构建

### 前置要求

- Rust 1.70+
- Go 1.21+
- C编译器 (gcc/clang/MSVC)

### 构建步骤

```bash
# 克隆仓库
git clone https://github.com/canyon-project/test-rust
cd test-rust

# 构建
./build.sh

# 测试
go test -v

# 运行示例
go run example/main.go
```

## 开发

### 添加新函数

1. 在 `src/lib.rs` 中添加Rust函数：

```rust
#[no_mangle]
pub extern "C" fn multiply(a: c_int, b: c_int) -> c_int {
    a * b
}
```

2. 在 `add.go` 中添加Go包装：

```go
/*
int multiply(int a, int b);
*/

func Multiply(a, b int) int {
    return int(C.multiply(C.int(a), C.int(b)))
}
```

3. 添加测试到 `add_test.go`

4. 重新构建和测试

### 发布新版本

```bash
# 使用发布脚本
./scripts/release.sh v1.1.0
```

## 故障排除

### 常见问题

1. **找不到动态库**
   - 确保库文件在当前目录或系统库路径中
   - 检查文件名是否正确（不同平台不同）

2. **CGO编译错误**
   - 确保安装了C编译器
   - 检查CGO环境变量设置

3. **链接错误**
   - 确保Rust库已正确构建
   - 检查目标架构是否匹配

### 调试

启用详细输出：

```bash
# 构建时显示详细信息
CGO_LDFLAGS="-v" go build -x

# 运行时显示库加载信息
DYLD_PRINT_LIBRARIES=1 ./your-program  # macOS
LD_DEBUG=libs ./your-program           # Linux

# 设置库路径
export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH  # macOS
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH      # Linux
```

## 性能考虑

- FFI调用有一定开销，避免在热路径中频繁调用
- 对于大量数据处理，考虑批量传递
- 复杂数据结构传递需要额外的序列化/反序列化成本

## 安全注意事项

- 所有FFI函数都标记为 `unsafe`，使用时需要注意
- 确保传递的数据类型和大小正确
- 避免传递无效指针或超出范围的数据