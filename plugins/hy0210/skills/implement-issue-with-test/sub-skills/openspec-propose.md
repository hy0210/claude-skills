# Sub-Skill: OpenSpec Propose

> 由 `implement-issue-with-test` 主 skill 在步驟 4 載入。完成後回到主 skill，繼續載入 `openspec-tests.md`。

## 關於 /opsx:propose

`/opsx:propose` 是 OpenSpec 的斜線指令，在 Claude Code 的聊天框中輸入。執行後 OpenSpec 會在專案中建立 `openspec/changes/<change-name>/` 資料夾，包含：
- `proposal.md`：為何做、改什麼
- `specs/`：需求與場景
- `design.md`：技術方案
- `tasks.md`：實作清單

⚠️ 不要用 bash 執行 `openspec propose`。`/opsx:propose` 是在 Claude Code 聊天中輸入的斜線指令。

## 這一步是「人類主導、AI 輔助」

Spec 的內容（功能範圍、場景、不在範圍的項目）由**使用者**拍板決定，AI 的角色是輔助草擬文字、檢查場景是否完整與一致，並主動指出遺漏或矛盾之處——不是自行決定 Spec 內容後請使用者蓋章。任何場景或範圍上的取捨，都以使用者的判斷為準。

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
- `/opsx:explore` 步驟 5 產出的 Given-When-Then 場景草稿
- Figma 設計摘要（如有）
- 確認的修改範圍與檔案清單

讓 OpenSpec 引導產出各個 artifact。

---

## 3. Spec 必須包含的結構化內容

`specs/` 中的規格文件（或 `proposal.md`，依專案慣例）必須明確包含以下項目，缺一不可：

### 3.1 功能範圍
- 這次改動要達成的行為，簡潔描述

### 3.2 API 設計 / 介面設計（如涉及）
- 路由、參數、回應格式；或元件 props、事件介面

### 3.3 限制
- 效能、相容性、安全性等既有限制或本次改動需遵守的限制

### 3.4 Given-When-Then 關鍵場景（正式版）
將 `/opsx:explore` 步驟 5 的場景草稿，整理、補齊、寫成正式版本，格式：

```
### 場景：<場景名稱>
Given <前置狀態>
When <觸發行為>
Then <預期結果>
```

- 至少包含一個正常路徑（happy path）與探索階段確認過的關鍵邊界情況
- 每個場景要具體到可以直接轉成一個測試案例，避免模糊描述（例如避免「輸入錯誤時要處理錯誤」這種無法直接寫成斷言的句子）

### 3.5 明確「不在範圍」的項目
列出這次改動**刻意不處理**的項目，避免實作階段範圍蔓延，例如：

```
### 不在範圍
- 不處理 XX 情境（原因：...，待後續 issue 處理）
- 不重構既有的 YY 模組
```

若探索階段有討論到但決定不做的邊界情況，也要記錄在這裡，而不是默默省略。

---

## 4. AI 輔助：檢查場景完整性與一致性

`/opsx:propose` 產出草稿後，在請使用者確認前，主動檢查並提出：

- 場景之間是否有矛盾（例如兩個場景對同一個 Given/When 組合給出不同 Then）
- 是否有明顯遺漏的邊界情況未被涵蓋進場景或「不在範圍」清單
- 場景描述是否夠具體，能直接對應到一個可驗證的測試案例
- API／介面設計是否與場景中的行為一致

把檢查結果整理成清單提給使用者，由使用者決定是否補充或維持原樣，不可自行擅自增刪場景。

---

## 5. 審閱提案內容

`/opsx:propose` 完成後，OpenSpec 會在 `openspec/changes/<change-name>/` 建立 artifact。向使用者說明：
- `tasks.md` 中的實作任務清單
- Given-When-Then 場景清單與「不在範圍」項目
- 若有任何設計決策或取捨，說明選擇原因
- 步驟 4 的場景完整性檢查結果

**等待使用者確認後**再繼續。若使用者有調整意見：
- 直接修改對應 artifact（`proposal.md`、`specs/`、`design.md`、`tasks.md`）
- 或重新執行 `/opsx:propose` 產出新版本
- 不得跳過確認直接進入測試產生或實作階段

---

## 完成條件
- `openspec/changes/<change-name>/` 資料夾已建立
- Spec 已包含：功能範圍、API／介面設計、限制、Given-When-Then 場景、明確「不在範圍」項目
- AI 已完成場景完整性與一致性檢查，結果已提交使用者
- tasks.md 中的實作清單已向使用者說明
- 使用者已確認 Spec 與場景內容

接著載入 `sub-skills/openspec-tests.md`，依 Spec 中的場景產生測試程式碼。
