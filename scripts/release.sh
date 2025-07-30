#!/bin/bash

# 发布脚本
# 用法: ./scripts/release.sh v1.0.0

set -e

if [ $# -eq 0 ]; then
    echo "用法: $0 <version>"
    echo "示例: $0 v1.0.0"
    exit 1
fi

VERSION=$1

# 检查版本格式
if [[ ! $VERSION =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "错误: 版本格式应为 vX.Y.Z (例如: v1.0.0)"
    exit 1
fi

echo "准备发布版本: $VERSION"

# 检查是否有未提交的更改
if [[ -n $(git status --porcelain) ]]; then
    echo "错误: 有未提交的更改，请先提交所有更改"
    exit 1
fi

# 检查是否在main/master分支
CURRENT_BRANCH=$(git branch --show-current)
if [[ "$CURRENT_BRANCH" != "main" && "$CURRENT_BRANCH" != "master" ]]; then
    echo "警告: 当前不在main/master分支 (当前分支: $CURRENT_BRANCH)"
    read -p "是否继续? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# 更新Cargo.toml版本
CARGO_VERSION=${VERSION#v}  # 移除v前缀
sed -i.bak "s/^version = \".*\"/version = \"$CARGO_VERSION\"/" Cargo.toml
rm Cargo.toml.bak

echo "已更新Cargo.toml版本为: $CARGO_VERSION"

# 运行测试
echo "运行测试..."
./build.sh
go test -v

if [ $? -ne 0 ]; then
    echo "错误: 测试失败"
    exit 1
fi

# 提交版本更改
git add Cargo.toml
git commit -m "chore: bump version to $VERSION"

# 创建并推送tag
echo "创建tag: $VERSION"
git tag -a "$VERSION" -m "Release $VERSION"

echo "推送到远程仓库..."
git push origin "$CURRENT_BRANCH"
git push origin "$VERSION"

echo "✅ 发布完成！"
echo "GitHub Actions将自动构建并创建release"
echo "查看进度: https://github.com/canyon-project/test-rust/actions"