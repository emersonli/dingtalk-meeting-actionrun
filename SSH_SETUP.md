# SSH Key 配置指南 - GitHub 推送

## 当前状态

✅ 远程仓库已配置为 SSH 格式：`git@github.com:emersonli/dingtalk-meeting-actionrun.git`  
❌ SSH 认证尚未完成，需要配置 SSH key

---

## 快速配置步骤

### 步骤 1：检查是否已有 SSH key

在终端中运行：
```bash
ls -la ~/.ssh/*.pub
```

如果看到类似 `id_rsa.pub` 或 `id_ed25519.pub` 的文件，说明已有 SSH key，跳到**步骤 3**。

如果没有找到任何 `.pub` 文件，继续**步骤 2**。

---

### 步骤 2：生成新的 SSH key

在终端中运行：
```bash
ssh-keygen -t ed25519 -C "lihao@alibaba-inc.com"
```

系统会提示：
```
Generating public/private ed25519 key pair.
Enter file in which to save the key (/Users/lihao/.ssh/id_ed25519): [直接回车]
Enter passphrase (empty for no passphrase): [直接回车，不设置密码]
Enter same passphrase again: [直接回车]
```

完成后会看到：
```
Your identification has been saved in /Users/lihao/.ssh/id_ed25519
Your public key has been saved in /Users/lihao/.ssh/id_ed25519.pub
```

---

### 步骤 3：复制公钥内容

运行以下命令复制公钥到剪贴板：
```bash
cat ~/.ssh/id_ed25519.pub | pbcopy
```

或者手动查看并复制：
```bash
cat ~/.ssh/id_ed25519.pub
```

你会看到类似这样的内容（以 `ssh-ed25519` 开头）：
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAI... lihao@alibaba-inc.com
```

**完整复制这一行内容**。

---

### 步骤 4：添加到 GitHub

1. **访问 GitHub SSH 设置页面**  
   打开浏览器，访问：https://github.com/settings/keys

2. **点击 "New SSH key"**  
   在页面右上角找到并点击这个按钮

3. **填写信息**  
   - **Title**: 输入描述，例如 `MacBook Pro - 2026`
   - **Key**: 粘贴刚才复制的公钥内容（整个 `ssh-ed25519 ...` 那一行）

4. **点击 "Add SSH key"**  
   可能需要输入 GitHub 密码确认

---

### 步骤 5：测试 SSH 连接

在终端中运行：
```bash
ssh -T git@github.com
```

首次连接时会提示：
```
The authenticity of host 'github.com (xxx.xxx.xxx.xxx)' can't be established.
ED25519 key fingerprint is SHA256:+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU.
This key is not known by any other names.
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

输入 `yes` 并回车。

成功后会看到：
```
Hi emersonli! You've successfully authenticated, but GitHub does not provide shell access.
```

**看到这个消息就说明 SSH 配置成功了！** ✅

---

### 步骤 6：推送到 GitHub

现在可以推送代码了：

```bash
cd /Users/lihao/.real/users/user-819430a2d59e780fbeceeba6969467da/workspace/dingtalk-meeting-actionrun
git push -u origin main
```

应该会看到类似这样的输出：
```
Enumerating objects: 15, done.
Counting objects: 100% (15/15), done.
Delta compression using up to 10 threads
Compressing objects: 100% (10/10), done.
Writing objects: 100% (10/10), 8.50 KiB | 8.50 MiB/s, done.
Total 10 (delta 5), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (5/5), completed with 5 local objects.
To github.com:emersonli/dingtalk-meeting-actionrun.git
   abc1234..def5678  main -> main
branch 'main' set up to track 'origin/main'.
```

**推送成功！** 🎉

---

## 验证推送结果

访问以下链接确认代码已上传：
- 仓库主页：https://github.com/emersonli/dingtalk-meeting-actionrun
- 最新提交：https://github.com/emersonli/dingtalk-meeting-actionrun/commits/main

应该能看到最新的 commit：
```
chore: 升级到 V1.0 - 集成 dws minutes/doc/drive 自动化能力
```

---

## 常见问题排查

### Q1: 提示 "Permission denied (publickey)"

**原因**：SSH key 未正确添加到 GitHub 或使用了错误的 key

**解决**：
1. 确认公钥已正确添加到 https://github.com/settings/keys
2. 检查使用的 key 是否正确：
   ```bash
   ssh-add -l
   ```
3. 如果看到多个 key，指定使用正确的：
   ```bash
   ssh-add ~/.ssh/id_ed25519
   ```

### Q2: 提示 "Could not resolve hostname github.com"

**原因**：网络连接问题

**解决**：
1. 检查网络连接
2. 尝试 ping GitHub：
   ```bash
   ping github.com
   ```

### Q3: 提示 "Host key verification failed"

**原因**：known_hosts 文件权限问题或 GitHub 主机密钥变更

**解决**：
```bash
# 删除旧的 known_hosts 条目
ssh-keygen -R github.com

# 重新测试连接
ssh -T git@github.com
```

### Q4: 推送时提示 "Repository not found"

**原因**：GitHub 上尚未创建仓库，或没有写入权限

**解决**：
1. 访问 https://github.com/new 创建仓库
2. Repository name: `dingtalk-meeting-actionrun`
3. **不要**勾选 "Initialize this repository with a README"
4. 创建后重新推送

---

## 一键配置脚本（可选）

如果你想自动化整个过程，可以运行以下脚本：

```bash
#!/bin/bash

echo "🔑 开始配置 GitHub SSH Key..."

# 检查是否已有 SSH key
if [ -f ~/.ssh/id_ed25519.pub ]; then
    echo "✅ 检测到现有 SSH key"
    cat ~/.ssh/id_ed25519.pub | pbcopy
    echo "📋 公钥已复制到剪贴板"
else
    echo "⚙️  生成新的 SSH key..."
    ssh-keygen -t ed25519 -C "lihao@alibaba-inc.com" -N "" -f ~/.ssh/id_ed25519
    cat ~/.ssh/id_ed25519.pub | pbcopy
    echo "📋 新公钥已复制到剪贴板"
fi

echo ""
echo "📝 下一步操作："
echo "1. 访问 https://github.com/settings/keys"
echo "2. 点击 'New SSH key'"
echo "3. 粘贴公钥（已复制到剪贴板）"
echo "4. 添加后运行：ssh -T git@github.com"
echo "5. 测试成功后运行：git push -u origin main"
echo ""
echo "祝你好运！🚀"
```

保存为 `setup-ssh.sh`，然后运行：
```bash
chmod +x setup-ssh.sh
./setup-ssh.sh
```

---

## 完成后的清理工作

推送成功后，建议：

1. **更新仓库描述和 Topics**
   - 访问 https://github.com/emersonli/dingtalk-meeting-actionrun
   - 在 About 区域添加描述和 topics

2. **创建 Release v1.0.0**
   - 访问 https://github.com/emersonli/dingtalk-meeting-actionrun/releases/new
   - 参考 CHANGELOG.md 填写发布说明

3. **分享仓库**
   - 将链接分享给团队成员
   - 在钉钉 DWS 共创群中分享

---

**如有问题，请参考 PUSH_GUIDE.md 中的其他推送方案。**