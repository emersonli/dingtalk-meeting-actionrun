# DingTalk Action Items

[![Version](https://img.shields.io/badge/version-0.1.0-blue)](https://github.com/emersonli/dingtalk-action-items/releases)
[![DingTalk CLI](https://img.shields.io/badge/dws-v1.0.5+-green)](https://github.com/DingTalk-Real-AI/dingtalk-workspace-cli)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue)](LICENSE)

**Turn meeting discussions into actionable tasks and get things done automatically.**

An intelligent agent skill for DingTalk Workspace CLI that extracts action items from meeting notes and executes them on your behalf.

---

## 🎯 What It Does

Instead of just listing TODOs, this skill actually **executes** them for you:

- "Send this to the team" → Drafts and sends the message
- "Schedule a follow-up" → Finds available time slots and creates the event  
- "Try this new tool" → Researches and shares installation instructions
- "Assign this task to XX" → Creates and assigns the TODO item
- "Review this document" → Fetches, reads, and summarizes

**All actions require your confirmation before execution.**

---

## ⚡ Quick Start

### Prerequisites

1. **Install DingTalk CLI** (v1.0.5+)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.sh | sh

# Windows (PowerShell)
irm https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.ps1 | iex
```

2. **Setup & Authentication**

Follow the [Chinese quick start guide](README_CN.md#快速入门) for detailed setup instructions in Chinese.

### Installation

```bash
# Clone this repository
git clone https://github.com/emersonli/dingtalk-action-items.git
cd dingtalk-action-items

# Or download the skill file directly
mkdir -p ~/.agents/skills/dingtalk-action-items
curl -fsSL https://raw.githubusercontent.com/emersonli/dingtalk-action-items/main/action-items.md \
  -o ~/.agents/skills/dingtalk-action-items/action-items.md
```

### Usage

**V0.1 Mode (Manual Input)**

Since DingTalk CLI's `minutes` product is not yet available, V0.1 uses manual input:

1. **Provide Meeting Content** - Copy and paste your meeting notes into the conversation

2. **Trigger the Skill**

   In your AI Agent (Claude Code, Cursor, etc.):
   ```
   /action-items
   ```

3. **Review & Confirm** - The agent will extract all action items and wait for your confirmation

4. **Execute** - Reply with item numbers to execute, e.g., "do 1 3 5"

---

## 📋 Features

### Available in V0.1 ✅

| Feature | Status | Description |
|---------|--------|-------------|
| Manual Input | ✅ | Paste meeting notes manually |
| Wake Word Detection | ✅ | Scan for personal commands |
| Action Item Extraction | ✅ | Extract explicit & implicit tasks |
| Send Messages | ✅ | Draft & copy to clipboard |
| Schedule Meetings | ✅ | Check availability & create events |
| Create Tasks | ✅ | Assign TODOs to executors |
| Search Contacts | ✅ | Find users by name/department |
| Web Research | ✅ | WebSearch/WebFetch integration |

### Planned for V1.0 🔴

| Feature | Dependency | ETA |
|---------|------------|-----|
| Auto-fetch DingTalk Minutes | `dws minutes` | Q2 2026 |
| Auto-read DingTalk Docs | `dws doc` | Q2 2026 |
| DingTalk Drive Access | `dws drive` | Q2 2026 |

---

## 💡 Example

### Input

```
Product Review Meeting Notes:

Zhang: We need to review the Q2 roadmap with the product team next week
Li: How about Tuesday or Wednesday afternoon?
Me: Help me schedule a meeting with the product team next week
```

### Output

```markdown
📋 Action Items (1 total)

### 🔴 Direct Commands (Wake Word Triggered)

1. Schedule product team review meeting
   Context: Zhang mentioned Q2 roadmap review, Li suggested Tue/Wed afternoon
   Plan:
   - Check availability across teams
   - Recommend 3 time slots
   - Create calendar event & book meeting room
   
   Execute now? Reply "1" or "do 1"
```

---

## 🔧 Configuration

### First-Time Setup

On first use, the skill will guide you through:

1. **User Identity** - Automatically fetches your DingTalk profile
2. **Wake Word** - Set your personal trigger word (e.g., "帮我", "Hey assistant")

### Environment Variables

```bash
export DWS_CLIENT_ID=<your-app-key>
export DWS_CLIENT_SECRET=<your-app-secret>
```

---

## 📖 Documentation

- **[中文文档](README_CN.md)** - Complete Chinese documentation
- **[Quick Start Guide](docs/QUICKSTART.md)** - 5-minute setup guide
- **[Examples](examples/)** - Sample inputs and outputs

---

## 🗺️ Roadmap

### V0.1 (Current) - Q1 2026
- ✅ Manual input mode
- ✅ Wake word detection
- ✅ Basic action extraction
- ✅ Core execution capabilities

### V1.0 (Planned) - Q2 2026
- 🔲 Automatic DingTalk Minutes integration
- 🔲 Automatic DingTalk Docs integration
- 🔲 Smart action recognition improvements
- 🔲 Multi-language support

---

## 🔐 Security

- OAuth 2.0 Device Flow authentication
- Token encryption (PBKDF2 + AES-256-GCM)
- Domain allowlisting (`*.dingtalk.com` only)
- Least privilege access control
- Full audit trail via DingTalk Open Platform

---

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup

```bash
git clone https://github.com/emersonli/dingtalk-action-items.git
cd dingtalk-action-items

# Make sure you have DingTalk CLI installed and configured
dws --version
```

---

## 📄 License

Apache License 2.0 - see [LICENSE](LICENSE) for details.

---

## 🙏 Acknowledgments

- Inspired by community implementations of meeting-to-task workflows
- Built on top of [DingTalk Workspace CLI](https://github.com/DingTalk-Real-AI/dingtalk-workspace-cli)
- Special thanks to the DingTalk DWS co-creation team

---

## 📬 Support

- **Issues**: https://github.com/emersonli/dingtalk-action-items/issues
- **Discussions**: https://github.com/emersonli/dingtalk-action-items/discussions
- **DingTalk DWS Group**: Scan QR code in [Chinese docs](README_CN.md)

---

**Made with ❤️ for the DingTalk community**
