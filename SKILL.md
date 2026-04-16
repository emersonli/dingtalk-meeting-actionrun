---
name: dingtalk-meeting-actionrun
description: 自动从钉钉会议中提取并执行待办事项。当用户提供钉钉闪记URL、会议记录或会议纪要时，自动获取内容、提取行动项、并通过 dws CLI 执行相关操作（发送消息、安排会议、创建任务等）。适用于需要将会议讨论转化为实际执行的场景。
version: 1.0.0
author: emersonli
tags: [dingtalk, meeting, automation, action-items, dws]
---

# DingTalk Meeting ActionRun Skill

自动从钉钉会议中提取并执行待办事项的智能助手技能。

## 核心能力

- **自动获取会议内容**：通过 `dws minutes` 命令自动获取钉钉闪记的摘要和转录
- **智能提取行动项**：识别直接命令、显式任务和隐式任务
- **自动化执行**：通过 `dws chat/doc/drive` 等命令执行消息发送、文档读取、任务创建等操作
- **用户确认机制**：所有执行操作前需用户确认

## 触发条件

当用户请求处理以下内容时触发：
- 提供钉钉闪记 URL（如 `https://shanji.dingtalk.com/minutes/xxx`）
- 粘贴会议记录文本
- 要求从会议中提取待办事项并执行
- 提及"帮我处理会议记录"、"提取会议行动项"等

## 工作流程

### 1. 获取会议内容

**优先方式**：用户提供钉钉闪记 URL
```bash
dws minutes summary --url <minutes-url>
dws minutes transcript --url <minutes-url>
```

**备选方式**：用户手动提供会议记录文本

### 2. 提取行动项

分析会议内容，识别三类行动项：

**🔴 直接命令（唤醒词触发）**
- 包含"帮我"、"请帮我"、"协助我"等唤醒词
- 明确的执行请求

**🟡 显式任务**
- 明确的任务分配
- 具体的行动指令

**🔵 隐式任务**
- 隐含的后续工作
- 需要跟进的事项

### 3. 生成执行计划

对每个行动项生成详细的执行计划，包括：
- 上下文背景
- 执行步骤
- 所需工具/命令
- 预期输出

### 4. 用户确认

展示所有行动项和执行计划，等待用户确认：
```
📋 行动项列表（共 N 项）

【1】任务描述
    上下文：...
    执行计划：...
    
    是否执行？回复 "1" 或 "do 1"

【2】任务描述
    ...
```

### 5. 执行操作

根据用户确认的编号，执行对应操作：

**发送消息**
```bash
dws chat message send --cid <chat-id> --content "<message>"
```

**安排会议**
```bash
# 先查询空闲时间
dws calendar free-busy --users <user-ids> --start <time> --end <time>
# 创建会议
dws calendar event create --title "<title>" --start <time> --end <time> --attendees <ids>
```

**创建任务**
```bash
dws todo create --title "<title>" --due-date <date> --assignee <user-id>
```

**读取文档**
```bash
dws doc read --url <doc-url>
```

**访问钉盘文件**
```bash
dws drive download --file-id <file-id>
```

## 前置条件

- 已安装 DingTalk CLI (dws) v0.2.14+
- 已完成 `dws auth login` 认证
- 具有相应的权限（发消息、查日程、创建任务等）

## 输出格式

行动项应以清晰的 Markdown 格式呈现，包含：
- 任务编号
- 任务类型标识（🔴/🟡/🔵）
- 任务描述
- 上下文信息
- 执行计划
- 确认提示

## 注意事项

1. **安全第一**：所有执行操作前必须获得用户明确确认
2. **权限检查**：执行前确保有足够的权限
3. **错误处理**：如命令执行失败，提供清晰的错误信息和备选方案
4. **隐私保护**：不泄露会议敏感信息
5. **幂等性**：避免重复执行相同操作

## 示例

### 输入
```
帮我处理这个会议记录：
https://shanji.dingtalk.com/minutes/abc-123-def
```

### 输出
```markdown
📋 行动项（共 3 项）

### 🔴 直接命令

【1】安排产品团队评审会议
    上下文：张提到需要 review Q2 roadmap，李建议周二或周三下午
    执行计划：
    - 查询团队成员空闲时间
    - 推荐 3 个时间段
    - 创建日历事件并预定会议室
    
    是否执行？回复 "1" 或 "do 1"

### 🟡 显式任务

【2】发送需求文档给技术团队
    上下文：王提醒要发送文档
    执行计划：起草消息 → 通过 dws chat 发送
    
    是否执行？回复 "2" 或 "do 2"

### 🔵 隐式任务

【3】跟踪测试计划进度
    上下文：赵说要在 4 月 15 日前完成
    执行计划：创建 TODO 任务 → 设置截止日期
    
    是否执行？回复 "3" 或 "do 3"
```

## 参考资源

- [完整中文文档](docs/USAGE.md)
- [快速开始指南](docs/QUICKSTART.md)
- [示例文件](examples/example-meeting-notes.txt)
- [GitHub 仓库](https://github.com/emersonli/dingtalk-meeting-actionrun)

## 版本历史

- **v1.0.0**：集成 dws minutes/doc/drive/chat 命令，实现全自动化的会议行动项处理
- **v0.1.0**：初始 MVP 版本，支持手动输入会议记录