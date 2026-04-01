<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Các ví dụ Claude Code - Thẻ tham khảo nhanh

## 🚀 Các lệnh cài đặt nhanh

### Slash Commands
```bash
# Cài đặt tất cả
cp 01-slash-commands/*.md .claude/commands/

# Cài đặt một lệnh cụ thể
cp 01-slash-commands/optimize.md .claude/commands/
```

### Memory (Bộ nhớ)
```bash
# Bộ nhớ dự án
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Bộ nhớ cá nhân
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

### Skills
```bash
# Skills cá nhân
cp -r 03-skills/code-review ~/.claude/skills/

# Skills dự án
cp -r 03-skills/code-review .claude/skills/
```

### Subagents
```bash
# Cài đặt tất cả
cp 04-subagents/*.md .claude/agents/

# Cài đặt agent cụ thể
cp 04-subagents/code-reviewer.md .claude/agents/
```

### MCP
```bash
# Thiết lập thông tin xác thực
export GITHUB_TOKEN="token_cua_ban"
export DATABASE_URL="postgresql://..."

# Cài đặt cấu hình (phạm vi dự án)
cp 05-mcp/github-mcp.json .mcp.json

# Hoặc phạm vi người dùng: thêm vào ~/.claude.json
```

### Hooks
```bash
# Cài đặt hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Cấu hình trong cài đặt (~/.claude/settings.json)
```

### Plugins
```bash
# Cài đặt từ các ví dụ (nếu đã được phát hành)
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

### Checkpoints
```bash
# Checkpoint được tạo tự động sau mỗi lần người dùng prompt
# Để quay lại, nhấn Esc hai lần hoặc dùng:
/rewind

# Sau đó chọn: Restore code and conversation, Restore conversation,
# Restore code, Summarize from here, hoặc Never mind
```

### Các tính năng nâng cao
```bash
# Cấu hình trong cài đặt (.claude/settings.json)
# Xem 09-advanced-features/config-examples.json

# Chế độ lập kế hoạch
/plan Mô tả tác vụ

# Chế độ quyền (dùng cờ --permission-mode)
# default        - Hỏi xác nhận cho các hành động rủi ro
# acceptEdits    - Tự động chấp nhận sửa tệp, hỏi các thứ khác
# plan           - Chỉ phân tích đọc, không sửa đổi
# dontAsk        - Chấp nhận tất cả hành động trừ các hành động rủi ro
# auto           - Bộ phân loại nền tự quyết định quyền
# bypassPermissions - Chấp nhận tất cả (yêu cầu --dangerously-skip-permissions)

# Quản lý phiên làm việc
/resume                # Tiếp tục một cuộc hội thoại trước đó
/rename "tên"          # Đặt tên cho phiên hiện tại
/fork                  # Nhánh phiên hiện tại
claude -c              # Tiếp tục cuộc hội thoại gần nhất
claude -r "phiên"      # Tiếp tục phiên theo tên/ID
```

---

## 📋 Bảng tra cứu tính năng

| Tính năng | Đường dẫn cài đặt | Cách dùng |
|---------|-------------|-------|
| **Slash Commands (55+)** | `.claude/commands/*.md` | `/tên-lệnh` |
| **Memory** | `./CLAUDE.md` | Tự động tải |
| **Skills** | `.claude/skills/*/SKILL.md` | Tự động gọi |
| **Subagents** | `.claude/agents/*.md` | Tự động ủy quyền |
| **MCP** | `.mcp.json` (dự án) hoặc `~/.claude.json` (user) | `/mcp__server__action` |
| **Hooks (25 sự kiện)** | `~/.claude/hooks/*.sh` | Kích hoạt theo sự kiện |
| **Plugins** | Qua `/plugin install` | Đóng gói tất cả |
| **Checkpoints** | Có sẵn | `Esc+Esc` hoặc `/rewind` |
| **Planning Mode** | Có sẵn | `/plan <tác vụ>` |
| **Chế độ quyền (6)** | Có sẵn | `--allowedTools`, `--permission-mode` |
| **Sessions** | Có sẵn | `/session <lệnh>` |
| **Tác vụ nền** | Có sẵn | Chạy trong nền |
| **Remote Control** | Có sẵn | WebSocket API |
| **Web Sessions** | Có sẵn | `claude web` |
| **Git Worktrees** | Có sẵn | `/worktree` |
| **Auto Memory** | Có sẵn | Tự lưu vào CLAUDE.md |
| **Task List** | Có sẵn | `/task list` |
| **Skills đi kèm (5)** | Có sẵn | `/simplify`, `/loop`, `/claude-api`, `/voice`, `/browse` |

---

## 🎯 Các tình huống sử dụng phổ biến

### Review mã nguồn
```bash
# Cách 1: Slash command
cp 01-slash-commands/optimize.md .claude/commands/
# Dùng: /optimize

# Cách 2: Subagent
cp 04-subagents/code-reviewer.md .claude/agents/
# Dùng: Tự động ủy quyền

# Cách 3: Skill
cp -r 03-skills/code-review ~/.claude/skills/
# Dùng: Tự động gọi

# Cách 4: Plugin (tốt nhất)
/plugin install pr-review
# Dùng: /review-pr
```

### Tài liệu hóa
```bash
# Slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# Subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# Skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# Plugin (giải pháp hoàn chỉnh)
/plugin install documentation
```

### DevOps
```bash
# Plugin hoàn chỉnh
/plugin install devops-automation

# Các lệnh: /deploy, /rollback, /status, /incident
```

---

## 📁 Tham chiếu vị trí tệp

```
Dự án của bạn/
├── .claude/
│   ├── commands/              # Slash commands đặt ở đây
│   ├── agents/                # Subagents đặt ở đây
│   ├── skills/                # Skills dự án đặt ở đây
│   └── settings.json          # Cài đặt dự án (hooks, v.v.)
├── .mcp.json                  # Cấu hình MCP (phạm vi dự án)
├── CLAUDE.md                  # Bộ nhớ dự án
└── src/
    └── api/
        └── CLAUDE.md          # Bộ nhớ riêng cho thư mục
```

---

## 🎓 Lộ trình học tập

### Ngày 1
```bash
# Đọc tổng quan
cat README.md

# Cài đặt một lệnh
cp 01-slash-commands/optimize.md .claude/commands/

# Thử nghiệm
/optimize
```

### Ngày 2-3
```bash
# Thiết lập bộ nhớ
cp 02-memory/project-CLAUDE.md ./CLAUDE.md
vim CLAUDE.md

# Cài đặt subagent
cp 04-subagents/code-reviewer.md .claude/agents/
```

### Ngày 4-5
```bash
# Thiết lập MCP
export GITHUB_TOKEN="token_cua_ban"
cp 05-mcp/github-mcp.json .mcp.json

# Thử các lệnh MCP
/mcp__github__list_prs
```

---

## Tính năng mới (Tháng 3/2026)

| Tính năng | Mô tả | Cách dùng |
|---------|-------------|-------|
| **Auto Mode** | Vận hành tự trị với bộ phân loại nền | Cờ `--enable-auto-mode`, `Shift+Tab` để chuyển chế độ |
| **Channels** | Tích hợp Discord và Telegram | Cờ `--channels`, bot Discord/Telegram |
| **Voice Dictation** | Ra lệnh bằng giọng nói | Lệnh `/voice` |
| **Remote Control** | Điều khiển qua WebSocket API | `claude --remote` cho các tích hợp ngoài |
| **Web Sessions** | Giao diện trên trình duyệt | `claude web` để khởi chạy |
| **Git Worktrees** | Không gian làm việc cô lập song song | Lệnh `/worktree` |
| **Auto Memory** | Tự động lưu bộ nhớ từ hội thoại | Tự động lưu ngữ cảnh vào CLAUDE.md |

---

## Mẹo & Thủ thuật

### Tùy chỉnh
- Bắt đầu với các ví dụ nguyên bản
- Sửa đổi cho phù hợp nhu cầu
- Kiểm tra trước khi chia sẻ với nhóm
- Quản lý phiên bản các tệp cấu hình của bạn

### Thực hành tốt nhất
- Dùng memory cho các tiêu chuẩn nhóm
- Dùng plugins cho các quy trình hoàn chỉnh
- Dùng subagents cho các tác vụ phức tạp
- Dùng slash commands cho các tác vụ nhanh

---

## ✅ Danh sách kiểm tra

Danh sách bắt đầu:

- [ ] Đọc `README.md`
- [ ] Cài đặt 1 slash command
- [ ] Thử nghiệm lệnh đó
- [ ] Tạo tệp `CLAUDE.md` dự án
- [ ] Cài đặt 1 subagent
- [ ] Thiết lập 1 tích hợp MCP
- [ ] Cài đặt 1 skill
- [ ] Thử một plugin hoàn chỉnh
- [ ] Tùy chỉnh theo nhu cầu
- [ ] Chia sẻ với nhóm

---

**Bắt đầu nhanh**: `cat README.md`
**Bản đầy đủ**: `cat INDEX.md`
**Thẻ này**: Hãy giữ nó bên mình để tham khảo nhanh!
