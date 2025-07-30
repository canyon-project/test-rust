# 预编译库目录

这个目录包含不同平台的预编译Rust库文件：

- `linux-x86_64/librust_add.so` - Linux x86_64
- `darwin-x86_64/librust_add.dylib` - macOS Intel
- `darwin-arm64/librust_add.dylib` - macOS Apple Silicon

这些库文件会在release时自动构建并包含在仓库中。