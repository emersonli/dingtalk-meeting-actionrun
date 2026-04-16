# DingTalk Meeting ActionRun - Agent Skill

**Version**: 1.0.0  
**Platform**: DingTalk Workspace CLI (dws) v0.2.14+  
**Language**: Chinese (中文)

自动获取会议听记、提取行动项并执行任务，实现从会议讨论到任务完成的自动化闭环。

---

## 功能说明

本技能帮助你在会议后：
- **自动获取钉钉闪记**：通过 `dws minutes` 获取会议录音转写和 AI 摘要
- **智能提取待办事项**：识别明确待办 + 隐含待办 + Wake Word 专属指令
- **自动执行可操作任务**：创建日程、待办、发送消息、读取文档等
- **跟踪任务执行情况**：生成执行报告并通知相关人员

### 核心理念

从 to-do 到 done，直接执行而不是简单列出清单。

---

## 快速开始

### 前置条件

1. **安装钉钉 CLI**

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.sh | sh

# Windows (PowerShell)
irm https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.ps1 | iex
```

验证安装：
```bash
dws --version
```

2. **登录认证**

```bash
dws auth login
```

3. **安装技能**

```bash
# 克隆仓库
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun

# 或下载技能文件
mkdir -p ~/.agents/skills/dingtalk-meeting-actionrun
curl -fsSL https://raw.githubusercontent.com/emersonli/dingtalk-meeting-actionrun/main/action-items.md \
  -o ~/.agents/skills/dingtalk-meeting-actionrun/action-items.md
```

### 使用方式

#### 方式 1：自动获取会议听记（推荐）

提供钉钉闪记 URL 或会议 ID：

```
帮我处理这个会议听记：
https://shanji.dingtalk.com/minutes/xxx-xxx-xxx
```

或直接说：
```
分析我今天的会议听记，提取待办并执行
```

#### 方式 2：手动输入会议记录

如果会议未生成闪记，可以粘贴文本：

```
帮我处理这个会议记录：

张三：下周需要和产品团队 review 项目
李四：建议周二或周三下午
我：帮我约一下产品团队下周聊
```

---

## 核心能力

### ✅ V1.0 完整支持

| 类别 | 功能 | 实现方式 |
|------|------|----------|
| **输入** | 自动获取钉钉闪记 | `dws minutes list/summary/transcript` |
| **输入** | 读取钉钉文档 | `dws doc read` |
| **输入** | 访问钉盘文件 | `dws drive download` |
| **输入** | 手动粘贴文本 | 用户复制会议记录到对话 |
| **分析** | Wake Word 扫描 | 识别用户专属指令 |
| **分析** | 行动项提取 | 明确待办 + 隐含待办 + AI 推理 |
| **执行** | 发送消息 | `dws chat message send` |
| **执行** | 创建日程 | `dws calendar event create` |
| **执行** | 查询闲忙 | `dws calendar busy query` |
| **执行** | 预定会议室 | `dws calendar room add` |
| **执行** | 创建待办 | `dws todo task create` |
| **执行** | 搜索联系人 | `dws contact user search` |
| **执行** | 信息调研 | WebSearch/WebFetch |
| **执行** | 更新文档 | `dws doc update` |

### 🔴 未来规划（V2.0）

- 多语言支持（英文、日文等）
- 智能行动识别优化（基于历史数据学习）
- 跨会议任务关联与追踪
- 自动生成会议纪要文档

---

## Wake Word 机制

### 工作原理

1. **扫描范围**：仅扫描用户本人的发言
2. **识别规则**：wake word 后的内容视为对 Agent 的指令
3. **优先级**：Wake Word 指令 > 普通待办 > 隐含待办

### 示例

**有效指令**：
- "帮我，下周约产品团队开会" → 提取：约会议
- "帮我记一下，明天提交报告" → 提取：创建提醒

**无效指令**（跳过）：
- "我觉得'帮我'这个词挺好的" → 这是在讨论词语本身
- "他说帮我把文件发出去" → 这是转述别人的话

---

## 执行流程

### Step 1: 获取会议内容

**优先尝试自动获取**：

```bash
# 从 URL 提取听记
dws minutes summary --task-uuid <uuid-from-url> --format json
dws minutes transcript --task-uuid <uuid-from-url> --format json

# 或列出最近听记
dws minutes list --limit 5 --format json
```

**Fallback：手动输入**

如果无法自动获取，提示用户粘贴会议记录文本。

### Step 2: 深度分析

仔细阅读文本，识别：

**A. Wake Word 指令**（最高优先级）
- 用户直接使用 wake word 表达的需求
- 通常是明确的行动要求

**B. 明确待办**
- 会议上明确分配的任务
- 有具体责任人和截止时间的安排

**C. 隐含待办**
- 从对话上下文中推理出的后续动作
- 需要结合常识判断

### Step 3: 展示行动计划

格式示例：

```markdown
📋 行动项清单（共 3 项）

### 🔴 专属指令（Wake Word 触发）

【1】约产品团队 review 会议
    背景：张三提到下周需要 review 项目
    计划：查闲忙 → 推荐时间 → 创建日程 + 预定会议室
    需要确认：是/否

### 🟡 明确待办

【2】发送需求文档给技术部
    背景：王五提醒发送文档
    计划：起草消息 → 通过 dws chat 发送
    需要确认：是/否

### 🔵 隐含待办

【3】跟踪测试方案进度
    背景：赵六说 4 月 15 日前完成
    计划：创建待办任务 → 设置截止时间
    需要确认：是/否
