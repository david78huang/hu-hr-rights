# 安装说明

## 系统要求

- Python 3.7+
- Bash shell
- 可选：Pandoc + wkhtmltopdf（用于生成PDF）

## 快速开始

### 1. 克隆项目

```bash
git clone <repository-url>
cd hu-hr-rights
```

### 2. 使用赔偿金计算器

```bash
# 直接运行
cd tools
python3 severance_calculator.py

# 或者安装为系统命令
chmod +x tools/severance_calculator.py
sudo cp tools/severance_calculator.py /usr/local/bin/hu-severance-calc
```

### 3. 生成PDF（可选）

#### 安装依赖

**Ubuntu/Debian:**
```bash
sudo apt-get update
sudo apt-get install -y pandoc wkhtmltopdf
```

**macOS:**
```bash
brew install pandoc wkhtmltopdf
```

**Windows:**
- 下载安装 [Pandoc](https://pandoc.org/installing.html)
- 下载安装 [wkhtmltopdf](https://wkhtmltopdf.org/downloads.html)

#### 生成PDF

```bash
chmod +x generate-pdf.sh
./generate-pdf.sh
```

输出文件：
- `pdf-output/匈牙利华人职场权益指南.pdf` - 完整版
- `pdf-output/速查手册.pdf` - 精简版

## 项目结构

```
hu-hr-rights/
├── README.md              # 项目主页
├── PROJECT-INTRO.md       # 项目介绍
├── INSTALL.md             # 本文件
├── generate-pdf.sh        # PDF生成脚本
├── docs/                  # 文档目录
│   ├── 00-总览.md
│   ├── 01-劳动法核心条款.md
│   ├── 02-工资与税务.md
│   ├── 03-工作时间与休假.md
│   ├── 04-离职与赔偿.md
│   ├── 05-劳动纠纷处理.md
│   ├── 06-华人特殊场景.md
│   ├── 07-实用资源.md
│   ├── 98-真实案例.md
│   └── 99-使用示例.md
├── templates/             # 模板目录
│   ├── 辞职信模板.md
│   ├── 信息收集表.md
│   └── 快速收集清单.md
├── tools/                 # 工具目录
│   └── severance_calculator.py
└── pdf-output/            # PDF输出目录
```

## 使用方式

### 方式1：直接阅读Markdown文档

使用任何Markdown阅读器或文本编辑器打开 `docs/` 目录下的文件。

### 方式2：生成PDF后阅读

运行 `./generate-pdf.sh` 生成PDF文件，适合打印和离线阅读。

### 方式3：使用赔偿金计算器

```bash
python3 tools/severance_calculator.py
```

按提示输入工作年限和工资，自动计算赔偿金。

## 更新项目

```bash
git pull origin main
```

更新后重新生成PDF：
```bash
./generate-pdf.sh
```

## 故障排除

### PDF生成失败

**问题**: `wkhtmltopdf: cannot connect to X server`

**解决**: 使用无头模式
```bash
# 修改 generate-pdf.sh，添加 --enable-local-file-access 和 xvfb
xvfb-run wkhtmltopdf --enable-local-file-access ...
```

或者安装虚拟显示：
```bash
sudo apt-get install xvfb
```

### 中文显示问题

**问题**: PDF中文字体显示为方块

**解决**: 安装中文字体
```bash
sudo apt-get install fonts-wqy-zenhei fonts-wqy-microhei
```

### 计算器运行错误

**问题**: `ModuleNotFoundError`

**解决**: 本项目仅使用Python标准库，无需安装额外包。请确保使用Python 3.7+：
```bash
python3 --version
```

## 贡献指南

### 补充律师/社群信息

1. 使用 `templates/信息收集表.md` 记录信息
2. 验证信息准确性
3. 更新 `docs/07-实用资源.md`
4. 提交Pull Request

### 报告问题

1. 检查是否已存在相同问题
2. 提供详细的错误信息
3. 说明操作系统和软件版本

## 许可证

本项目采用 [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) 许可证。

您可以自由：
- 分享 — 复制、分发和传播
- 改编 — 修改、转换和基于本作品创作

须遵守：
- 署名 — 必须给出适当的署名
- 相同方式共享 — 改编作品需使用相同许可证

## 联系方式

如有问题或建议，欢迎通过以下方式联系：
- 提交 GitHub Issue
- 发送邮件至项目维护者

---

*最后更新: 2026-03-09*
