# AIM Blog Content Model

Use these conventions when adding or editing site content.

## Team Blog Posts

Posts live in page bundles:

```text
content/posts/<slug>/
├── index.en.md
├── index.zh.md
├── figures/
└── optional-file.pdf
```

Typical front matter:

```yaml
---
title: "Post title"
date: 2026-05-17
authors:
description: "Short summary for cards and metadata."
tags: ["AI4Math", "LLM"]
categories: ["Research Highlights"]
aim_sections: ["team-blog", "papers"]
ShowToc: false
TocOpen: true
cover:
  image: "figures/example.svg"
  alt: "Accessible image description"
  caption: "Optional caption."
  hiddenInSingle: true
---
```

Rules:

- Create both `index.en.md` and `index.zh.md` when adding a bilingual post.
- Use the same slug for both languages.
- `aim_sections` controls section membership. A post can appear in multiple sections. Current common values include `team-blog` and `papers`.
- Use `<!--more-->` to control the homepage excerpt when useful.
- Keep post assets inside the page bundle and reference them with relative paths such as `figures/plot.png`.
- Use `\( ... \)` for inline LaTeX and display math blocks such as `\[ ... \]`.

## News

News files live directly under `content/news/`:

```text
content/news/<slug>.en.md
content/news/<slug>.zh.md
```

Typical front matter:

```yaml
---
title: "2026-05-17: One-sentence news title"
date: 2026-05-17
description: "Optional short description without repeating the date."
news_target: "/posts/example/"
---

Optional body text, often the same one-sentence summary.
```

Rules:

- Keep the date in `title`; the list template does not show an extra system date.
- Keep each news item concise. The full news list is a one-line list of clickable titles.
- Use `news_target` to make the news item jump to a related blog post.
- `news_target` may be language-neutral, for example `/posts/aim/`; templates convert it with `absLangURL`.
- Add both English and Chinese news files for bilingual updates.

## Papers and Preprints

Papers are data entries:

```text
data/papers/en.yaml
data/papers/zh.yaml
```

Entry shape:

```yaml
- title: "Paper title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
    - label: "Blog"
      url: "/en/posts/example/"
  summary: "Brief description."
```

Rules:

- Keep entry order intentional, usually newest or most important first.
- Keep English and Chinese YAML aligned entry-by-entry.
- Use multiple links when useful: arXiv, DOI, PDF, code, project page, blog.
- Internal blog links should point to the matching language, for example `/en/posts/.../` in `en.yaml` and `/zh/posts/.../` in `zh.yaml`.

## AIM Math Results

AIM math results are data entries:

```text
data/aim_results/en.yaml
data/aim_results/zh.yaml
```

Entry shape:

```yaml
- title: "Result title"
  authors:
    - "Author One"
    - "Author Two"
  venue: "Journal / conference / arXiv preprint"
  links:
    - label: "arXiv"
      url: "https://arxiv.org/abs/xxxx.xxxxx"
  summary_expert: "Technical summary for domain experts."
  summary_public: "Plain-language summary for a broad audience."
```

Rules:

- This section includes mathematical work where AIM or related AI systems contributed to the process; it may include work by other teams.
- Avoid wording that implies AIM independently produced the result.
- Keep both expert and public summaries.
- The site displays an AI-generated-summary disclaimer; do not remove it unless asked.
- Add all useful source links, including arXiv, DOI, official project pages, code, and news coverage.

## Section Pages and Navigation

Section landing pages live under:

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

Navigation is in `config.toml` under `languages.en.menu.main` and `languages.zh.menu.main`.

Rules:

- Keep English and Chinese menu items aligned unless the user asks otherwise.
- Use Hugo v0.158+ config names: `locale` and `languages.<lang>.label`.
- Avoid deprecated `.Language.LanguageName`, `.Language.LanguageCode`, and `.Language.LanguageDirection` in templates.

## Validation Commands

Run after content updates:

```bash
hugo --gc --minify
git diff --check
```

Useful targeted checks:

```bash
rg -n "expected text|expected-url" public/en public/zh
rg -n "languageCode|languageName|LanguageName|LanguageCode|LanguageDirection" config.toml layouts
```