```

### Step 4: 用户确认

快速命令语法：

```
do 1 3      # 执行第 1 和 3 项
1 2 你来做  # 执行第 1 和 2 项
除了 3      # 执行除第 3 项外的所有
全部        # 执行所有项
都不做      # 取消执行
```

### Step 5: 逐项执行

每完成一项报告结果：

```
✅ 已完成：

【1】约产品团队 review 会议
- 已创建日程：2026-04-08 14:00-15:00
- 参与者：张三、李四、王五等 5 人
- 会议室：3F-会议室 A

【3】跟踪测试方案进度
- 已创建待办：赵六
- 截止时间：2026-04-15 18:00
```

---

## 技术实现

### 依赖的 CLI 命令

```bash
# 获取自身信息
dws contact user get-self --format json

# 获取听记列表
dws minutes list --limit 10 --format json

# 获取听记摘要
dws minutes summary --task-uuid <uuid> --format json

# 获取听记转写文本
dws minutes transcript --task-uuid <uuid> --format json

# 查询闲忙状态
dws calendar busy query \
  --user-ids "<userId1>,<userId2>" \
  --start-time <timestamp> \
  --end-time <timestamp> \
  --format json

# 创建日程
dws calendar event create \
  --summary "会议标题" \
  --start-date-time "2026-04-08T14:00:00+08:00" \
  --end-date-time "2026-04-08T15:00:00+08:00" \
  --attendees "<userId1>,<userId2>" \
  --description "会议描述" \
  --yes

# 预定会议室
dws calendar room list \
  --start-time <timestamp> \
  --end-time <timestamp> \
  --format json
dws calendar room add \
  --event-id "<eventId>" \
  --room-ids "<roomId>" \
  --yes

# 创建待办
dws todo task create \
  --title "任务标题" \
  --executors "<userId>" \
  --description "任务描述" \
  --due-date "2026-04-15T18:00:00+08:00" \
  --yes

# 搜索联系人
dws contact user search --keyword "张三" --format json
dws contact dept search --query "技术部" --format json

# 发送消息
dws chat message send \
  --cid "<chatId>" \
  --content "消息内容" \
  --yes

# 读取钉钉文档
dws doc read --node "<docUrl>" --format json

# 下载钉盘文件
dws drive download --file-id "<fileId>" --output-path "./downloads"
```

### 安全机制

- **OAuth 2.0 设备流认证**：安全的登录方式
- **Token 加密存储**：PBKDF2 + AES-256-GCM
- **域名白名单**：仅信任 `*.dingtalk.com`
- **最小权限**：只请求必要的 API 权限
- **全链路审计**：每次调用都经过钉钉开放平台

---

## 错误处理

### 常见场景

**未登录**：
```
⚠️ 检测到未登录状态

请先运行：
dws auth login
```

**权限不足**：
```
⚠️ 权限不足：需要企业管理员授权

请联系管理员加入钉钉 DWS 共创群完成白名单配置
```

**听记不存在**：
```
⚠️ 未找到对应的会议听记

可能原因：
1. 会议未开启录音功能
2. 听记尚未生成完成
3. URL 或 UUID 不正确

变通方案：请手动粘贴会议记录文本
```

**文档访问失败**：
```
⚠️ 无法访问文档：权限不足或文档不存在

请确认：
1. 你有该文档的查看权限
2. 文档链接正确
3. 文档未被删除
```

---

## 最佳实践

### 提高识别准确率

1. **清晰的发言人标注**
   ```
   好：张三：这个项目需要 review
   差：这个项目需要 review（不知道谁说的）
   ```

2. **明确的时间表达**
   ```
   好：下周二下午 3 点
   差：回头、改天（模糊时间）
   ```

3. **具体的责任人**
   ```
   好：这个任务交给技术部的王五
   差：有人负责一下（不明确）
   ```

### 高效执行技巧

1. **批量确认**：不要逐项确认，一次性指定要执行的项目
2. **优先级排序**：先执行高优先级的 Wake Word 指令
3. **合理分工**：能自动执行的让 Agent 做，需要人工的判断清楚
4. **利用听记 URL**：直接提供闪记 URL 比手动粘贴更准确

---

## 更新日志

### v1.0.0 (2026-04-16)

**Added**：
- 自动获取钉钉闪记（`dws minutes`）
- 自动读取钉钉文档（`dws doc`）
- 钉盘文件访问（`dws drive`）
- 真正的消息发送功能（`dws chat message send`）
- 完善的错误处理和 Fallback 机制

**Changed**：
- 从 V0.1 手动输入模式升级为 V1.0 自动化模式
- 修正仓库 URL 为 `dingtalk-meeting-actionrun`
- 更新所有 CLI 命令为最新 dws 语法

**Removed**：
- 移除"等待官方 API"的过时说明

### v0.1.0 (2026-03-31)

**Added**：
- 手动输入模式
- Wake Word 识别
- 行动项提取引擎
- 核心执行能力（日程、待办、消息草稿）
- 快速命令语法

**Known Issues**：
- 无法自动获取钉钉闪记（等待官方 API）
- 无法自动读取钉钉文档（等待官方 API）

---

## 维护信息

**作者**：emersonli  
**仓库**：https://github.com/emersonli/dingtalk-meeting-actionrun  
**许可**：Apache 2.0

**反馈与支持**：
- GitHub Issues: https://github.com/emersonli/dingtalk-meeting-actionrun/issues
- GitHub Discussions: https://github.com/emersonli/dingtalk-meeting-actionrun/discussions
- 钉钉 DWS 共创群：扫码加入（见 docs/USAGE.md）

---

*最后更新：2026-04-16*
