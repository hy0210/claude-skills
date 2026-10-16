# claude-skills

hy0210 的個人 Claude Code skill，打包成單一 plugin `hy0210`。

## 安裝

```
/plugin marketplace add hy0210/claude-skills
/plugin install hy0210@claude-skills
```

建議開啟自動更新：`/plugin` → Marketplaces → `claude-skills` → Enable auto-update。

## 包含的 Skills

| 指令 | 說明 |
|------|------|
| `/hy0210:figma-link-guard` | Figma 連結安全守則 |
| `/hy0210:frontend-code-review` | 前端 code review 團隊約束 |
| `/hy0210:implement-issue` | 依 issue 實作的完整流程（需 OpenSpec） |
| `/hy0210:implement-issue-with-test` | TDD 版 issue 實作流程（需 OpenSpec） |
| `/hy0210:coderabbit-review-triage` | CodeRabbit review 建議分析 |

## 更新流程

1. 修改 `plugins/hy0210/skills/<skill>/` 內的檔案
2. 同步提高 `plugins/hy0210/.claude-plugin/plugin.json` 與 `.claude-plugin/marketplace.json` 的 `version`
3. commit 並 push，已開啟自動更新的環境會在下次啟動時取得新版

## 結構

```
.claude-plugin/marketplace.json
plugins/hy0210/
├── .claude-plugin/plugin.json
└── skills/<skill>/SKILL.md
```
