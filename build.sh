#!/bin/bash

# 构建Rust库
echo "构建Rust库..."
cargo build --release

# 复制动态库到当前目录
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    cp target/release/librust_add.dylib ./librust_add.dylib
    echo "已复制 librust_add.dylib"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    cp target/release/librust_add.so ./librust_add.so
    echo "已复制 librust_add.so"
elif [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
    # Windows
    cp target/release/rust_add.dll ./rust_add.dll
    echo "已复制 rust_add.dll"
fi

echo "构建完成！"