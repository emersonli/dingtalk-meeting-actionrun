# 使用指南

详细的英文文档请查看 [README.md](../README.md)。

## 快速开始

### 1. 安装钉钉 CLI

```bash
curl -fsSL https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.sh | sh
```

### 2. 配置并登录

```bash
dws auth login --client-id <your-app-key> --client-secret <your-app-secret>
```

详细配置步骤请参考 [钉钉 CLI 官方文档](https://github.com/DingTalk-Real-AI/dingtalk-workspace-cli/blob/main/README_zh.md)。

### 3. 使用技能

在 AI Agent 中提供会议记录，例如：

```
帮我处理这个会议记录：

张三：下周需要和产品团队 review 项目
李四：建议周二或周三下午
我：帮我约一下产品团队下周聊
```

Agent 会自动分析并提取待办事项，等待你确认后执行。

## 核心功能

- ✅ 提取行动项（明确待办 + 隐含待办）
- ✅ Wake Word 识别（专属指令）
- ✅ 自动执行（创建日程、待办、发消息等）
- ✅ 快速命令语法（"do 1 3 5"）

## V0.1 限制

当前版本采用手动输入模式，自动获取闪记和文档的功能将在 V1.0 支持（等待钉钉 CLI 更新）。

详细技术文档请查看 [action-items.md](action-items.md)。
