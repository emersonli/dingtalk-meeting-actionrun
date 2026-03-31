# DingTalk Meeting ActionRun - 使用指南

**将会议讨论转化为可执行任务，自动帮你完成**

基于钉钉 Workspace CLI 的智能助手技能

---

## 🎯 功能介绍

不只是列出待办清单，而是**直接执行**：

- "把这个发给团队" → 起草并发送消息
- "约个时间 follow up" → 查询空闲时间并创建日程
- "试用下这个新产品" → 查找链接和安装说明
- "把这个任务安排给 XX" → 创建并分配待办
- "看一下这个文档" → 获取、阅读并总结

**所有操作都需要你的确认才会执行。**

---

## ⚡ 快速开始

### 1. 安装钉钉 CLI (v1.0.5+)

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

### 2. 创建钉钉应用

访问 [钉钉开放平台](https://open-dev.dingtalk.com/)：

1. **创建企业内部应用**
   - 进入「企业内部应用 - 钉钉应用」
   - 点击「创建应用」
   - 填写应用名称（如 "DWS CLI"）

2. **配置安全设置**
   - 进入应用 → 安全设置
   - 在「重定向 URL」中添加：
     ```
     http://127.0.0.1,https://login.dingtalk.com
     ```
   - 保存

3. **发布应用**
   - 点击「应用发布 - 版本管理与发布」
   - 提交发布申请

4. **记录凭证**
   - Client ID (AppKey)
   - Client Secret (AppSecret)

### 3. 申请白名单

加入 [钉钉 DWS 共创群](https://qr.dingtalk.com/action/joingroup?code=v1,k1,v9/YMJG9qXhvFk5juktYnQziN70rF7QHebC/JLztTVRuRVJIwrSsXmL8oFqU5ajJ&_dt_no_comment=1&origin=11)，提供：
- Client ID
- 管理员确认凭证

### 4. 登录认证

```bash
dws auth login --client-id <your-app-key> --client-secret <your-app-secret>
```

浏览器会弹出授权页面，完成授权即可。

验证登录：
```bash
dws contact user get-self
```

### 5. 安装技能

```bash
# 克隆仓库
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun

# 或者下载技能文件
mkdir -p ~/.agents/skills/dingtalk-meeting-actionrun
curl -fsSL https://raw.githubusercontent.com/emersonli/dingtalk-meeting-actionrun/main/action-items.md \
  -o ~/.agents/skills/dingtalk-meeting-actionrun/action-items.md
```

---

## 💡 使用方式

### V0.1 版本（手动输入模式）

由于钉钉 CLI 的 `minutes` 产品尚未发布，V0.1 采用手动输入方式：

#### 步骤 1: 准备会议内容

复制你的会议记录/笔记，例如：

```
产品需求评审会议
张三：这个项目下周需要和产品团队 review 一下
李四：对，最好下周二或周三
我：帮我，约一下产品团队下周聊
王五：记得把这个需求文档发给技术部
赵六：Q2 的季度汇报需要在 4 月 15 日前完成
```

#### 步骤 2: 在 AI Agent 中触发

在你的 AI Agent（Claude Code、Cursor 等）中输入：

```
/action-items

帮我处理这个会议记录：

[粘贴上面的会议内容]
```

或者直接描述：

```
帮我分析这个会议记录，提取待办并执行
```

#### 步骤 3: 确认并执行

Agent 会分析会议内容，提取所有行动项，展示为编号列表：

```markdown
📋 行动项（共 3 项）

### 🔴 用户直接指令（Wake Word 触发）

【1】约产品团队下周 review 会议
    背景：张三提到下周需要 review 项目，李四建议周二或周三
    计划：查闲忙 → 推荐时间 → 创建日程 + 预定会议室
    
### 🟡 明确待办

【2】发送需求文档给技术部
    背景：王五提醒发送文档
    计划：起草消息 → 复制到剪贴板
    
【3】完成 Q2 季度汇报
    背景：赵六提到 4 月 15 日截止
    计划：创建待办任务 → 设置截止时间
```

你可以用快速命令回复：

```
do 1 3      # 执行第 1 和 3 项
1 2 你来做  # 执行第 1 和 2 项
除了 3      # 执行除第 3 项外的所有
全部        # 执行所有项
都不做      # 取消执行
```

#### 步骤 4: 查看执行结果

每完成一项会报告结果：

```
✅ 已完成：
【1】约产品团队 review 会议
- 已创建日程：2026-04-08 14:00-15:00
- 参与者：张三、李四、王五等 5 人
- 会议室：3F-会议室 A

【3】完成 Q2 季度汇报
- 已创建待办：你自己
- 截止时间：2026-04-15 18:00
```

---

## 🔧 高级功能

### Wake Word 专属指令

首次使用时，系统会引导你设置 Wake Word（唤醒词）：

1. **自动获取用户信息** - 用于匹配发言人
2. **设置 Wake Word** - 例如："帮我"、"Hey assistant"、"小叮"

**作用**：在会议记录中识别你对 Agent 的直接指令，优先级最高。

**示例**：
- 你说："帮我，下周约产品团队开会" → 提取为："约产品团队开会"
- 这是你在会上对 Agent 的直接命令，会自动置顶显示

### 快速命令语法

| 命令 | 说明 |
|------|------|
| `do 1 3 5` | 执行第 1、3、5 项 |
| `1 2 你来做` | 执行第 1、2 项 |
| `除了 3` | 执行除第 3 项外的所有 |
| `全部` | 执行所有项 |
| `都不做` | 取消执行 |
| `2 改成：...` | 修改第 2 项的执行方式 |

---

## 📋 功能清单

### V0.1 支持 ✅

| 功能 | 状态 | 说明 |
|------|------|------|
| 手动输入 | ✅ | 粘贴会议记录 |
| Wake Word 识别 | ✅ | 扫描专属指令 |
| 行动项提取 | ✅ | 明确 + 隐含待办 |
| 发送消息 | ✅ | 起草 + 复制到剪贴板 |
| 创建日程 | ✅ | 查闲忙 + 创建事件 + 预定会议室 |
| 创建待办 | ✅ | 分配任务 |
| 搜索联系人 | ✅ | 按姓名/部门查找 |
| 信息调研 | ✅ | WebSearch/WebFetch |

### V1.0 规划 🔴

等待钉钉 CLI 发布对应产品：

- 🔴 自动获取钉钉闪记 (`dws minutes`) - 预计 Q2 2026
- 🔴 自动读取钉钉文档 (`dws doc`) - 预计 Q2 2026
- 🔴 钉盘文件访问 (`dws drive`) - 预计 Q2 2026

**V0.1 变通方案**：手动复制会议记录到对话中，Agent 进行分析并执行。

---

## ❓ 常见问题

### Q: 提示"未登录"？

**A**: 先完成登录认证：
```bash
dws auth login --client-id <your-app-key> --client-secret <your-app-secret>
```

### Q: 提示"权限不足"？

**A**: 需要企业管理员授权。请联系管理员加入钉钉 DWS 共创群完成白名单配置。

### Q: 为什么不能自动获取钉钉闪记？

**A**: 钉钉 CLI 的 `minutes` 产品尚未发布（Coming soon）。V0.1 采用手动输入方式，V1.0 将支持自动获取。

### Q: Wake Word 不工作？

**A**: 检查：
1. 是否已完成 onboarding 配置
2. Wake word 是否正确设置
3. 是否在用户本人的发言中（其他人的发言不会触发）

### Q: 如何查看日志？

**A**: 启用调试模式：
```bash
export DWS_DEBUG=1
dws <command> --verbose
```

---

## 🔐 安全说明

- **OAuth 2.0 设备流认证** - 安全的登录方式
- **Token 加密存储** - PBKDF2 + AES-256-GCM
- **域名白名单** - 仅信任 `*.dingtalk.com`
- **最小权限** - 只请求必要的 API 权限
- **全链路审计** - 每次调用都经过钉钉开放平台

---

## 📖 更多文档

- **[English README](../README.md)** - 完整的英文文档
- **[Quick Start Guide](QUICKSTART.md)** - 5 分钟快速入门
- **[Skill Definition](../action-items.md)** - 技术实现细节
- **[Examples](../examples/)** - 示例输入输出

---

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

**开发环境搭建**：
```bash
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun

# 确保已安装钉钉 CLI
dws --version
```

---

## 📬 支持

- **GitHub Issues**: https://github.com/emersonli/dingtalk-meeting-actionrun/issues
- **Discussions**: https://github.com/emersonli/dingtalk-meeting-actionrun/discussions
- **钉钉 DWS 共创群**: [扫码加入](https://qr.dingtalk.com/action/joingroup?code=v1,k1,v9/YMJG9qXhvFk5juktYnQziN70rF7QHebC/JLztTVRuRVJIwrSsXmL8oFqU5ajJ&_dt_no_comment=1&origin=11)

---

**Made with ❤️ for the DingTalk community**

最后更新：2026-03-31
