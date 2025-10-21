# Team Blog

- 写作：在 `content/posts/` 下新建 Markdown，如 `2025-xx-new-post.md`
- 预览：本地可装 Hugo 预览；不会本地跑的同学直接提 PR 也行。
- 发布：合并到 `main` 自动上线（GitHub Actions 构建部署）。



## macOS环境配置及编辑
```bash
# 基本环境配置
## 安装hugo
brew install hugo

## 确认hugo版本
hugo version # 需要输出类似v0.151.2+extended字样，版本号不应更低，且包含extended字样

## 检出代码
git clone https://github.com/<your-username>/AIM-blog.git
cd AIM-blog

## 初始化
hugo mod clean
hugo mod get -u
hugo mod vendor

## 启动本地预览，此时可以通过访问http://localhost:1313/来访问网页
hugo server -D --ignoreCache --disableFastRender
```
