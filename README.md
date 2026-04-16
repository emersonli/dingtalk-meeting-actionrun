# DingTalk Meeting ActionRun

[![Version](https://img.shields.io/badge/version-1.0.0-blue)](https://github.com/emersonli/dingtalk-meeting-actionrun/releases)
[![DingTalk CLI](https://img.shields.io/badge/dws-v0.2.14+-green)](https://github.com/DingTalk-Real-AI/dingtalk-workspace-cli)
[![License](https://img.shields.io/badge/License-Apache_2.0-blue)](LICENSE)

**Automatically extract and execute action items from your meetings.**

An intelligent agent skill for DingTalk Workspace CLI that transforms meeting discussions into executable tasks and gets things done on your behalf.

---

## 🎯 What It Does

Instead of just listing TODOs, this skill actually **executes** them for you:

- "Send this to the team" → Drafts and sends the message via `dws chat`
- "Schedule a follow-up" → Finds available time slots and creates the event
- "Try this new tool" → Researches and shares installation instructions
- "Assign this task to XX" → Creates and assigns the TODO item
- "Review this document" → Fetches, reads, and summarizes via `dws doc`
- "Get meeting notes" → Auto-fetches DingTalk Minutes via `dws minutes`

**All actions require your confirmation before execution.**

---

## ⚡ Quick Start

### Prerequisites

1. **Install DingTalk CLI** (v0.2.14+)

```bash
# macOS / Linux
curl -fsSL https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.sh | sh

# Windows (PowerShell)
irm https://raw.githubusercontent.com/DingTalk-Real-AI/dingtalk-workspace-cli/main/scripts/install.ps1 | iex
```

Verify installation:
```bash
dws --version
```

2. **Setup & Authentication**

```bash
dws auth login
```

Follow the [Chinese quick start guide](docs/USAGE.md) for detailed setup instructions in Chinese.

### Installation

```bash
# Clone this repository
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun

# Or download the skill file directly
mkdir -p ~/.agents/skills/dingtalk-meeting-actionrun
curl -fsSL https://raw.githubusercontent.com/emersonli/dingtalk-meeting-actionrun/main/action-items.md \
  -o ~/.agents/skills/dingtalk-meeting-actionrun/action-items.md
```

### Usage

**V1.0 Mode (Automated)**

The skill now supports automatic fetching of DingTalk Minutes:

1. **Provide Meeting Content**

   Option A: Provide DingTalk Minutes URL (Recommended)
   ```
   Help me process this meeting minutes:
   https://shanji.dingtalk.com/minutes/xxx-xxx-xxx
   ```

   Option B: Manual input (Fallback)
   ```
   Help me process this meeting record:
   
   Zhang: We need to review the Q2 roadmap next week
   Li: How about Tuesday or Wednesday afternoon?
   Me: Help me schedule a meeting with the product team
   ```

2. **Trigger the Skill**

   In your AI Agent (Claude Code, Cursor, etc.):
   ```
   /action-items
   ```

3. **Review & Confirm** - The agent will extract all action items and wait for your confirmation

4. **Execute** - Reply with item numbers to execute, e.g., "do 1 3 5"

---

## 📋 Features

### Available in V1.0 ✅

| Feature | Status | Description |
|---------|--------|-------------|
| Auto-fetch DingTalk Minutes | ✅ | `dws minutes list/summary/transcript` |
| Auto-read DingTalk Docs | ✅ | `dws doc read` |
| DingTalk Drive Access | ✅ | `dws drive download` |
| Wake Word Detection | ✅ | Scan for personal commands |
| Action Item Extraction | ✅ | Extract explicit & implicit tasks |
| Send Messages | ✅ | Send via `dws chat message send` |
| Schedule Meetings | ✅ | Check availability & create events |
| Create Tasks | ✅ | Assign TODOs to executors |
| Search Contacts | ✅ | Find users by name/department |
| Web Research | ✅ | WebSearch/WebFetch integration |

### Planned for V2.0 🔮

| Feature | Description |
|---------|-------------|
| Multi-language Support | English, Japanese, etc. |
| Smart Action Recognition | Learn from historical data |
| Cross-meeting Task Tracking | Link related tasks across meetings |
| Auto-generate Meeting Summary | Create summary documents automatically |

---

## 💡 Example

### Input

```
Help me process this meeting minutes:
https://shanji.dingtalk.com/minutes/abc-123-def
```

### Output

```markdown
📋 Action Items (3 total)

### 🔴 Direct Commands (Wake Word Triggered)

【1】Schedule product team review meeting
    Context: Zhang mentioned Q2 roadmap review, Li suggested Tue/Wed afternoon
    Plan:
    - Check availability across teams
    - Recommend 3 time slots
    - Create calendar event & book meeting room
    
    Execute now? Reply "1" or "do 1"

### 🟡 Explicit Tasks

【2】Send requirements document to tech team
    Context: Wang reminded to send the document
    Plan: Draft message → Send via dws chat
    
    Execute now? Reply "2" or "do 2"

### 🔵 Implicit Tasks

【3】Track test plan progress
    Context: Zhao said complete by April 15
    Plan: Create TODO task → Set deadline
    
    Execute now? Reply "3" or "do 3"
```

---

## 🔧 Configuration

### First-Time Setup

On first use, the skill will guide you through:

1. **User Identity** - Automatically fetches your DingTalk profile via `dws contact user get-self`
2. **Wake Word** - Set your personal trigger word (e.g., "帮我", "Hey assistant")

### Environment Variables

```bash
export DWS_CLIENT_ID=<your-app-key>
export DWS_CLIENT_SECRET=<your-app-secret>
```

---

## 📖 Documentation

- **[中文文档](docs/USAGE.md)** - Complete Chinese documentation
- **[Quick Start Guide](docs/QUICKSTART.md)** - 5-minute setup guide
- **[Examples](examples/)** - Sample inputs and outputs

---

## 🗺️ Roadmap

### V1.0 (Current) - Q2 2026
- ✅ Automatic DingTalk Minutes integration
- ✅ Automatic DingTalk Docs integration
- ✅ DingTalk Drive access
- ✅ Real message sending (not just clipboard)
- ✅ Comprehensive error handling

### V2.0 (Planned) - Q3 2026
- 🔲 Multi-language support
- 🔲 Smart action recognition improvements
- 🔲 Cross-meeting task tracking
- 🔲 Auto-generate meeting summary documents

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
git clone https://github.com/emersonli/dingtalk-meeting-actionrun.git
cd dingtalk-meeting-actionrun

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

- **Issues**: https://github.com/emersonli/dingtalk-meeting-actionrun/issues
- **Discussions**: https://github.com/emersonli/dingtalk-meeting-actionrun/discussions
- **DingTalk DWS Group**: Scan QR code in [Chinese docs](docs/USAGE.md)

---

**Made with ❤️ for the DingTalk community**
