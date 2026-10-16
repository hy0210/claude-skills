# Sub-Skill: OpenSpec Apply

> 由 `implement-issue` 主 skill 在步驟 5 載入。完成後回到主 skill，繼續載入 `verify-browser.md`。

## 關於 /opsx:apply

`/opsx:apply` 是 OpenSpec 的斜線指令，在 Claude Code 的聊天框中輸入。它讀取 `openspec/changes/<change-name>/tasks.md`，逐項實作並打勾，直到所有任務完成。

⚠️ 不要用 bash 執行 `openspec apply`。`/opsx:apply` 是在 Claude Code 聊天中輸入的斜線指令。

---

## Figma MCP 規則（必讀，本 sub-skill 全程適用）

若實作涉及 UI 或樣式，先載入 `figma-link-guard` skill 並依其規則處理連結開啟與例外狀況。

本步驟是**精確樣式驗證**（顏色、字型、間距、尺寸等），遇到 `figma-link-guard` 規則 2（資料過大）時，走「需要嚴格樣式」路徑（不可改用截圖，停下詢問使用者）。驗證本身必須比對 Figma **節點樣式數值**，不可用截圖替代。

---

## 1. 啟動 /opsx:apply

在 Claude Code 聊天中輸入 `/opsx:apply`，OpenSpec 將逐步執行 `tasks.md` 中的任務。

實作過程遵守：
- 只實作 `tasks.md` 範圍內的任務，不做額外重構
- 遵循 `/opsx:explore` 階段確認的程式碼風格與架構
- 遇到 tasks 範圍外的問題（技術債、潛在 bug），記錄但不主動修改

---

## 2. UI 任務完成後：Figma 樣式比對

每個涉及 UI 的任務完成後（不是等全部完成），立即用 Figma MCP 驗證：

1. 開啟對應的 Figma 節點
2. 逐一比對：
   - 顏色（fill、stroke、text color）
   - 字型（family、size、weight、line-height、letter-spacing）
   - 間距（padding、margin、gap）
   - 尺寸（width、height、border-radius）
3. 若實作與 Figma 不符，修正後再次比對
4. **不可用截圖比對**，必須用 Figma MCP 取得節點數值直接對照

---

## 3. 執行測試與 Lint

所有 tasks 完成後：

```bash
# 執行專案既有的測試指令（參考 package.json scripts）
# 執行 lint
```

若測試或 lint 失敗，修正後繼續，不得跳過。

---

## 完成條件
- `/opsx:apply` 執行完成，`tasks.md` 所有任務已打勾
- 所有 UI 修改已透過 Figma MCP 節點比對驗證
- 測試與 lint 通過

接著載入 `sub-skills/verify-browser.md` 繼續。
