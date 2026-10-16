# Sub-Skill: Read Issue

> 由 `implement-issue` 主 skill 在步驟 2 載入（前一步為 `create-branch.md`，已完成分支建立與切換）。完成後回到主 skill，繼續載入 `openspec-explore.md`。

## 目的
解析參數、擷取 GitHub issue 原始內容，交給下一步驟（`openspec-explore`）分析。本步驟不做需求彙整或歧義判斷。

---

## 1. 解析參數

參數格式可能為：
- Issue number：`1234` 或 `#1234`
- Issue URL：`https://github.com/<owner>/<repo>/issues/1234`

從參數取出 issue number。若為 URL，同時取出 `<owner>/<repo>` 作為 `--repo` 參數；若只有 number，使用目前 repo。

若未提供參數，詢問使用者要實作哪個 issue，等待回應後再繼續。

---

## 2. 擷取 Issue 內容

使用 `--jq` 過濾，只輸出標題、描述與含 `#SPEC` 的 comment：

```bash
gh issue view <number> --json title,body,comments \
  --jq '{title, body, specs: [.comments[] | select(.body | contains("#SPEC")) | {createdAt, body}]}'
```

若為其他 repo，加上 `--repo <owner>/<repo>`。

若指令失敗（如未登入），提示使用者執行 `gh auth login` 後停止，等待使用者解決。

---

## 完成條件
Issue 原始內容（title、body、specs）已取得。

接著載入 `sub-skills/openspec-explore.md`，將這些原始內容交給該步驟繼續分析。
