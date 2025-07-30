# Rust Add FFI for Go

[![CI](https://github.com/canyon-project/test-rust/actions/workflows/ci.yml/badge.svg)](https://github.com/canyon-project/test-rust/actions/workflows/ci.yml)
[![Release](https://github.com/canyon-project/test-rust/actions/workflows/release.yml/badge.svg)](https://github.com/canyon-project/test-rust/actions/workflows/release.yml)

这是一个通过FFI将Rust函数暴露给Go语言使用的示例项目。

## 功能

- `Add(a, b int) int`: 添加两个整数
- `AddFloat(a, b float64) float64`: 添加两个浮点数

## 构建

### 前置要求

- Rust (cargo)
- Go 1.21+
- C编译器 (gcc/clang)

### 构建步骤

1. 构建Rust库（自动检测架构）：
```bash
chmod +x build.sh
./build.sh
```

2. 运行Go测试：
```bash
# 方式一：使用便捷脚本（推荐）
chmod +x run_tests.sh
./run_tests.sh

# 方式二：手动设置环境变量
export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH  # macOS
export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH      # Linux
go test -v
```

## 使用方法

### 方式一：使用预编译的Release版本（推荐）

1. 从 [Releases页面](https://github.com/canyon-project/test-rust/releases) 下载对应平台的压缩包
2. 解压到你的Go项目目录
3. 在你的Go代码中导入：

```go
package main

import (
    "fmt"
    rustadd "github.com/canyon-project/test-rust"
)

func main() {
    result := rustadd.Add(5, 3)
    fmt.Printf("5 + 3 = %d\n", result)
    
    floatResult := rustadd.AddFloat(2.5, 3.7)
    fmt.Printf("2.5 + 3.7 = %f\n", floatResult)
}
```

### 方式二：作为Go模块使用

在你的Go项目中：

```bash
go get github.com/canyon-project/test-rust
```

然后需要先构建Rust库：

```bash
# 克隆仓库
git clone https://github.com/canyon-project/test-rust
cd test-rust

# 构建
./build.sh

# 复制库文件到你的项目目录
cp librust_add.* /path/to/your/project/
```

## 注意事项

1. 使用前需要先运行 `build.sh` 构建Rust库
2. 确保动态库文件在Go程序的运行路径中
3. 不同操作系统的动态库文件名不同：
   - macOS: `librust_add.dylib`
   - Linux: `librust_add.so`

## 发布流程

项目使用GitHub Actions自动构建和发布：

1. **CI流程**: 每次push和PR都会触发自动测试
2. **Release流程**: 创建tag时自动构建多平台版本并发布

### 手动发布

```bash
# 使用发布脚本
./scripts/release.sh v1.0.0
```

### 支持的平台

- Linux x86_64
- macOS x86_64 (Intel)
- macOS aarch64 (Apple Silicon)

## 文档

- [使用指南](USAGE.md) - 详细的使用说明和故障排除
- [示例代码](example/main.go) - 完整的使用示例

## 项目结构

```
.
├── .github/workflows/   # GitHub Actions工作流
├── scripts/            # 发布脚本
├── src/               # Rust源代码
├── example/           # Go使用示例
├── Cargo.toml         # Rust项目配置
├── go.mod             # Go模块配置
├── add.go             # Go包装代码
├── add_test.go        # Go测试
├── build.sh           # 构建脚本
├── README.md          # 项目说明
└── USAGE.md           # 使用指南
```