---
name: implement-issue
description: "讀取指定的 GitHub issue 或 Trello 卡片，依序執行建立分支、需求釐清、程式碼探索、提案、實作與驗證。當使用者要求「實作 issue」、「依 issue 修改程式碼」或提供 issue／Trello 連結要求實作時使用。"
argument-hint: <issue URL、issue number 或 Trello 連結>
---

# Implement Issue

根據 GitHub issue 或 Trello 卡片，完整執行從建立分支到功能驗證的實作流程。使用者可直接從 base branch（如 `dev` 或 `version/xxx`）呼叫本 skill，不需自行先開分支。

## 流程總覽

本 skill 依序驅動以下六個 sub-skill，每一步完成後才進入下一步：

| 步驟 | Sub-Skill | 目的 |
|------|-----------|------|
| 1 | `sub-skills/create-branch.md` | 判斷是否在 base branch，需要時命名並建立分支（若在既有分支上延續開發，經確認後可略過） |
| 2 | `sub-skills/read-issue.md` | 擷取 issue 原始內容 |
| 3 | `sub-skills/openspec-explore.md` | 釐清需求、探索程式碼（含 Figma） |
| 4 | `sub-skills/openspec-propose.md` | 產出變更提案 |
| 5 | `sub-skills/openspec-apply.md` | 實作並用 Figma 驗證 UI |
| 6 | `sub-skills/verify-browser.md` | 功能驗證、建議 E2E 測試、輸出總結 |

## 執行指引

### 開始前
讀取 `sub-skills/create-branch.md`，依其指示執行步驟 1（判斷編號、命名分支、經使用者確認後建立並切換分支）。

### 每步銜接原則
- 完成當前 sub-skill 後，**主動讀取下一個 sub-skill 檔案**再繼續
- 若任何步驟遇到阻礙（找不到編號、issue 不存在、Figma MCP 失敗、需求衝突、未提交變更未處理），立即停止並詢問使用者，不得自行推測繼續
- 是否建立新分支、分支命名與建立務必經使用者明確確認後才執行，不得自行決定後直接建立或略過
- 不要在使用者未要求的情況下 commit 或建立 PR

### 終止條件
步驟 6（verify-browser）完成後，本 skill 結束。
