#!/bin/bash

# 设置库路径并运行Go测试
if [[ "$OSTYPE" == "darwin"* ]]; then
    export DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH
    echo "设置macOS库路径: DYLD_LIBRARY_PATH=.:$DYLD_LIBRARY_PATH"
else
    export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
    echo "设置Linux库路径: LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH"
fi

echo "运行Go测试..."
go test -v

if [ $? -eq 0 ]; then
    echo "✅ 所有测试通过！"
else
    echo "❌ 测试失败"
    exit 1
fi