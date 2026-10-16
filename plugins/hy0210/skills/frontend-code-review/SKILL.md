---
name: frontend-code-review
description: 在使用者要求 code review、review 變更、review PR 或呼叫 /code-review 時使用。此 skill 為 Claude Code 原生 /code-review 疊加三項團隊約束：僅看 /frontend 資料夾、base branch 限定 version/ 或 dev 開頭、以繁體中文回覆。只要涉及程式碼變更 review 就應套用，不需使用者明確提及「前端」。
---

# Frontend Code Review

在 Claude Code 原生 `/code-review` 之上疊加以下三項約束，分析邏輯不變。

## 1. 只看前端程式碼

- 只 review 路徑落在 `/frontend` 下的檔案，其餘一律略過，不予評論。
- 沒有 `/frontend` 檔案變更 → 告知使用者本次無前端程式碼可 review。
- 找不到 `/frontend` 資料夾或專案結構不符預期 → 詢問使用者，不要猜測。

## 2. Base Branch

- 預設限定 `version/` 或 `dev` 開頭的 branch。
- 只有一個符合 → 直接採用，並註明所選 branch。
- 多個 `version/*` → 依 semver 規則選版號最新者（逐段比較數字，如 `3.10.0` > `3.4.0`），自動採用並註明是「版號最新」自動選擇；版號格式不規則無法比較時才改為詢問。
- 多個 `dev*`，或 `version/*` 與 `dev*` 同時存在 → 詢問使用者，不自行判斷優先順序。
- 完全找不到符合條件的 branch → 詢問使用者。
- 不使用 `main`/`master` 或其他不符規則的 branch 作為預設值。

## 3. 繁體中文回應

- 整份 review（摘要、評論、建議、提問）一律繁體中文；程式碼、變數、函式、檔名、指令維持原文。
- 原生範本的英文標題（如 Summary、Issues Found）一併轉為中文，排版結構不變。

## 執行流程

1. 取得 diff / 變更檔案清單。
2. 依規則 1 過濾出 `/frontend` 檔案；為空則告知並結束。
3. 依規則 2 確認或詢問 base branch。
4. 用原生 `/code-review` 邏輯 review 過濾後的檔案。
5. 依規則 3 以繁體中文輸出，開頭註明 base branch 與涵蓋範圍。
