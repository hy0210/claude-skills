#!/usr/bin/env bash
input=$(cat)

file=$(echo "$input" | jq -r '.tool_input.file_path // empty')
case "$file" in
  *.ts|*.js|*.vue) ;;
  *) exit 0 ;;
esac

count() { grep -cE '^\s*(//|#|/\*|\*)' || true; }

new_c=$(echo "$input" | jq -r '[.tool_input.content, .tool_input.new_string, (.tool_input.edits[]?.new_string)] | map(select(.)) | join("\n")' | count)

if echo "$input" | jq -e '.tool_input.content != null' >/dev/null; then
  # Write 只傳整份新內容、沒有舊內容，所以改用 git 最後一次 commit 的版本當作比較基準
  rel=$(git ls-files --full-name -- "$file" 2>/dev/null)
  if [ -n "$rel" ]; then
    old_c=$(git show "HEAD:$rel" 2>/dev/null | count)
  else
    old_c=0
  fi
else
  old_c=$(echo "$input" | jq -r '[.tool_input.old_string, (.tool_input.edits[]?.old_string)] | map(select(.)) | join("\n")' | count)
fi

added=$((new_c - old_c))

if [ "$added" -gt 2 ]; then
  echo "$file 這次新增了 $added 行註解。請依 CLAUDE.md 第 9 節檢查，只檢查這次新增的註解，不要更動原本就存在的註解。" >&2
  exit 2
fi
exit 0
