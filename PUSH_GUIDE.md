# GitHub 推送指南

## 当前状态

✅ **已完成**：
- 所有代码更改已提交到本地 git 仓库
- 远程仓库地址已切换为 SSH 格式：`git@github.com:emersonli/dingtalk-meeting-actionrun.git`
- 提交信息：`chore: 升级到 V1.0 - 集成 dws minutes/doc/drive 自动化能力`

❌ **待完成**：
- 配置 SSH key 认证
- 推送到 GitHub 远程仓库

---

## 方案一：配置 SSH Key（推荐）

### 步骤 1：检查是否已有 SSH key

打开终端，运行：
```bash
ls -la ~/.ssh/
```

如果看到 `id_rsa.pub` 或 `id_ed25519.pub` 文件，说明已有 SSH key，跳到步骤 3。

### 步骤 2：生成新的 SSH key（如果没有）

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

按提示操作，建议直接回车使用默认路径和不设置密码。

### 步骤 3：复制公钥到剪贴板

```bash
# macOS
cat ~/.ssh/id_ed25519.pub | pbcopy

# Linux
cat ~/.ssh/id_ed25519.pub | xclip -selection clipboard

# 或者手动复制
cat ~/.ssh/id_ed25519.pub
```

### 步骤 4：添加到 GitHub

1. 访问 https://github.com/settings/keys
2. 点击 "New SSH key"
3. Title: 填写描述（如 "MacBook Pro"）
4. Key: 粘贴刚才复制的公钥内容
5. 点击 "Add SSH key"

### 步骤 5：测试连接

```bash
ssh -T git@github.com
```

应该看到：
```
Hi emersonli! You've successfully authenticated, but GitHub does not provide shell access.
```

### 步骤 6：推送到 GitHub

```bash
cd /Users/lihao/.real/users/user-819430a2d59e780fbeceeba6969467da/workspace/dingtalk-meeting-actionrun
git push -u origin main
```

---

## 方案二：使用 Personal Access Token（备选）

如果你不想配置 SSH key，可以使用 Personal Access Token。

### 步骤 1：创建 Token

1. 访问 https://github.com/settings/tokens
2. 点击 "Generate new token (classic)"
3. Note: 填写描述（如 "dingtalk-meeting-actionrun"）
4. Expiration: 选择有效期（建议 90 days）
5. Scopes: 勾选 `repo`（完整仓库权限）
6. 点击 "Generate token"
7. **立即复制 token**（只显示一次！）

### 步骤 2：配置远程仓库为 HTTPS + Token

```bash
cd /Users/lihao/.real/users/user-819430a2d59e780fbeceeba6969467da/workspace/dingtalk-meeting-actionrun

# 将 <YOUR_TOKEN> 替换为你刚才复制的 token
git remote set-url origin https://<YOUR_TOKEN>@github.com/emersonli/dingtalk-meeting-actionrun.git
```

### 步骤 3：推送

```bash
git push -u origin main
```

---

## 方案三：使用 quick-push.sh 脚本（最简单）

项目已包含一个快速推送脚本，只需提供 GitHub Token。

### 使用方法

```bash
cd /Users/lihao/.real/users/user-819430a2d59e780fbeceeba6969467da/workspace/dingtalk-meeting-actionrun

# 按照方案一的步骤获取 Personal Access Token
./quick-push.sh <YOUR_GITHUB_TOKEN>
```

脚本会自动：
- 配置远程仓库地址
- 推送到 GitHub
- 显示成功消息和仓库链接

---

## 验证推送结果

推送成功后，访问以下链接确认：
- 仓库地址：https://github.com/emersonli/dingtalk-meeting-actionrun
- 查看最新提交：https://github.com/emersonli/dingtalk-meeting-actionrun/commits/main

应该能看到最新的 commit：
```
chore: 升级到 V1.0 - 集成 dws minutes/doc/drive 自动化能力
```

---

## 常见问题

### Q: 推送时提示 "Permission denied (publickey)"
A: SSH key 未正确配置，请重新检查步骤 1-5。

### Q: 推送时提示 "Authentication failed"
A: Token 可能过期或无效，请重新生成 Personal Access Token。

### Q: 推送时提示 "remote: Repository not found"
A: 确保你已在 GitHub 上创建了仓库 `emersonli/dingtalk-meeting-actionrun`，或者有写入权限。

### Q: 如何创建 GitHub 仓库？
A: 
1. 访问 https://github.com/new
2. Repository name: `dingtalk-meeting-actionrun`
3. Description: "Automatically extract and execute action items from DingTalk meetings"
4. Public/Private: 根据需要选择
5. **不要**勾选 "Initialize this repository with a README"
6. 点击 "Create repository"
7. 然后执行推送命令

---

## 下一步

推送成功后，建议：

1. **更新仓库描述**：
   - 访问 https://github.com/emersonli/dingtalk-meeting-actionrun
   - 点击 "About" → 编辑描述
   - 添加：🤖 Automatically extract and execute action items from DingTalk meetings using dws CLI

2. **添加 Topics**：
   - 在 About 区域点击齿轮图标
   - 添加 topics: `dingtalk`, `meeting-assistant`, `automation`, `dws-cli`, `ai-agent`

3. **创建 Release v1.0.0**：
   - 访问 https://github.com/emersonli/dingtalk-meeting-actionrun/releases/new
   - Tag version: `v1.0.0`
   - Release title: `V1.0.0 - Full Automation with dws Integration`
   - Description: 参考 CHANGELOG.md 的内容
   - 点击 "Publish release"

4. **分享仓库**：
   - 将仓库链接分享给团队成员
   - 在钉钉 DWS 共创群中分享

---

**祝你推送顺利！** 🚀