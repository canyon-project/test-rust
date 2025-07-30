#!/bin/bash

# 构建Rust库
echo "构建Rust库..."
cargo build --release

# 复制动态库到当前目录并设置库路径
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    cp target/release/librust_add.dylib ./librust_add.dylib
    echo "已复制 librust_add.dylib"
    export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    cp target/release/librust_add.so ./librust_add.so
    echo "已复制 librust_add.so"
    export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
fi

echo "构建完成！"
echo "提示：如果运行Go程序时遇到库加载问题，请确保设置了正确的库路径环境变量"