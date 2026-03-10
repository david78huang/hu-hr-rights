#!/bin/bash
# 修复所有文档中的链接格式（去掉 .html 扩展名，让 Jekyll 自动处理）

cd /root/.openclaw/workspace/projects/hu-hr-rights/docs

# 处理每个 md 文件
for file in *.md; do
    # 将 .html 链接改为无扩展名（Jekyll 会自动处理）
    sed -i 's/\.html)/)/g' "$file"
    sed -i 's/\.html#/)/g' "$file"
    sed -i 's/\.html"/)"/g' "$file"
    
    echo "✅ 已修复链接: $file"
done

echo ""
echo "=========================================="
echo "所有文档链接已修复！"
echo "=========================================="
