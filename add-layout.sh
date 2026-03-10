#!/bin/bash
# 为所有 Markdown 文件添加 front matter

cd /root/.openclaw/workspace/projects/hu-hr-rights/docs

# 处理每个 md 文件
for file in *.md; do
    # 获取文件名（不含扩展名）
    filename=$(basename "$file" .md)
    
    # 提取标题（从第一行获取）
    title=$(head -1 "$file" | sed 's/^# //' | sed 's/\r$//')
    
    # 创建临时文件
    temp_file="temp_${file}"
    
    # 写入 front matter 和原内容
    cat > "$temp_file" << EOF
---
layout: default
title: ${title}
---

$(cat "$file")
EOF
    
    # 替换原文件
    mv "$temp_file" "$file"
    
    echo "✅ 已处理: $file"
done

echo ""
echo "=========================================="
echo "所有文档已添加样式布局！"
echo "=========================================="
