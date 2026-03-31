#!/bin/bash

# 快速推送脚本 - 需要 GitHub Token
# 使用方法：./quick-push.sh YOUR_GITHUB_TOKEN

TOKEN=$1

if [ -z "$TOKEN" ]; then
    echo "❌ 请提供 GitHub Token"
    echo ""
    echo "用法："
    echo "  ./quick-push.sh <your-github-token>"
    echo ""
    echo "获取 Token:"
    echo "  1. 访问 https://github.com/settings/tokens"
    echo "  2. 创建新 token（选择 repo 权限）"
    echo "  3. 复制 token 并运行此脚本"
    exit 1
fi

cd /Users/lihao/.qoderwork/workspace/mndz13sr1had0vr1/dingtalk-minutes-tasks

# 设置远程仓库（使用 token 的 HTTPS URL）
git remote set-url origin https://${TOKEN}@github.com/emersonli/dingtalk-meeting-actionrun.git

echo "📦 推送到 GitHub..."
git push -u origin main --force

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 推送成功！"
    echo ""
    echo "仓库地址："
    echo "  https://github.com/emersonli/dingtalk-meeting-actionrun"
    echo ""
    echo "下一步："
    echo "  1. 访问仓库查看代码"
    echo "  2. 添加仓库描述和 Topics"
    echo "  3. 创建第一个 Release (v0.1.0)"
else
    echo ""
    echo "❌ 推送失败，请检查："
    echo "  - Token 是否有效"
    echo "  - 是否已在 GitHub 创建仓库"
    echo "  - 网络连接是否正常"
fi
