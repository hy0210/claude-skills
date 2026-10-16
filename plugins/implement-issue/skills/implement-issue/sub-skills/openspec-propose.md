# Sub-Skill: OpenSpec Propose

> 由 `implement-issue` 主 skill 在步驟 4 載入。完成後回到主 skill，繼續載入 `openspec-apply.md`。

## 關於 /opsx:propose

`/opsx:propose` 是 OpenSpec 的斜線指令，在 Claude Code 的聊天框中輸入。執行後 OpenSpec 會在專案中建立 `openspec/changes/<change-name>/` 資料夾，包含：
- `proposal.md`：為何做、改什麼
- `specs/`：需求與場景
- `design.md`：技術方案
- `tasks.md`：實作清單

⚠️ 不要用 bash 執行 `openspec propose`。`/opsx:propose` 是在 Claude Code 聊天中輸入的斜線指令。

---

## 1. 決定 change name

從 issue 衍生一個簡短的英文 kebab-case 名稱，格式：`issue-<number>-<brief-description>`

範例：
- issue #42 "新增深色模式" → `issue-42-dark-mode`
- issue #117 "修正重複訂單問題" → `issue-117-fix-duplicate-orders`

---

## 2. 啟動 /opsx:propose

在 Claude Code 聊天中輸入：

```
/opsx:propose <change-name>
```

把以下資訊帶入 propose 對話：
- `read-issue` 整理出的需求重點
- `/opsx:explore` 探索出的技術方案與取捨分析
- Figma 設計摘要（如有）
- 確認的修改範圍與檔案清單

讓 OpenSpec 引導產出各個 artifact。

---

## 3. 審閱提案內容

`/opsx:propose` 完成後，OpenSpec 會在 `openspec/changes/<change-name>/` 建立 artifact。向使用者說明：
- `tasks.md` 中的實作任務清單
- 若有任何設計決策或取捨，說明選擇原因

**等待使用者確認後**再繼續。若使用者有調整意見：
- 直接修改對應 artifact（`proposal.md`、`specs/`、`design.md`、`tasks.md`）
- 或重新執行 `/opsx:propose` 產出新版本
- 不得跳過確認直接實作

---

## 完成條件
- `openspec/changes/<change-name>/` 資料夾已建立
- tasks.md 中的實作清單已向使用者說明
- 使用者已確認提案內容

接著載入 `sub-skills/openspec-apply.md` 繼續。
