# GitHub Pages 启用步骤

## 步骤 1：进入设置
1. 访问你的仓库：https://github.com/david78huang/hu-hr-rights
2. 点击顶部 **Settings** 标签

## 步骤 2：启用 Pages
1. 左侧菜单点击 **Pages**（在 Code and automation 下）
2. **Source** 部分选择 **Deploy from a branch**
3. **Branch** 选择 **main** → **/(root)**
4. 点击 **Save**

## 步骤 3：等待部署
- 等待 2-5 分钟
- 刷新页面，你会看到：
  ```
  Your site is live at https://david78huang.github.io/hu-hr-rights/
  ```

## 步骤 4：访问网站
点击上面的链接，或者直接在浏览器访问：
```
https://david78huang.github.io/hu-hr-rights/
```

## 可选：选择主题
1. 在 Pages 设置页面
2. 点击 **Change theme**
3. 选择 **Cayman** 或 **Minimal**
4. 点击 **Select theme**

## 完成！🎉

你的网站现在可以在互联网上访问了。每次你 push 更新到 main 分支，网站会自动重新部署。

## 故障排除

如果 10 分钟后还无法访问：
1. 检查仓库是否为 **Public**
2. 确认 _config.yml 文件存在
3. 查看 **Actions** 标签页是否有部署错误
