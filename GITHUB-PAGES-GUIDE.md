# GitHub Pages 部署指南

## 快速部署步骤

### 1. 创建 GitHub 仓库

1. 登录 GitHub: https://github.com
2. 点击右上角 "+" → "New repository"
3. 仓库名称: `hungary-chinese-guide`
4. 选择 "Public"（公开）
5. 点击 "Create repository"

### 2. 初始化本地仓库并推送

```bash
# 进入项目目录
cd /root/.openclaw/workspace/projects/hungary-chinese-guide

# 初始化 git 仓库
git init

# 添加所有文件
git add .

# 提交
git commit -m "Initial commit: Hungary Chinese Life Guide"

# 添加远程仓库（替换 YOUR_USERNAME 为你的 GitHub 用户名）
git remote add origin https://github.com/YOUR_USERNAME/hungary-chinese-guide.git

# 推送
git push -u origin main
```

### 3. 启用 GitHub Pages

1. 进入仓库页面
2. 点击 "Settings" 标签
3. 左侧菜单选择 "Pages"
4. "Source" 选择 "Deploy from a branch"
5. "Branch" 选择 "main" / "/ (root)"
6. 点击 "Save"

### 4. 访问网站

等待 2-5 分钟后，访问：
```
https://YOUR_USERNAME.github.io/hungary-chinese-guide/
```

## 项目结构说明

```
hungary-chinese-guide/
├── index.html          # 网站首页
├── _config.yml         # Jekyll 配置
├── docs/               # 文档目录
│   ├── 00-总览.md
│   ├── 01-劳动法核心条款.md
│   └── ... (共19篇)
├── pdf-output/         # PDF 输出
│   ├── 匈牙利华人生活指南.pdf
│   └── 速查手册.pdf
├── templates/          # 模板文件
├── tools/              # 工具脚本
└── README.md           # 项目说明
```

## 更新网站

每次修改后，推送更新：

```bash
git add .
git commit -m "更新内容"
git push
```

GitHub Pages 会自动重新部署。

## 自定义域名（可选）

1. 在 `Settings` → `Pages` 中添加自定义域名
2. 在域名 DNS 中添加 CNAME 记录指向 `YOUR_USERNAME.github.io`
3. 在仓库根目录创建 `CNAME` 文件，内容为你的域名

## 注意事项

- 仓库必须是 Public 才能使用免费 GitHub Pages
- 首次部署可能需要 5-10 分钟
- 如果页面显示 404，检查 `_config.yml` 中的 `baseurl` 设置

## 相关项目

- 导航中心: https://david78huang.github.io/hungary-guide-hub/
- 职场权益版: https://david78huang.github.io/hu-hr-rights/
