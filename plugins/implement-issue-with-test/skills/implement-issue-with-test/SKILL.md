---
name: implement-issue-with-test
description: 依據 GitHub issue 或 Trello 卡片，以 TDD（測試驅動開發）方式驅動完整實作流程：建立分支、需求探索、撰寫含 Given-When-Then 場景與「不在範圍」項目的 Spec、依 Spec 產生測試、再以紅燈綠燈迴圈先寫測試再寫實作程式碼。當使用者要求「用測試先行的方式實作 issue」「TDD 實作 issue」「依 issue 修改程式碼並補測試」，或提供 issue／Trello 連結要求以測試驅動的方式實作時，使用本 skill。
---

# Implement Issue With Test

根據 GitHub issue 或 Trello 卡片，以 TDD 精神驅動一套完整的實作流程：從建立分支、需求探索、撰寫含測試場景的 Spec、產生測試，到依紅燈綠燈迴圈完成實作。使用者可直接從 base branch（如 `dev` 或 `version/xxx`）呼叫本 skill，不需自行先開分支。

## 使用方式

呼叫本 skill 時，提供以下其中一種作為輸入：
- GitHub issue 連結或 issue number（例如 `https://github.com/<owner>/<repo>/issues/1234` 或 `#1234`）
- Trello 卡片連結或卡片內容
- 兩者皆有時，以 Trello 為主

若使用者呼叫時沒有附上任何連結或編號，於步驟 2（`read-issue.md`）主動詢問，不要自行假設。

## 流程總覽

本 skill 依序驅動以下六個 sub-skill，每一步完成後才進入下一步：

| 步驟 | Sub-Skill | 目的 |
|------|-----------|------|
| 1 | `sub-skills/create-branch.md` | 判斷是否在 base branch，需要時命名並建立分支（若在既有分支上延續開發，經確認後可略過） |
| 2 | `sub-skills/read-issue.md` | 擷取 issue 原始內容 |
| 3 | `sub-skills/openspec-explore.md` | 需求探索：討論業務需求與邊界條件，以 Given-When-Then 思維產出關鍵場景草稿 |
| 4 | `sub-skills/openspec-propose.md` | 撰寫 Spec（人類主導、AI 輔助）：功能範圍、API 設計、限制、Given-When-Then 場景、明確「不在範圍」項目 |
| 5 | `sub-skills/openspec-tests.md` | 產生測試：依 Spec 的場景產生測試程式碼，人類 Review 涵蓋範圍是否正確 |
| 6 | `sub-skills/openspec-apply.md` | TDD 實作：先確認測試失敗（red），再寫最少必要的實作程式碼使測試通過（green），並用 Figma 驗證 UI |

## 核心原則：測試先行

- 測試案例必須在實作程式碼之前產生（步驟 5），且必須源自步驟 4 Spec 中的 Given-When-Then 場景，不可等實作完再補測試。
- 步驟 6 實作時，每個任務都先確認對應測試存在且會失敗（red），才寫實作程式碼；寫完後測試通過（green）才算完成該任務。
- 若在實作過程中發現測試案例本身寫錯或涵蓋不周，停下來詢問使用者，不可為了讓測試通過而自行放寬或修改測試斷言。

## 執行指引

### 開始前
讀取 `sub-skills/create-branch.md`，依其指示執行步驟 1（判斷編號、命名分支、經使用者確認後建立並切換分支）。

### 每步銜接原則
- 完成當前 sub-skill 後，主動讀取下一個 sub-skill 檔案再繼續
- 若任何步驟遇到阻礙（找不到編號、issue 不存在、Figma MCP 失敗、需求衝突、測試涵蓋範圍有疑慮、未提交變更未處理），立即停止並詢問使用者，不得自行推測繼續
- 是否建立新分支、分支命名與建立務必經使用者明確確認後才執行，不得自行決定後直接建立或略過
- Spec 中的場景與測試涵蓋範圍務必經使用者確認後才進入實作階段
- 不要在使用者未要求的情況下 commit 或建立 PR

### 終止條件
步驟 6（`openspec-apply.md`）完成、測試套件與 lint 皆通過後，本 skill 結束。
