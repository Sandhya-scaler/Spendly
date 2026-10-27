#!/bin/bash
# Stop hook: commit and push any changes to origin main when Claude finishes a response.
cd "$CLAUDE_PROJECT_DIR" || exit 0
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0

git add -A
git diff --cached --quiet && exit 0

git commit -q -m "Auto-commit: $(date '+%Y-%m-%d %H:%M')" || exit 0
if git push -q origin main 2>/dev/null; then
  echo '{"systemMessage": "Changes pushed to GitHub"}'
else
  echo '{"systemMessage": "Auto-push failed — changes are committed locally"}'
fi
