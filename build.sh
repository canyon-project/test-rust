#!/bin/bash

# 检测架构并设置目标
if [[ "$OSTYPE" == "darwin"* ]]; then
    ARCH=$(uname -m)
    if [[ "$ARCH" == "arm64" ]]; then
        TARGET="aarch64-apple-darwin"
        LIB_NAME="librust_add.dylib"
    else
        TARGET="x86_64-apple-darwin"
        LIB_NAME="librust_add.dylib"
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    TARGET="x86_64-unknown-linux-gnu"
    LIB_NAME="librust_add.so"
fi

echo "检测到架构: $(uname -m)"
echo "构建目标: $TARGET"

# 构建Rust库
echo "构建Rust库..."
cargo build --release --target $TARGET

# 复制动态库到当前目录
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    cp target/$TARGET/release/$LIB_NAME ./$LIB_NAME
    echo "已复制 $LIB_NAME"
    export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    cp target/$TARGET/release/$LIB_NAME ./$LIB_NAME
    echo "已复制 $LIB_NAME"
    export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
fi

echo "构建完成！"
echo "提示：如果运行Go程序时遇到库加载问题，请运行 ./run_tests.sh"