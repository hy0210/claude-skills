# Sub-Skill: Create Branch

> 由 `implement-issue` 主 skill 在步驟 1 載入。完成後回到主 skill，繼續載入 `read-issue.md`。

## 目的
在讀取 issue 之前，先判斷目前分支狀態：若使用者是從 base branch（例如 `dev` 或 `version/xxx`）直接呼叫 `implement-issue`，就自動建立對應的功能分支；若使用者本來就是要在既有分支（例如共用的協作分支、延續開發中的分支）上繼續工作，則略過開分支這一步，直接進到 `read-issue.md`。

---

## 0. 判斷目前是否在 base branch

執行：

```bash
git branch --show-current
```

- 判斷目前分支是否為 base branch（例如 `main`、`master`、`dev`、`develop`、`version/xxx` 等專案慣例上的主幹／版本分支，非 `feat/`、`fix/`、`refactor/`、`test/`、`hotfix/`、`chore/` 等功能分支）。若不確定該分支算不算 base branch，直接詢問使用者。

- **若目前就在 base branch**：視為即將開始新工作，繼續執行下方步驟 1～5，準備建立新分支。

- **若目前不在 base branch**（例如已經在某個 `feat/xxx` 分支上）：
  - 向使用者確認：「目前在 `<目前分支名稱>`，是否需要為這次的 issue／Trello 卡片另外開一個新分支？」
  - **等待使用者明確回答**：
    - 回答「不需要」（或等同語意，如「延續這個分支」「共用分支」）→ **略過本 sub-skill 剩餘步驟**，直接載入 `sub-skills/read-issue.md` 繼續原本流程，不建立新分支
    - 回答「需要」（或等同語意）→ 繼續執行下方步驟 1～5，建立新分支
  - 不可自行推測使用者意圖，必須等待明確回覆才能決定要不要建立分支。

---

## 1. 從使用者貼的內容中找編號

使用者呼叫 `implement-issue` 時貼的內容可能是：
- Trello 卡片連結或卡片內容
- GitHub issue 連結或 issue number
- 兩者都有（例如 issue 內文貼了 Trello 連結，或反過來）

判斷順序（**Trello 優先於 issue**）：

1. 先找 **Trello 編號**：
   - Trello 卡片 URL 中的短碼（例如 `https://trello.com/c/AbC123/45-xxx` 中的 `45` 或卡片短 ID）
   - 或使用者訊息中明確提到的 Trello 卡號
2. 若找不到 Trello 編號，找 **GitHub issue 編號**：
   - Issue URL 中的數字，或使用者直接給的 `#1234` / `1234`
3. 若 Trello 編號與 issue 編號都找不到，**停止並詢問使用者**提供編號，不可自行編造或省略編號直接命名分支。

---

## 2. 決定分支前綴

分支前綴需符合專案既有規範，可能包含（但不限於）：

```
feat/
fix/
refactor/
test/
hotfix/
chore/
```

執行：

```bash
git branch -a
```

觀察既有分支慣例，確認本地規範中實際在用的前綴集合。

接著依據 issue／Trello 內容判斷這次改動的性質（新功能 → `feat/`、修 bug → `fix/`、重構 → `refactor/`、補測試 → `test/`、緊急修復 → `hotfix/`、雜項 → `chore/`...）。

若無法明確判斷屬於哪一類，**停止並詢問使用者**要用哪個前綴，不可自行猜測。

---

## 3. 組合分支名稱

格式：

```
<prefix>/<編號>-<最多三個英文單字，kebab-case>
```

- `<編號>`：步驟 1 取得的 Trello 編號或 issue 編號（優先 Trello）
- `<最多三個英文單字>`：依需求內容濃縮出的簡短描述，全小寫、以 `-` 連接，不超過三個單字

範例：

- Trello #1001「深色模式」 → `feat/w1001-dark-mode`
- Issue #42「修正重複訂單問題」 → `fix/42-duplicate-orders`

---

## 4. 詢問使用者確認

在建立分支前，向使用者展示：

```
建議分支名稱：<prefix>/<編號>-<slug>
（依據：Trello #xxx / Issue #xxx）
```

**等待使用者明確確認**（同意，或提出調整後的名稱）。未經確認不得建立分支。

---

## 5. 建立並切換分支

使用者確認後：

1. 檢查目前是否有未提交變更：
   ```bash
   git status
   ```
   若有未提交變更，提示使用者先處理（commit / stash），不可自行 commit 或 stash。
2. 確認無未提交變更（或使用者已處理）後，從目前所在的 base branch 建立並切換新分支：
   ```bash
   git checkout -b <branch-name>
   ```

---

## 完成條件

符合以下其中一種情況即算完成：

- **建立新分支的情況**：
  - 已從使用者貼的內容中判斷出 Trello 編號或 issue 編號（或已向使用者詢問取得）
  - 分支前綴已依專案既有規範決定
  - 分支名稱已經使用者確認
  - 新分支已建立並已切換過去
- **略過的情況**：
  - 已確認目前不在 base branch，且使用者明確回答不需要另開新分支

接著載入 `sub-skills/read-issue.md`，開始原本的 issue 讀取流程。
