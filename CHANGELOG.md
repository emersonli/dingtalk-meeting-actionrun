# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-04-16

### Added

- **自动获取钉钉闪记**：集成 `dws minutes` 命令，支持从 URL 自动提取会议听记摘要和转写文本
- **自动读取钉钉文档**：集成 `dws doc` 命令，可读取相关文档作为上下文
- **钉盘文件访问**：集成 `dws drive` 命令，支持下载会议相关材料
- **真正的消息发送功能**：使用 `dws chat message send` 替代之前的剪贴板草稿方案
- **完善的错误处理机制**：添加听记不存在、文档访问失败等场景的 Fallback 策略
- **CHANGELOG.md**：新增版本变更日志文件

### Changed

- **版本号升级**：从 v0.1.0 升级到 v1.0.0，反映核心功能的完整实现
- **CLI 版本要求**：从 dws v1.0.5+ 更新为 v0.2.14+（使用最新稳定版本）
- **文档全面更新**：README.md、USAGE.md、QUICKSTART.md 全部更新为 V1.0 说明
- **技能定义文件重构**：action-items.md 重写，添加完整的自动化流程说明
- **仓库名称统一**：所有文档中的仓库名称统一为 `dingtalk-meeting-actionrun`

### Fixed

- **修复硬编码路径**：quick-push.sh 和 push-to-github.sh 中的本地路径改为动态获取
- **修正过时信息**：移除"等待官方 API 发布"的过时说明
- **版本号一致性**：所有文档中的版本号统一为 1.0.0

### Removed

- **移除 V0.1 手动输入模式的默认地位**：改为 Fallback 方案
- **删除过时的待办事项列表**：原规划中"等待产品发布"的功能现已实现

---

## [0.1.0] - 2026-03-31

### Added

- **手动输入模式**：用户粘贴会议记录文本进行分析
- **Wake Word 识别**：扫描用户专属指令，优先级最高
- **行动项提取引擎**：识别明确待办 + 隐含待办
- **核心执行能力**：
  - 创建日程（`dws calendar event create`）
  - 查询闲忙（`dws calendar busy query`）
  - 预定会议室（`dws calendar room add`）
  - 创建待办（`dws todo task create`）
  - 搜索联系人（`dws contact user search`）
- **快速命令语法**：支持 `do 1 3`、`全部`、`除了 3` 等快捷操作
- **基础文档**：README.md、USAGE.md、QUICKSTART.md

### Known Issues

- 无法自动获取钉钉闪记（等待官方 API）
- 无法自动读取钉钉文档（等待官方 API）
- "发送消息"功能仅为草稿到剪贴板，未真正发送
- quick-push.sh 和 push-to-github.sh 中存在硬编码的本地路径
- 文档中版本号不一致（部分地方使用旧仓库名 `dingtalk-minutes-tasks`）

---

## 版本说明

- **v0.1.0**：MVP 阶段，基于手动输入的半自动化方案
- **v1.0.0**：完整自动化阶段，集成所有可用的 dws 产品能力
- **v2.0.0**（规划中）：智能化增强，多语言支持，跨会议任务追踪
