#!/bin/bash
# 匈牙利华人生活指南 - PDF生成脚本
# Hungary Chinese Life Guide - PDF Generator

set -e

echo "=========================================="
echo "匈牙利华人生活指南 - PDF生成器"
echo "=========================================="
echo ""

# 检查依赖
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo "❌ 错误: 未找到 $1"
        echo "请安装: $2"
        return 1
    fi
    echo "✅ 已找到 $1"
    return 0
}

echo "检查依赖..."
check_dependency "pandoc" "sudo apt-get install pandoc" || exit 1
check_dependency "wkhtmltopdf" "sudo apt-get install wkhtmltopdf" || exit 1

echo ""
echo "=========================================="
echo "开始生成 PDF..."
echo "=========================================="
echo ""

# 创建输出目录
mkdir -p pdf-output

# 生成合并的 Markdown 文件
echo "📄 步骤1: 合并文档..."

# 创建主文档（去除YAML front matter）
cat > pdf-output/combined.md << 'HEADER'
---
title: "匈牙利华人生活指南"
subtitle: "Hungary Chinese Life Guide"
author: "OpenClaw Community"
date: "2026-03-10"
lang: zh-CN
---

<div style="text-align: center; margin-top: 100px;">

# 🇭🇺 匈牙利华人生活指南

## Hungary Chinese Life Guide

---

**为在匈牙利生活、工作、学习的华人提供全面指南**

*OpenClaw Community*  
*2026年3月*

</div>

<div style="page-break-after: always;"></div>

## 目录

### 职场权益
1. 项目总览
2. 劳动法核心条款
3. 工资与税务
4. 工作时间与休假
5. 离职与赔偿
6. 劳动纠纷处理
7. 华人特殊场景
8. 实用资源

### 生活指南
9. 新移民落地指南
10. 居留与签证
11. 住房与租房
12. 医疗与保险
13. 银行与金融
14. 交通与出行
15. 教育与孩子
16. 日常生活
17. 买房指南

### 附录
18. 真实案例
19. 使用示例

<div style="page-break-after: always;"></div>

HEADER

# 按顺序添加各个文档（去除YAML front matter）
docs=(
    "docs/00-总览.md"
    "docs/01-劳动法核心条款.md"
    "docs/02-工资与税务.md"
    "docs/03-工作时间与休假.md"
    "docs/04-离职与赔偿.md"
    "docs/05-劳动纠纷处理.md"
    "docs/06-华人特殊场景.md"
    "docs/07-实用资源.md"
    "docs/08-新移民落地指南.md"
    "docs/09-居留与签证.md"
    "docs/10-住房与租房.md"
    "docs/11-医疗与保险.md"
    "docs/12-银行与金融.md"
    "docs/13-交通与出行.md"
    "docs/14-教育与孩子.md"
    "docs/15-日常生活.md"
    "docs/16-买房指南.md"
    "docs/98-真实案例.md"
    "docs/99-使用示例.md"
)

for doc in "${docs[@]}"; do
    if [ -f "$doc" ]; then
        echo "   添加: $doc"
        echo "" >> pdf-output/combined.md
        echo "<div style=\"page-break-after: always;\"></div>" >> pdf-output/combined.md
        echo "" >> pdf-output/combined.md
        # 去除YAML front matter
        sed '/^---$/,/^---$/d' "$doc" >> pdf-output/combined.md
    else
        echo "   ⚠️  跳过: $doc (未找到)"
    fi
done

echo ""
echo "📑 步骤2: 转换为 HTML..."
pandoc pdf-output/combined.md \
    -o pdf-output/temp.html \
    --standalone \
    --metadata title="匈牙利华人生活指南" \
    --toc \
    --toc-depth=2

