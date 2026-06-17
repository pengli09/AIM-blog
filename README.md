# AIM Blog Content Guide

This repository contains the Hugo source for the AIM Blog. It supports bilingual content, section navigation, team blog posts, news, papers and preprints, and AIM-related mathematical results.

中文说明见下方：[中文指南](#中文指南)。

## Codex Skill

This repository includes a Codex skill for routine site updates:

```text
skills/update-aim-blog-content/
```

When asking Codex to add or revise site content, start with:

```text
Use $update-aim-blog-content to ...
```

Examples:

```text
Use $update-aim-blog-content to add a bilingual team blog post for our new paper.
Use $update-aim-blog-content to add a paper entry and a related news item.
Use $update-aim-blog-content to update an AIM math result with new arXiv and code links.
```

The skill documents the current content model and reminds Codex to update both languages, preserve section conventions, and run Hugo validation.

Before using the skill, prepare the information Codex will need:

- Target section: team blog, news, papers and preprints, AIM math results, navigation, or section page text.
- Language scope: English only, Chinese only, or bilingual.
- For a team blog post: title, date, slug, authors if any, short description, target sections for `aim_sections`, draft/body text, images or PDFs, and any related paper/code links.
- For news: date, one-sentence title, target language, and the related blog URL if the news should jump to a blog post.
- For papers and preprints: title, authors, venue, publication/preprint status, source links such as arXiv/DOI/PDF/code/blog, and a short summary.
- For AIM math results: title, authors, venue or platform, source links, whether our team participated, how AIM or related AI systems contributed, and both expert-facing and public-facing summary requirements.
- Any wording constraints, for example terms to avoid, preferred Chinese/English names, or whether AI-generated summaries need special disclaimers.

## Quick Start

Install Hugo Extended:

```bash
brew install hugo
hugo version
```

Clone and initialize the site:

```bash
git clone https://github.com/<your-username>/AIM-blog.git
cd AIM-blog
hugo mod clean
hugo mod get -u
hugo mod vendor
```

Run a local preview:

```bash
hugo server -D --ignoreCache --disableFastRender
```

Open:

```text
http://localhost:1313/
```

Build the production site locally:

```bash
hugo --gc --minify
```

## Repository Layout

```text
content/posts/          Team blog post bundles
content/news/           One-line news items
content/team-blog/      Team blog section pages
content/papers/         Papers section pages
content/aim-results/    AIM math results section pages
data/papers/            Paper list data
data/aim_results/       AIM math result list data
layouts/                Hugo templates and local PaperMod overrides
assets/css/extended/    Custom styles
static/                 Static site assets
```

## Adding or Editing Team Blog Posts

Team blog posts live in page bundles under `content/posts/`:

```text
content/posts/<slug>/
├── index.en.md
├── index.zh.md
├── figures/
└── optional-file.pdf
```

Create both English and Chinese files when possible. Keep the same slug for both languages.

Example front matter:

```yaml
---
title: "Pessimistic Verification: Helping LLMs Check Mathematical Proofs"
date: 2026-05-17
authors:
description: "We present Pessimistic Verification, a simple and efficient way to improve LLM-based verification for open-ended mathematical proofs."
tags: ["AI4Math", "LLM", "Math Verification"]
categories: ["Research Highlights"]
aim_sections: ["team-blog", "papers"]
ShowToc: false
TocOpen: true
cover:
  image: "figures/pessimistic_verifiers.svg"
  alt: "Overview of Pessimistic Verification"
  caption: "Optional caption."
  hiddenInSingle: true
---
```

Important fields:

- `title`: page title.
- `date`: publication date in `YYYY-MM-DD`.
- `description`: short card and metadata summary.
- `tags`: topic tags.
- `categories`: broad category labels.
- `aim_sections`: controls section membership. A post can belong to multiple sections, for example `["team-blog", "papers"]`.
- `cover.image`: image path relative to the post bundle.
- `hiddenInSingle: true`: hides the cover inside the full post while keeping it available for cards.

Writing tips:

- Put images and PDFs inside the same post bundle.
- Reference images as `figures/example.png` or `figures/example.svg`.
- Use `<!--more-->` to control homepage excerpts.
- Use `\( ... \)` for inline LaTeX instead of `$...$`.
- Use display math as `\[ ... \]`.
- If an SVG looks wrong in dark mode, add an explicit white background to the SVG.

## Adding or Editing News

News files live under `content/news/`:

```text
content/news/<slug>.en.md
content/news/<slug>.zh.md
```

Example:

```yaml
---
title: "2026-05-17: Pessimistic Verification introduced for mathematical proof checking"
date: 2026-05-17
description: "The team introduced Pessimistic Verification for open-ended mathematical proof checking."
news_target: "/posts/pessimistic-verification/"
---

The team introduced Pessimistic Verification for open-ended mathematical proof checking.
```

Rules:

- The visible news item is one clickable sentence.
- Put the date in `title`; the news list does not display a separate system date.
- Use `news_target` when the news should link to a related blog post.
- If `news_target` is omitted, the news item links to its own news page.
- Add both `.en.md` and `.zh.md` when updating bilingual news.

## Adding or Editing Papers and Preprints

The Papers & Preprints section is data-driven:

```text
data/papers/en.yaml
data/papers/zh.yaml
```

Add one entry to each file.

Example:

```yaml
- title: "Paper title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
    - label: "DOI"
      url: "https://doi.org/..."
    - label: "Blog"
      url: "/en/posts/example/"
  summary: "Brief description of the paper."
```

Rules:

- Keep English and Chinese entries aligned.
- Use multiple links when available: arXiv, DOI, PDF, code, project page, blog, or news.
- Use language-specific internal links: `/en/posts/.../` in `en.yaml`, `/zh/posts/.../` in `zh.yaml`.
- Keep the order intentional, usually newest or most important first.

## Adding or Editing AIM Math Results

The AIM Math Results section is also data-driven:

```text
data/aim_results/en.yaml
data/aim_results/zh.yaml
```

Example:

```yaml
- title: "Result title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Journal / conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
    - label: "Code"
      url: "https://github.com/example/project"
  summary_expert: "Technical summary for domain experts."
  summary_public: "Plain-language summary for a broad audience."
```

Rules:

- This section includes mathematical work where AIM or related AI systems contributed to the research process. It may include work by other teams.
- Avoid wording that implies AIM independently produced the mathematical result.
- Provide both `summary_expert` and `summary_public`.
- Summaries are usually AI-generated; keep the visible AI-generated-summary disclaimer in the layout unless intentionally changed.
- Add all useful source links.

## Editing Section Pages and Navigation

Section landing pages:

```text
content/team-blog/_index.en.md
content/team-blog/_index.zh.md
content/papers/_index.en.md
content/papers/_index.zh.md
content/aim-results/_index.en.md
content/aim-results/_index.zh.md
content/news/_index.en.md
content/news/_index.zh.md
```

Navigation lives in `config.toml` under:

```toml
[languages.en.menu.main]
[languages.zh.menu.main]
```

Use Hugo's current config keys:

- `locale`, not `languageCode`
- `languages.<lang>.label`, not `languages.<lang>.languageName`

## Validation Before PRs

Run:

```bash
hugo --gc --minify
git diff --check
```

Useful checks:

```bash
rg -n "expected title|expected link" public/en public/zh
rg -n "languageCode|languageName|LanguageName|LanguageCode|LanguageDirection" config.toml layouts
```

If you changed SVGs:

```bash
xmllint --noout path/to/file.svg
```

## Publishing

Open a pull request after local validation. Merging to `main` publishes the site through GitHub Actions.

---

# 中文指南

本仓库是 AIM Blog 的 Hugo 源码，支持中英文双语内容、导航栏目、团队博客、新闻、论文与预印本列表，以及 AIM 相关数学成果列表。

## Codex Skill

本仓库内置了一个用于更新网站内容的 Codex skill：

```text
skills/update-aim-blog-content/
```

让 Codex 修改内容时，建议在需求前加上：

```text
Use $update-aim-blog-content to ...
```

示例：

```text
Use $update-aim-blog-content to add a bilingual team blog post for our new paper.
Use $update-aim-blog-content to add a paper entry and a related news item.
Use $update-aim-blog-content to update an AIM math result with new arXiv and code links.
```

这个 skill 记录了当前网站的内容结构，会提醒 Codex 同步更新中英文、遵守各栏目格式，并在修改后运行 Hugo 构建验证。

使用 skill 前，建议先准备好 Codex 需要的信息：

- 目标栏目：团队博客、新闻、论文与预印本、AIM 数学成果、导航栏，或栏目页文案。
- 语言范围：只更新英文、只更新中文，还是中英文双语都更新。
- 团队博客：标题、日期、slug、作者信息、简短摘要、应归属的 `aim_sections` 栏目、正文草稿、图片或 PDF、相关论文或代码链接。
- 新闻：日期、一句话标题、目标语言，以及如果需要跳转到博客时对应的博客链接。
- 论文与预印本：标题、作者、发表会议/期刊/预印平台、发表或预印状态、arXiv/DOI/PDF/代码/博客等链接，以及简短摘要。
- AIM 数学成果：标题、作者、发表会议/期刊/预印平台、来源链接、我们团队是否参与、AIM 或相关 AI 系统在其中起到的作用，以及面向领域专家和面向大众的摘要要求。
- 任何措辞约束，例如需要避免的说法、固定中英文译名，或 AI 生成摘要是否需要特殊提示。

## 快速开始

安装 Hugo Extended：

```bash
brew install hugo
hugo version
```

检出并初始化仓库：

```bash
git clone https://github.com/<your-username>/AIM-blog.git
cd AIM-blog
hugo mod clean
hugo mod get -u
hugo mod vendor
```

启动本地预览：

```bash
hugo server -D --ignoreCache --disableFastRender
```

浏览器打开：

```text
http://localhost:1313/
```

本地构建：

```bash
hugo --gc --minify
```

## 仓库结构

```text
content/posts/          团队博客文章 bundle
content/news/           一句话新闻
content/team-blog/      团队博客栏目页
content/papers/         论文与预印本栏目页
content/aim-results/    AIM 数学成果栏目页
data/papers/            论文列表数据
data/aim_results/       AIM 数学成果列表数据
layouts/                Hugo 模板和本地 PaperMod 覆盖
assets/css/extended/    自定义样式
static/                 静态资源
```

## 新增或修改团队博客

团队博客使用 page bundle，放在 `content/posts/` 下：

```text
content/posts/<slug>/
├── index.en.md
├── index.zh.md
├── figures/
└── optional-file.pdf
```

新增内容时尽量同时提供英文和中文文件，并保持同一个 `<slug>`。

Front matter 示例：

```yaml
---
title: "Pessimistic Verification: Helping LLMs Check Mathematical Proofs"
date: 2026-05-17
authors:
description: "We present Pessimistic Verification, a simple and efficient way to improve LLM-based verification for open-ended mathematical proofs."
tags: ["AI4Math", "LLM", "Math Verification"]
categories: ["Research Highlights"]
aim_sections: ["team-blog", "papers"]
ShowToc: false
TocOpen: true
cover:
  image: "figures/pessimistic_verifiers.svg"
  alt: "Overview of Pessimistic Verification"
  caption: "Optional caption."
  hiddenInSingle: true
---
```

常用字段：

- `title`：文章标题。
- `date`：发布日期，格式为 `YYYY-MM-DD`。
- `description`：卡片和页面元信息中的简短摘要。
- `tags`：标签。
- `categories`：大类。
- `aim_sections`：控制文章属于哪些栏目。同一篇文章可以属于多个栏目，例如 `["team-blog", "papers"]`。
- `cover.image`：封面图，相对于当前文章 bundle。
- `hiddenInSingle: true`：封面用于列表卡片，但不在文章页顶部重复显示。

写作建议：

- 图片和 PDF 放在同一个文章目录中。
- 图片引用写成 `figures/example.png` 或 `figures/example.svg`。
- 使用 `<!--more-->` 控制首页摘要截断位置。
- 行内公式建议使用 `\( ... \)`，避免 `$...$` 和普通美元符号混淆。
- 展示公式使用 `\[ ... \]`。
- 如果 SVG 在深色模式下背景透明导致不清楚，请给 SVG 增加明确的白色背景。

## 新增或修改新闻

新闻文件放在 `content/news/`：

```text
content/news/<slug>.en.md
content/news/<slug>.zh.md
```

示例：

```yaml
---
title: "2026-05-17: Pessimistic Verification introduced for mathematical proof checking"
date: 2026-05-17
description: "The team introduced Pessimistic Verification for open-ended mathematical proof checking."
news_target: "/posts/pessimistic-verification/"
---

The team introduced Pessimistic Verification for open-ended mathematical proof checking.
```

规则：

- 新闻展示为一句可点击的标题。
- 日期写在 `title` 里；新闻列表不会额外显示系统日期。
- 如果新闻应跳转到相关博客，填写 `news_target`。
- 不填 `news_target` 时，新闻会链接到自身页面。
- 双语更新时同时添加 `.en.md` 和 `.zh.md`。

## 新增或修改论文与预印本

“论文与预印本”栏目由 YAML 数据驱动：

```text
data/papers/en.yaml
data/papers/zh.yaml
```

新增论文时，在两个文件中各加一条。

示例：

```yaml
- title: "Paper title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
    - label: "DOI"
      url: "https://doi.org/..."
    - label: "Blog"
      url: "/en/posts/example/"
  summary: "Brief description of the paper."
```

规则：

- 英文和中文条目应保持一一对应。
- 可提供多个链接：arXiv、DOI、PDF、代码、项目主页、博客、新闻报道等。
- 内部博客链接应使用对应语言：英文数据里用 `/en/posts/.../`，中文数据里用 `/zh/posts/.../`。
- 条目顺序应有明确规则，通常按时间或重要性排序。

## 新增或修改 AIM 数学成果

“AIM 数学成果”栏目也由 YAML 数据驱动：

```text
data/aim_results/en.yaml
data/aim_results/zh.yaml
```

示例：

```yaml
- title: "Result title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Journal / conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
    - label: "Code"
      url: "https://github.com/example/project"
  summary_expert: "Technical summary for domain experts."
  summary_public: "Plain-language summary for a broad audience."
```

规则：

- 该栏目收录 AIM 或相关 AI 系统参与研究过程的数学工作，也可能包括其他团队完成的成果。
- 表述上应避免暗示 AIM 独立完成或独立产出了数学成果。
- 同时提供 `summary_expert` 和 `summary_public`。
- 这些摘要通常为 AI 生成；除非明确要求修改布局，否则保留页面上的 AI-generated-summary 提示。
- 尽量补全来源链接，例如 arXiv、DOI、官网、代码、新闻报道等。

## 修改栏目页和导航栏

栏目页位置：

```text
content/team-blog/_index.en.md
content/team-blog/_index.zh.md
content/papers/_index.en.md
content/papers/_index.zh.md
content/aim-results/_index.en.md
content/aim-results/_index.zh.md
content/news/_index.en.md
content/news/_index.zh.md
```

导航栏在 `config.toml` 中：

```toml
[languages.en.menu.main]
[languages.zh.menu.main]
```

Hugo 新版本字段：

- 使用 `locale`，不要使用 `languageCode`
- 使用 `languages.<lang>.label`，不要使用 `languages.<lang>.languageName`

## 提交 PR 前验证

运行：

```bash
hugo --gc --minify
git diff --check
```

常用检查：

```bash
rg -n "expected title|expected link" public/en public/zh
rg -n "languageCode|languageName|LanguageName|LanguageCode|LanguageDirection" config.toml layouts
```

如果修改了 SVG：

```bash
xmllint --noout path/to/file.svg
```

## 发布

本地验证通过后提交 PR。合并到 `main` 后，GitHub Actions 会自动构建并发布网站。
