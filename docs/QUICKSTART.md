# 快速入门指南

5 分钟快速开始使用 DingTalk Meeting ActionRun。

---

## 第一步：安装钉钉 CLI (2 分钟)

### macOS / Linux

```bash
curl -fsSL https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.sh | sh
```

### Windows (PowerShell)

```powershell
irm https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.ps1 | iex
```

### 验证安装

```bash
dws --version
```

应该看到类似输出：

```
dws version v0.2.14
```

---

## 第二步：配置钉钉应用 (3 分钟)

### 1. 创建企业内部应用

1. 访问 [钉钉开放平台](https://open-dev.dingtalk.com/)
2. 登录你的钉钉企业账号
3. 进入「企业内部应用 - 钉钉应用」
4. 点击**创建应用**
   - 应用名称：例如"DWS CLI"
   - 应用图标：随意选择
   - 应用描述：选填

### 2. 配置安全设置

1. 进入应用 → **安全设置**
2. 在「重定向 URL」中添加：
   ```
   http://127.0.0.1,https://login.dingtalk.com
   ```
3. 保存配置

### 3. 发布应用

1. 点击「应用发布 - 版本管理与发布」
2. 提交发布申请
3. 等待审核通过（通常很快）

### 4. 记录凭证

在应用详情页，记录以下信息：
- **Client ID** (AppKey)
- **Client Secret** (AppSecret)

⚠️ **重要**: 请妥善保管 Client Secret，不要泄露给他人。

---

## 第三步：申请白名单 (1 分钟)

### 加入钉钉 DWS 共创群

1. 扫码加入钉钉 DWS 共创群：
   ![DingTalk Group QR Code](https://img.alicdn.com/imgextra/i4/O1CN01Rijgk81gKqVSKMzdx_!!6000000004124-2-tps-654-644.png)

2. 在群内提供：
   - 你的 Client ID
   - 管理员确认凭证

3. 等待白名单配置完成

---

## 第四步：登录认证 (1 分钟)

```bash
dws auth login
```

系统会弹出浏览器让你授权。完成授权后，命令行会显示：

```
✅ 登录成功！
欢迎，[你的姓名]
```

### 验证登录

```bash
dws contact user get-self
```

如果能看到你的用户信息，说明登录成功。

---

## 第五步：安装 Skill (30 秒)

### 方式 1: 克隆仓库（推荐）

```bash
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun
```

### 方式 2: 直接下载

```bash
mkdir -p ~/.agents/skills/dingtalk-meeting-actionrun
curl -fsSL https://raw.githubusercontent.com/emersonli/dingtalk-meeting-actionrun/main/action-items.md \
  -o ~/.agents/skills/dingtalk-meeting-actionrun/action-items.md
```

---

## 第六步：开始使用！

### 在你的 AI Agent 中

1. **打开 AI Agent**（如 Claude Code、Cursor 等）

2. **加载 Skill**（如果 Agent 支持）

3. **提供会议内容**

   **方式 A：自动获取听记（推荐）**
   
   直接粘贴钉钉闪记 URL：
   ```
   帮我处理这个会议听记：
   https://shanji.dingtalk.com/minutes/xxx-xxx-xxx
   ```

   **方式 B：手动输入（Fallback）**
   
   粘贴会议记录：
   ```
   帮我分析这个会议记录：
   
   张三：下周需要和产品团队 review 一下项目
   李四：最好下周二或周三
   我：帮我，约一下产品团队下周聊
   ```

4. **触发技能**

   输入：
   ```
   /action-items
   ```
   
   或者直接描述：
   ```
   帮我提取待办并执行
   ```

5. **确认并执行**

   Agent 会展示所有行动项，你只需回复编号即可：
   ```
   do 1 3 5
   ```

---

## 🎉 完成！

现在你已经成功配置好 DingTalk Meeting ActionRun！

### 下一步

- 📖 查看 [完整文档](../README.md) 了解更多功能
- 📝 尝试 [示例](../examples/example-meeting-notes.txt) 体验完整流程
- 🗺️ 了解 [路线图](../README.md#🗺️-roadmap) 知道未来会有什么新功能

---

## ❓ 遇到问题？

### 常见问题速查

| 问题 | 解决方案 |
|------|----------|
| 提示"未登录" | 运行 `dws auth login` 重新登录 |
| 提示"权限不足" | 联系企业管理员加入白名单 |
| 找不到命令 | 检查 CLI 是否安装到 PATH |
| Skill 不工作 | 确认 action-items.md 路径正确 |
| 无法获取听记 | 检查 URL 是否正确，或改用手动输入模式 |

### 获取帮助

- 📖 [完整文档](../README.md)
- 🐛 [提交 Issue](https://github.com/emersonli/dingtalk-meeting-actionrun/issues)
- 💬 [钉钉 DWS 共创群](https://qr.dingtalk.com/action/joingroup?code=v1,k1,v9/YMJG9qXhvFk5juktYnQziN70rF7QHebC/JLztTVRuRVJIwrSsXmL8oFqU5ajJ&_dt_no_comment=1&origin=11)

---

**祝你使用愉快！** 🚀