echo ""
echo "📄 步骤3: 转换为 PDF..."
wkhtmltopdf \
    --enable-local-file-access \
    --page-size A4 \
    --margin-top 20mm \
    --margin-bottom 20mm \
    --margin-left 20mm \
    --margin-right 20mm \
    --encoding utf-8 \
    --footer-center "[page]/[topage]" \
    --footer-font-size 9 \
    --footer-spacing 5 \
    pdf-output/temp.html \
    pdf-output/匈牙利华人生活指南.pdf

echo ""
echo "📦 步骤4: 清理临时文件..."
rm pdf-output/combined.md
rm pdf-output/temp.html

echo ""
echo "=========================================="
echo "✅ PDF生成成功！"
echo "=========================================="
echo ""
echo "输出文件: pdf-output/匈牙利华人生活指南.pdf"
echo ""
if [ -f "pdf-output/匈牙利华人生活指南.pdf" ]; then
    echo "文件大小: $(du -h pdf-output/匈牙利华人生活指南.pdf | cut -f1)"
fi
echo ""

# 生成速查手册
echo "📄 生成速查手册 PDF..."

cat > pdf-output/quick-guide.md << 'EOF'
---
title: "匈牙利华人生活速查手册"
date: "2026-03-10"
---

# 🇭🇺 匈牙利华人生活速查手册

## 紧急联系方式

| 情况 | 电话 | 备注 |
|-----|------|------|
| 报警/急救/消防 | **112** | 欧盟通用 |
| 领事保护 | +36 1 413 2400 | 中国驻匈使馆 |
| 劳动监察 | +36 1 475 5200 | OMMF |
| 法律援助 | +36 1 321 0404 | 免费 |

## 新移民落地清单

### 第一周（紧急）
- [ ] 办理地址卡
- [ ] 申请税号
- [ ] 开设银行账户
- [ ] 办理手机卡

### 第一个月（重要）
- [ ] 申请TAJ医保号
- [ ] 寻找长期住房
- [ ] 注册家庭医生

## 租房要点

| 项目 | 参考价格 | 注意事项 |
|-----|---------|---------|
| 单间公寓 | 400-900€ | 市中心贵 |
| 一室一厅 | 500-1200€ | 看区域 |
| 押金 | 1-2个月 | 法律规定不超过3个月 |
| 中介费 | 1个月租金 | 可协商 |

## 医疗费用

| 服务 | TAJ医保 | 自费 |
|-----|---------|------|
| 家庭医生 | 免费 | - |
| 急诊 | 免费 | - |
| 专科门诊 | 免费/少量 | - |
| 牙科 | 部分免费 | 美容自费 |
| 处方药 | 部分报销 | 看药物类型 |

## 交通费用

| 票种 | 价格 | 说明 |
|-----|------|------|
| 单程票 | 450福林 | 80分钟内有效 |
| 月票 | 9500福林 | 无限次 |
| 学生月票 | 3450福林 | 全日制学生 |

## 关键税率

- 个人所得税：15%
- 社保缴纳：18.5%
- 购房交易税：4%

## 重要提醒 ⚠️

1. **地址卡是核心** - 几乎所有手续都需要
2. **30天时效** - 劳动争议、投诉等注意时效
3. **保留凭证** - 所有缴费、转账保留记录
4. **语言准备** - 学几句基础匈语很有帮助

---

*完整版请查看《匈牙利华人生活指南》*  
*OpenClaw Community, 2026*
EOF

pandoc pdf-output/quick-guide.md -o pdf-output/temp-quick.html --standalone
wkhtmltopdf \
    --page-size A4 \
    --margin-top 15mm \
    --margin-bottom 15mm \
    --margin-left 15mm \
    --margin-right 15mm \
    pdf-output/temp-quick.html \
    pdf-output/速查手册.pdf

rm pdf-output/quick-guide.md
rm pdf-output/temp-quick.html

echo ""
echo "=========================================="
echo "📦 生成完成！"
echo "=========================================="
echo ""
echo "输出文件："
echo "  1. pdf-output/匈牙利华人生活指南.pdf (完整版)"
echo "  2. pdf-output/速查手册.pdf (精简版)"
echo ""
