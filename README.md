# AIM Blog Content Guide

This repository contains the Hugo source for the AIM Blog. The recommended workflow is to use Codex for routine content updates, because the site has several bilingual, data-driven sections whose formats need to stay aligned.

中文说明见下方：[中文指南](#中文指南)。

## Recommended Workflow: Use Codex

This repository includes a project skill for site updates:

```text
skills/update-aim-blog-content/
```

When asking Codex to add or revise content, start with:

```text
Use $update-aim-blog-content to ...
```

The skill tells Codex how this repository is structured, how each section stores content, and what validation commands to run before handing changes back.

## What to Prepare Before Asking Codex

Prepare the content facts first. The more precise the input, the less cleanup is needed.

- Target section: team blog, news, papers and preprints, AIM math results, navigation, or section page text.
- Language scope: English only, Chinese only, or bilingual.
- For a team blog post: title, date, slug, authors if any, short description, target sections for `aim_sections`, draft/body text, images or PDFs, and related paper/code links.
- For news: date, one-sentence title, target language, and the related blog URL if the news should jump to a blog post.
- For papers and preprints: title, authors, venue, publication/preprint status, links such as arXiv/DOI/PDF/code/blog, and a short summary.
- For AIM math results: title, authors, venue or platform, source links, whether our team participated, how AIM or related AI systems contributed, and both expert-facing and public-facing summary requirements.
- Wording constraints: terms to avoid, preferred Chinese/English names, fixed translations, and whether AI-generated summaries need special disclaimers.

## Complete Example: Add a New Paper, Blog, and News Item

This example shows the intended end-to-end workflow: prepare content, ask Codex to update the site, review locally, open a PR, and merge.

### 1. Prepare the Content Package

Create a short brief for Codex. For example:

```text
Target: add a bilingual team blog post, add the paper to Papers & Preprints, and add one news item.

Paper:
- Title: Pessimistic Verification for Open Ended Math Questions
- Date: 2026-05-17
- Authors: Yanxing Huang, Zihan Tang, Zejin Lin, Peng Li, Yang Liu
- Venue: ICML 2026 / arXiv preprint
- arXiv: https://arxiv.org/abs/2511.21522
- Code: https://github.com/THUNLP-MT/pverify

Blog:
- Slug: pessimistic-verification
- English title: Pessimistic Verification: Helping LLMs Check Mathematical Proofs
- Chinese title: 悲观验证：让大模型更会检查数学证明
- Sections: team-blog, papers
- Use the attached English and Chinese drafts.
- Use figures/pessimistic_verifiers.svg as the cover.

News:
- English title: 2026-05-17: Pessimistic Verification introduced for mathematical proof checking
- Chinese title: 2026-05-17：团队提出悲观验证方法，提升大模型数学证明检查能力
- News should link to the blog post, not to a standalone news page.

Constraints:
- Keep dates only in news titles, not as extra displayed dates in the news list.
- Keep bilingual pages aligned.
- Run Hugo build validation before finishing.
```

Put any draft Markdown, figures, PDFs, or screenshots in the repository or attach them in the Codex session before asking for the update.

### 2. Ask Codex to Make the Change

Use a prompt like:

```text
Use $update-aim-blog-content to add the prepared bilingual blog post, paper-list entry, and news item. Please update all affected English and Chinese files, keep the existing section conventions, run validation, and summarize the changed files.
```

Codex should inspect the repository, update the relevant files, and run:

```bash
hugo --gc --minify
git diff --check
```

For link or text changes, ask Codex to inspect generated HTML with targeted `rg` checks.

### 3. Review Locally

Start a local preview:

```bash
hugo server -D --ignoreCache --disableFastRender
```

Open:

```text
http://localhost:1313/
```

Check the affected pages, usually:

- `/en/` and `/zh/`
- `/en/team-blog/` and `/zh/team-blog/`
- `/en/papers/` and `/zh/papers/`
- `/en/news/` and `/zh/news/`
- the new post pages under `/en/posts/<slug>/` and `/zh/posts/<slug>/`

If something looks wrong, ask Codex for a targeted fix instead of editing unrelated files manually.

### 4. Commit and Push

Review the diff:

```bash
git status
git diff
```

Commit:

```bash
git add README.md content data layouts assets static skills
git commit -m "Add pessimistic verification content"
git push origin <your-branch>
```

Only add the files that actually changed. The command above lists common directories; narrow it if the change is smaller.

### 5. Open a Pull Request

Open a PR against `main`. In the PR description, include:

- What content was added or changed.
- Which pages were checked locally.
- The validation result, for example `hugo --gc --minify` passed.
- Any known follow-up items.

### 6. Merge and Confirm Publication

After review, merge the PR into `main`. GitHub Actions will build and publish the site automatically.

After the deployment finishes, open the production pages and confirm:

- The new content appears in the expected language versions.
- Links point to the intended pages.
- Images and math render correctly.
- News, papers, and AIM math results appear in the correct sections.

## Local Setup for Previewing Codex Changes

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
skills/                 Project Codex skills
```

## Manual Content Updates

Use this section when you need to update content without Codex, or when reviewing Codex's output.

### Team Blog Posts

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

### News

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

### Papers and Preprints

The Papers & Preprints section is data-driven:

```text
data/papers/en.yaml
data/papers/zh.yaml
```

Add one entry to each file:

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

### AIM Math Results

The AIM Math Results section is data-driven:

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

### Section Pages and Navigation

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

### Manual Validation

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

---

# 中文指南

本仓库是 AIM Blog 的 Hugo 源码。推荐使用 Codex 完成日常内容更新，因为本站包含多个双语栏目和 YAML 数据列表，手工维护时容易遗漏中英文同步、链接和构建验证。

## 推荐流程：使用 Codex

本仓库内置了一个用于更新网站内容的项目 skill：

```text
skills/update-aim-blog-content/
```

让 Codex 修改内容时，建议在需求前加上：

```text
Use $update-aim-blog-content to ...
```

这个 skill 记录了当前网站的结构、各栏目的内容格式，以及修改完成后应该运行的验证命令。

## 使用 Codex 前需要准备什么

先把内容事实整理清楚。输入越明确，后续返工越少。

- 目标栏目：博文、动态、论文、发现、导航栏，或栏目页文案。
- 语言范围：只更新英文、只更新中文，还是中英文双语都更新。
- 博文：标题、日期、slug、作者信息、简短摘要、应归属的 `aim_sections` 栏目、正文草稿、图片或 PDF、相关论文或代码链接。
- 动态：日期、一句话标题、目标语言，以及如果需要跳转到博文时对应的博文链接。
- 论文：标题、作者、发表会议/期刊/预印平台、发表或预印状态、arXiv/DOI/PDF/代码/博文等链接，以及简短摘要。
- 发现：标题、作者、发表会议/期刊/预印平台、来源链接、我们团队是否参与、AIM 或相关 AI 系统在其中起到的作用，以及面向领域专家和面向大众的摘要要求。
- 措辞约束：需要避免的说法、固定中英文译名、是否需要 AI 生成摘要免责声明等。

## 完整示例：新增论文、博文和动态

这个示例展示完整流程：准备内容、让 Codex 修改、在本地检查、提交 PR、合并上线。

### 1. 准备内容包

先准备一段清晰的说明。例如：

```text
目标：新增一篇中英文博文，把论文加入“论文”，并新增一条动态。

论文：
- 标题：Pessimistic Verification for Open Ended Math Questions
- 日期：2026-05-17
- 作者：Yanxing Huang, Zihan Tang, Zejin Lin, Peng Li, Yang Liu
- 发表信息：ICML 2026 / arXiv preprint
- arXiv：https://arxiv.org/abs/2511.21522
- 代码：https://github.com/THUNLP-MT/pverify

博客：
- Slug：pessimistic-verification
- 英文标题：Pessimistic Verification: Helping LLMs Check Mathematical Proofs
- 中文标题：悲观验证：让大模型更会检查数学证明
- 所属栏目：team-blog, papers
- 使用我提供的中英文草稿。
- 使用 figures/pessimistic_verifiers.svg 作为封面。

动态：
- 英文标题：2026-05-17: Pessimistic Verification introduced for mathematical proof checking
- 中文标题：2026-05-17：团队提出悲观验证方法，提升大模型数学证明检查能力
- 动态点击后跳转到对应博文，不跳转到独立动态页。

约束：
- 动态列表里日期只出现在标题中，不额外显示系统日期。
- 中英文页面保持对齐。
- 修改完成后运行 Hugo 构建验证。
```

如果有 Markdown 草稿、图片、PDF 或截图，把它们放进仓库或在 Codex 会话里提供。

### 2. 让 Codex 修改

可以这样提需求：

```text
Use $update-aim-blog-content to add the prepared bilingual blog post, paper-list entry, and news item. Please update all affected English and Chinese files, keep the existing section conventions, run validation, and summarize the changed files.
```

Codex 应该会读取仓库结构，修改相关文件，并运行：

```bash
hugo --gc --minify
git diff --check
```

如果涉及链接或页面文字，可以要求 Codex 用 `rg` 检查生成后的 `public/` HTML。

### 3. 本地预览和检查

启动本地预览：

```bash
hugo server -D --ignoreCache --disableFastRender
```

浏览器打开：

```text
http://localhost:1313/
```

通常需要检查：

- `/en/` 和 `/zh/`
- `/en/team-blog/` 和 `/zh/team-blog/`
- `/en/papers/` 和 `/zh/papers/`
- `/en/news/` 和 `/zh/news/`
- 新博客 `/en/posts/<slug>/` 和 `/zh/posts/<slug>/`

如果发现问题，优先让 Codex 做针对性修复，避免手工顺带改动无关文件。

### 4. 提交并推送

检查改动：

```bash
git status
git diff
```

提交：

```bash
git add README.md content data layouts assets static skills
git commit -m "Add pessimistic verification content"
git push origin <your-branch>
```

只添加实际改动过的文件。上面的 `git add` 覆盖常见目录；如果改动较小，可以缩小范围。

### 5. 提 Pull Request

向 `main` 分支提交 PR。PR 描述建议包含：

- 新增或修改了哪些内容。
- 本地检查了哪些页面。
- 验证结果，例如 `hugo --gc --minify` 已通过。
- 已知后续事项。

### 6. 合并并确认上线

review 通过后合并到 `main`。GitHub Actions 会自动构建并发布网站。

部署完成后，打开线上页面确认：

- 新内容出现在预期的中英文页面。
- 链接指向正确页面。
- 图片和公式正常显示。
- 动态、论文、发现出现在正确栏目。

## 本地预览环境

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

本地构建：

```bash
hugo --gc --minify
```

## 仓库结构

```text
content/posts/          博文文章 bundle
content/news/           一句话动态
content/team-blog/      博文栏目页
content/papers/         论文栏目页
content/aim-results/    发现栏目页
data/papers/            论文列表数据
data/aim_results/       发现列表数据
layouts/                Hugo 模板和本地 PaperMod 覆盖
assets/css/extended/    自定义样式
static/                 静态资源
skills/                 项目 Codex skills
```

## 手工更新内容

如果无法使用 Codex，或需要 review Codex 的输出，可以参考本节。

### 博文

博文使用 page bundle，放在 `content/posts/` 下：

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

### 动态

动态文件放在 `content/news/`：

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

- 动态展示为一句可点击的标题。
- 日期写在 `title` 里；动态列表不会额外显示系统日期。
- 如果动态应跳转到相关博文，填写 `news_target`。
- 不填 `news_target` 时，动态会链接到自身页面。
- 双语更新时同时添加 `.en.md` 和 `.zh.md`。

### 论文

“论文”栏目由 YAML 数据驱动：

```text
data/papers/en.yaml
data/papers/zh.yaml
```

新增论文时，在两个文件中各加一条：

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
- 可提供多个链接：arXiv、DOI、PDF、代码、项目主页、博文、报道等。
- 内部博客链接应使用对应语言：英文数据里用 `/en/posts/.../`，中文数据里用 `/zh/posts/.../`。
- 条目顺序应有明确规则，通常按时间或重要性排序。

### 发现

“发现”栏目也由 YAML 数据驱动：

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
- 尽量补全来源链接，例如 arXiv、DOI、官网、代码、报道等。

### 栏目页和导航栏

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

### 手工验证

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
