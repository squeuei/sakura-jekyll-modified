#!/bin/bash
set -e

# バックアップブランチ作成
git branch backup-master master

# 作業用ブランチ作成・切り替え
git checkout -b reorganized

# fork元の最後のコミット(78158f5)にリセット
git reset --hard 78158f5

# 最終状態のファイルを取得してunstage
git checkout backup-master -- .
git reset HEAD

# 1. CSS/テーマ
git add assets/css/custom.css assets/css/custom-dark.css
git commit -m "feat(css): Add custom CSS with dark mode support"

# 2. レイアウト
git add _layouts/default.html _layouts/post.html _layouts/archive.html
git commit -m "feat(layout): Improve template layouts and base URL handling"

# 3. アーカイブ機能
git add category/index.html tag/index.html blog/index.html
git commit -m "feat(archive): Add category/tag lists with monthly archive"

# 4. アクセシビリティ
git add _includes/svg-icons.html
git commit -m "feat(a11y): Improve SVG icon accessibility with aria-labels"

# 5. GitHub Actions
git add .github/workflows/jekyll.yml
git commit -m "ci: Add GitHub Actions workflow for GitHub Pages"

# 6. 設定
git add _config.yml Gemfile .gitignore
git commit -m "chore(config): Update site config, add jekyll-seo-tag and lang support"

# 7. ドキュメント
git add README.md
git commit -m "docs: Update README"

# 8. コンテンツ
git add _posts/1970-01-01-test.md _posts/1970-01-02-test2.md index.html about/index.md portfolio/index.md
git commit -m "content: Update pages and add test posts"

# 結果確認
echo "=== Done ==="
git log --oneline 78158f5..HEAD
