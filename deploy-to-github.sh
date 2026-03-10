#!/bin/bash
# 部署到 GitHub Pages 脚本

set -e

echo "=========================================="
echo "部署到 GitHub Pages"
echo "=========================================="
echo ""

# 检查 git
if ! command -v git &> /dev/null; then
    echo "❌ 错误: 未找到 git"
    exit 1
fi

# 获取 GitHub 用户名
echo "请输入你的 GitHub 用户名:"
read USERNAME

if [ -z "$USERNAME" ]; then
    echo "❌ 用户名不能为空"
    exit 1
fi

REPO_URL="https://github.com/$USERNAME/hungary-chinese-guide.git"

echo ""
echo "将部署到: $REPO_URL"
echo ""

# 检查是否已初始化 git
if [ ! -d ".git" ]; then
    echo "📦 初始化 git 仓库..."
    git init
else
    echo "✅ git 仓库已存在"
fi

# 配置 git（如果未配置）
if ! git config user.email &> /dev/null; then
    echo "配置 git 邮箱..."
    git config user.email "your-email@example.com"
fi

if ! git config user.name &> /dev/null; then
    echo "配置 git 用户名..."
    git config user.name "Your Name"
fi

# 添加所有文件
echo "📄 添加文件到 git..."
git add .

# 提交
echo "💾 提交更改..."
git commit -m "Initial commit: Hungary Chinese Life Guide - $(date '+%Y-%m-%d')" || echo "没有新更改需要提交"

# 添加远程仓库
echo "🔗 添加远程仓库..."
git remote remove origin 2>/dev/null || true
git remote add origin "$REPO_URL"

# 推送
echo "🚀 推送到 GitHub..."
git push -u origin main --force || git push -u origin master --force

echo ""
echo "=========================================="
echo "✅ 推送成功！"
echo "=========================================="
echo ""
echo "下一步："
echo "1. 访问 https://github.com/$USERNAME/hungary-chinese-guide"
echo "2. 点击 Settings → Pages"
echo "3. Source 选择 'Deploy from a branch'"
echo "4. Branch 选择 'main' / '(root)'"
echo "5. 点击 Save"
echo ""
echo "等待 2-5 分钟后访问:"
echo "https://$USERNAME.github.io/hungary-chinese-guide/"
echo ""
