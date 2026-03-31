# DingTalk Action Items - Agent Skill

**Version**: 0.1.0 (MVP)  
**Platform**: DingTalk Workspace CLI v1.0.5+  
**Language**: Chinese (中文)

将会议讨论转化为可执行任务，并自动帮你完成。

---

## 功能说明

本技能帮助你在会议后：
- 提取所有待办事项（明确的 + 隐含的）
- 识别专属指令（通过 Wake Word）
- 自动执行可操作的任务
- 跟踪任务执行情况

### 核心理念

从 to-do 到 done，直接执行而不是简单列出清单。

---

## 使用方式

### V0.1 版本说明

由于钉钉 CLI 的 `minutes` 产品尚未发布，当前版本采用手动输入模式：

1. **准备会议内容**
   - 复制会议记录/笔记
   - 或整理口头描述的文字稿

2. **触发技能**
   
   在 AI Agent 中输入会议内容，例如：
   ```
   帮我处理这个会议记录：
   
   张三：下周需要和产品团队 review 项目
   李四：建议周二或周三下午
   我：帮我约一下产品团队下周聊
   ```

3. **确认执行**
   
   Agent 会分析并列出所有行动项，等待你确认后执行。

---

## 首次配置

### Onboarding 流程

第一次使用时会自动引导配置：

**步骤 1: 获取用户信息**

```bash
dws contact user get-self -f json
```

自动提取：
- 用户姓名（用于匹配发言人）
- 所属部门
- userId

**步骤 2: 设置 Wake Word**

系统会询问：
```
👋 欢迎使用！

请设置你的专属唤醒词（可选）：
- 比如："帮我"、"Hey assistant"、"小叮"
- 直接回车跳过：不启用此功能
```

Wake Word 作用：在会议记录中识别你对 Agent 的直接指令，优先级最高。

---

## 能力范围

### ✅ V0.1 支持

| 类别 | 功能 | 实现方式 |
|------|------|----------|
| **输入** | 手动粘贴文本 | 用户复制会议记录到对话 |
| **分析** | Wake Word 扫描 | 识别用户专属指令 |
| **分析** | 行动项提取 | 明确待办 + 隐含待办 |
| **执行** | 发送消息 | 起草内容 → 复制到剪贴板 |
| **执行** | 创建日程 | `dws calendar event create` |
| **执行** | 查询闲忙 | `dws calendar busy query` |
| **执行** | 预定会议室 | `dws calendar room add` |
| **执行** | 创建待办 | `dws todo task create` |
| **执行** | 搜索联系人 | `dws contact user search` |
| **执行** | 信息调研 | WebSearch/WebFetch |

### 🔴 V1.0 规划

等待钉钉 CLI 发布对应产品后实现：

- 自动获取钉钉闪记 (`dws minutes`)
- 自动读取钉钉文档 (`dws doc`)
- 钉盘文件访问 (`dws drive`)
- 会议录制文本获取 (`dws conference`)

---

## Wake Word 机制

### 工作原理

1. **扫描范围**: 仅扫描用户本人的发言
2. **识别规则**: wake word 后的内容视为对 Agent 的指令
3. **优先级**: Wake Word 指令 > 普通待办 > 隐含待办

### 示例

**有效指令**:
- "帮我，下周约产品团队开会" → 提取：约会议
- "帮我记一下，明天提交报告" → 提取：创建提醒

**无效指令**（跳过）**:
- "我觉得'帮我'这个词挺好的" → 这是在讨论词语本身
- "他说帮我把文件发出去" → 这是转述别人的话

---

## 执行流程

### Step 1: 输入解析

接收用户提供的会议文本，判断是否包含 Wake Word 指令。

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
    计划：查闲忙 → 推荐时间 → 创建日程
    需要确认：是/否

### 🟡 明确待办

【2】发送需求文档给技术部
    背景：王五提醒发送文档
    计划：起草消息 → 复制到剪贴板
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
dws contact user get-self -f json

# 查询闲忙状态
dws calendar busy query \
  --user-ids "<userId1>,<userId2>" \
  --start-time <timestamp> \
  --end-time <timestamp>

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
  --end-time <timestamp>
dws calendar room add \
  --event-id "<eventId>" \
  --room-ids "<roomId>"

# 创建待办
dws todo task create \
  --title "任务标题" \
  --executors "<userId>" \
  --description "任务描述" \
  --yes

# 搜索联系人
dws contact user search --keyword "张三" -f json
dws contact dept search --query "技术部" -f json
```

### 安全机制

- **OAuth 2.0 设备流认证**: 安全的登录方式
- **Token 加密存储**: PBKDF2 + AES-256-GCM
- **域名白名单**: 仅信任 `*.dingtalk.com`
- **最小权限**: 只请求必要的 API 权限
- **全链路审计**: 每次调用都经过钉钉开放平台

---

## 错误处理

### 常见场景

**未登录**:
```
⚠️ 检测到未登录状态

请先运行：
dws auth login --client-id <your-app-key>
```

**权限不足**:
```
⚠️ 权限不足：需要企业管理员授权

请联系管理员加入钉钉 DWS 共创群完成白名单配置
```

**不支持的功能**:
```
🚧 此功能将在 V1.0 版本支持

当前变通方案：
1. 手动创建文档
2. 我可以帮你起草内容并复制到剪贴板
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

1. **批量确认**: 不要逐项确认，一次性指定要执行的项目
2. **优先级排序**: 先执行高优先级的 Wake Word 指令
3. **合理分工**: 能自动执行的让 Agent 做，需要人工的判断清楚

---

## 更新日志

### v0.1.0 (2026-03-31)

**Added**:
- 手动输入模式
- Wake Word 识别
- 行动项提取引擎
- 核心执行能力（日程、待办、消息）
- 快速命令语法

**Known Issues**:
- 无法自动获取钉钉闪记（等待官方 API）
- 无法自动读取钉钉文档（等待官方 API）

---

## 维护信息

**作者**: emersonli  
**仓库**: https://github.com/emersonli/dingtalk-action-items  
**许可**: Apache 2.0

**反馈与支持**:
- GitHub Issues: https://github.com/emersonli/dingtalk-action-items/issues
- 钉钉 DWS 共创群：扫码加入

---

*最后更新：2026-03-31*
