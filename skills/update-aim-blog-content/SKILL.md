---
name: update-aim-blog-content
description: Use this skill when adding, editing, translating, or reviewing content for the AIM Blog Hugo site, including blog posts, news items, publications, Discoveries, navigation labels, bilingual content, images, and local build validation.
metadata:
  short-description: Update AIM Blog content
---

# Update AIM Blog Content

This skill guides updates to the AIM Blog Hugo site. Use it for content changes in:

- Blog posts: `content/posts/`
- News: `content/news/`
- Publications: `data/publications/`
- Discoveries: `data/discoveries/`
- Section pages and navigation: `content/*/_index.*.md`, `config.toml`
- Post assets: page-bundle files such as `content/posts/<slug>/figures/`

## Workflow

1. Inspect the current structure before editing:
   - `README.md`
   - `config.toml`
   - relevant files under `content/`, `data/`, `layouts/`, and `assets/css/extended/`
2. Read `references/content-model.md` when touching any section content.
3. Make bilingual updates when the site already has both `.en.md` and `.zh.md` or both `en.yaml` and `zh.yaml`.
4. Keep URLs stable. Prefer editing existing slugs over renaming directories unless the user explicitly asks.
5. For Markdown posts, keep assets in the same page bundle, usually `content/posts/<slug>/figures/`.
6. For generated summaries, keep the visible AI summary disclaimer when the existing layout expects it.
7. Validate with:
   - `hugo --gc --minify`
   - `git diff --check`
   - targeted `rg` checks on generated `public/` HTML when verifying links or text
8. Summarize changed files and validation results. Do not commit unless the user asks.

## Section Rules

For detailed front matter and YAML shapes, read:

- `references/content-model.md`

Use that reference instead of inventing new fields when adding content.

## Practical Checks

- News titles should contain the date as part of the title text. Do not also display a separate system date in the news list unless requested.
- News items may link to a related blog post through `news_target`.
- A blog post can belong to multiple sections through `aim_sections`.
- Publications and Discoveries are list-style data entries, not Markdown posts.
- Internal links in YAML should usually be language-specific paths, for example `/en/posts/aim/` and `/zh/posts/aim/`.
- After image edits, validate SVGs with `xmllint --noout` when available.
