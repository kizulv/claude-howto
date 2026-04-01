<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Danh mục tính năng Claude Code

> Hướng dẫn tham khảo nhanh cho tất cả các tính năng của Claude Code: câu lệnh (commands), agents, skills, plugins và hooks.

**Điều hướng**: [Commands](#slash-commands) | [Permission Modes](#permission-modes) | [Subagents](#subagents) | [Skills](#skills) | [Plugins](#plugins) | [MCP Servers](#mcp-servers) | [Hooks](#hooks) | [Memory](#memory-files) | [Tính năng mới](#tính-năng-mới-tháng-3-năm-2026)

---

## Tóm tắt

| Tính năng | Có sẵn | Ví dụ | Tổng cộng | Tham chiếu |
|---------|----------|----------|-------|-----------|
| **Slash Commands** | 55+ | 8 | 63+ | [01-slash-commands/](01-slash-commands/) |
| **Subagents** | 6 | 10 | 16 | [04-subagents/](04-subagents/) |
| **Skills** | 5 đi kèm | 4 | 9 | [03-skills/](03-skills/) |
| **Plugins** | - | 3 | 3 | [07-plugins/](07-plugins/) |
| **MCP Servers** | 1 | 8 | 9 | [05-mcp/](05-mcp/) |
| **Hooks** | 25 sự kiện | 7 | 7 | [06-hooks/](06-hooks/) |
| **Memory** | 7 loại | 3 | 3 | [02-memory/](02-memory/) |
| **Tổng cộng** | **99** | **43** | **117** | |

---

## Slash Commands

Commands (Câu lệnh) là các phím tắt do người dùng gọi để thực hiện các hành động cụ thể.

### Các câu lệnh có sẵn (Built-in)

| Câu lệnh | Mô tả | Khi nào sử dụng |
|---------|-------------|-------------|
| `/help` | Hiển thị thông tin trợ giúp | Bắt đầu, tìm hiểu các câu lệnh |
| `/btw` | Câu hỏi phụ không thêm vào ngữ cảnh | Các câu hỏi nhanh ngoài lề |
| `/chrome` | Cấu hình tích hợp Chrome | Tự động hóa trình duyệt |
| `/clear` | Xóa lịch sử trò chuyện | Bắt đầu mới, giảm bớt ngữ cảnh |
| `/diff` | Trình xem diff tương tác | Xem lại các thay đổi |
| `/config` | Xem/sửa cấu hình | Tùy chỉnh hành vi |
| `/status` | Hiển thị trạng thái phiên làm việc | Kiểm tra trạng thái hiện tại |
| `/agents` | Liệt kê các agents khả dụng | Xem các tùy chọn ủy quyền |
| `/skills` | Liệt kê các skills khả dụng | Xem các khả năng tự động gọi |
| `/hooks` | Liệt kê các hooks đã cấu hình | Gỡ lỗi tự động hóa |
| `/insights` | Phân tích các mẫu phiên làm việc | Tối ưu hóa phiên làm việc |
| `/install-slack-app` | Cài đặt ứng dụng Claude Slack | Tích hợp Slack |
| `/keybindings` | Tùy chỉnh phím tắt bàn phím | Tùy chỉnh phím |
| `/mcp` | Liệt kê các máy chủ MCP | Kiểm tra các tích hợp bên ngoài |
| `/memory` | Xem các tệp bộ nhớ đã tải | Gỡ lỗi tải ngữ cảnh |
| `/mobile` | Tạo mã QR cho di động | Truy cập trên di động |
| `/passes` | Xem các lượt sử dụng (passes) | Thông tin đăng ký gói |
| `/plugin` | Quản lý plugins | Cài đặt/xóa các tiện ích mở rộng |
| `/plan` | Vào chế độ lập kế hoạch | Triển khai các tác vụ phức tạp |
| `/rewind` | Quay lại checkpoint trước đó | Hoàn tác thay đổi, thử hướng khác |
| `/checkpoint` | Quản lý các checkpoints | Lưu/khôi phục các trạng thái |
| `/cost` | Hiển thị chi phí sử dụng token | Giám sát chi tiêu |
| `/context` | Hiển thị mức sử dụng context window | Quản lý độ dài cuộc hội thoại |
| `/export` | Xuất cuộc hội thoại | Lưu lại để tham khảo |
| `/extra-usage` | Cấu hình giới hạn sử dụng thêm | Quản lý giới hạn tốc độ (rate limit) |
| `/feedback` | Gửi phản hồi hoặc báo lỗi | Báo cáo các vấn đề |
| `/login` | Xác thực với Anthropic | Truy cập các tính năng |
| `/logout` | Đăng xuất | Chuyển đổi tài khoản |
| `/sandbox` | Bật/tắt chế độ sandbox | Thực thi câu lệnh an toàn |
| `/vim` | Bật/tắt chế độ vim | Chỉnh sửa theo kiểu Vim |
| `/doctor` | Chạy chẩn đoán hệ thống | Khắc phục sự cố |
| `/reload-plugins` | Tải lại các plugins đã cài đặt | Quản lý plugin |
| `/release-notes` | Hiển thị ghi chú phát hành | Kiểm tra các tính năng mới |
| `/remote-control` | Bật điều khiển từ xa | Truy cập từ xa |
| `/permissions` | Quản lý quyền truy cập | Kiểm soát quyền |
| `/session` | Quản lý các phiên làm việc | Quy trình làm việc đa phiên |
| `/rename` | Đổi tên phiên hiện tại | Sắp xếp các phiên làm việc |
| `/resume` | Tiếp tục phiên trước đó | Tiếp tục công việc |
| `/todo` | Xem/quản lý danh sách việc cần làm | Theo dõi nhiệm vụ |
| `/tasks` | Xem các tác vụ nền | Giám sát các hoạt động bất đồng bộ |
| `/copy` | Sao chép câu trả lời cuối vào clipboard | Chia sẻ nhanh kết quả |
| `/teleport` | Chuyển phiên sang máy khác | Tiếp tục công việc từ xa |
| `/desktop` | Mở ứng dụng Claude Desktop | Chuyển sang giao diện máy tính |
| `/theme` | Thay đổi chủ đề màu sắc | Tùy chỉnh giao diện |
| `/usage` | Hiển thị thống kê sử dụng API | Giám sát hạn ngạch và chi phí |
| `/fork` | Nhánh cuộc hội thoại hiện tại | Khám phá các hướng thay thế |
| `/stats` | Hiển thị thống kê phiên | Xem lại các chỉ số phiên |
| `/statusline` | Cấu hình dòng trạng thái | Tùy chỉnh hiển thị trạng thái |
| `/stickers` | Xem các nhãn dán phiên | Phần thưởng thú vị |
| `/fast` | Bật/tắt chế độ phản hồi nhanh | Tốc độ phản hồi |
| `/terminal-setup` | Cấu hình tích hợp terminal | Thiết lập các tính năng terminal |
| `/upgrade` | Kiểm tra cập nhật | Quản lý phiên bản |

### Các câu lệnh tùy chỉnh (Custom Commands - Ví dụ)

| Câu lệnh | Mô tả | Khi nào sử dụng | Phạm vi | Cài đặt |
|---------|-------------|-------------|-------|--------------|
| `/optimize` | Phân tích mã để tối ưu hóa | Cải thiện hiệu suất | Dự án | `cp 01-slash-commands/optimize.md .claude/commands/` |
| `/pr` | Chuẩn bị pull request | Trước khi gửi PR | Dự án | `cp 01-slash-commands/pr.md .claude/commands/` |
| `/generate-api-docs` | Tạo tài liệu API | Viết tài liệu cho API | Dự án | `cp 01-slash-commands/generate-api-docs.md .claude/commands/` |
| `/commit` | Tạo git commit kèm ngữ cảnh | Lưu các thay đổi | Người dùng | `cp 01-slash-commands/commit.md .claude/commands/` |
| `/push-all` | Stage, commit, và push | Triển khai nhanh | Người dùng | `cp 01-slash-commands/push-all.md .claude/commands/` |
| `/doc-refactor` | Tái cấu trúc tài liệu | Cải thiện tài liệu | Dự án | `cp 01-slash-commands/doc-refactor.md .claude/commands/` |
| `/setup-ci-cd` | Thiết lập pipeline CI/CD | Các dự án mới | Dự án | `cp 01-slash-commands/setup-ci-cd.md .claude/commands/` |
| `/unit-test-expand` | Mở rộng độ bao phủ kiểm thử | Cải thiện testing | Dự án | `cp 01-slash-commands/unit-test-expand.md .claude/commands/` |

> **Phạm vi (Scope)**: `User` = quy trình cá nhân (`~/.claude/commands/`), `Project` = chia sẻ với nhóm (`.claude/commands/`)

**Tham chiếu**: [01-slash-commands/](01-slash-commands/) | [Tài liệu chính thức](https://code.claude.com/docs/en/interactive-mode)

**Cài đặt nhanh (Tất cả câu lệnh tùy chỉnh)**:
```bash
cp 01-slash-commands/*.md .claude/commands/
```

---

## Permission Modes (Chế độ quyền)

Claude Code hỗ trợ 6 chế độ quyền để kiểm soát cách cho phép sử dụng công cụ.

| Chế độ | Mô tả | Khi nào sử dụng |
|------|-------------|-------------|
| `default` | Hỏi ý kiến cho mỗi lần gọi công cụ | Sử dụng tương tác tiêu chuẩn |
| `acceptEdits` | Tự động chấp nhận sửa tệp, hỏi các thứ khác | Quy trình chỉnh sửa tin cậy |
| `plan` | Chỉ dùng các công cụ đọc, không ghi | Lập kế hoạch và khám phá |
| `auto` | Chấp nhận tất cả công cụ không cần hỏi | Vận hành hoàn toàn tự trị (Bản xem trước) |
| `bypassPermissions` | Bỏ qua tất cả các kiểm tra quyền | CI/CD, môi trường headless |
| `dontAsk` | Bỏ qua các công cụ yêu cầu quyền | Scripting không tương tác |

> **Lưu ý**: Chế độ `auto` là tính năng Bản xem trước Nghiên cứu (tháng 3/2026). Chỉ sử dụng `bypassPermissions` trong môi trường tin cậy và sandbox.

**Tham chiếu**: [Tài liệu chính thức](https://code.claude.com/docs/en/permissions)

---

## Subagents

Các trợ lý AI chuyên biệt với ngữ cảnh riêng biệt cho các tác vụ cụ thể.

### Các Subagents có sẵn

| Agent | Mô tả | Công cụ | Model | Khi nào sử dụng |
|-------|-------------|-------|-------|-------------|
| **general-purpose** | Tác vụ nhiều bước, nghiên cứu | Tất cả công cụ | Kế thừa model | Nghiên cứu phức tạp, tác vụ đa tệp |
| **Plan** | Lập kế hoạch triển khai | Read, Glob, Grep, Bash | Kế thừa model | Thiết kế kiến trúc, lên kế hoạch |
| **Explore** | Khám phá mã nguồn | Read, Glob, Grep | Haiku 4.5 | Tìm kiếm nhanh, tìm hiểu mã |
| **Bash** | Thực thi câu lệnh | Bash | Kế thừa model | Thao tác Git, tác vụ terminal |
| **statusline-setup** | Cấu hình dòng trạng thái | Bash, Read, Write | Sonnet 4.6 | Thiết lập hiển thị dòng trạng thái |
| **Claude Code Guide** | Trợ giúp và tài liệu | Read, Glob, Grep | Haiku 4.5 | Nhận trợ giúp, tìm hiểu tính năng |

### Các trường cấu hình Subagent

| Trường | Kiểu | Mô tả |
|-------|------|-------------|
| `name` | string | Định danh Agent |
| `description` | string | Agent này làm gì |
| `model` | string | Ghi đè Model (ví dụ: `haiku-4.5`) |
| `tools` | array | Danh sách công cụ được phép |
| `effort` | string | Mức độ nỗ lực suy luận (`low`, `medium`, `high`) |
| `initialPrompt` | string | Prompt hệ thống được tiêm khi agent bắt đầu |
| `disallowedTools` | array | Các công cụ bị cấm rõ ràng đối với agent này |

### Các Subagents tùy chỉnh (Ví dụ)

| Agent | Mô tả | Khi nào sử dụng | Phạm vi | Cài đặt |
|-------|-------------|-------------|-------|--------------|
| `code-reviewer` | Chất lượng mã toàn diện | Các phiên review code | Dự án | `cp 04-subagents/code-reviewer.md .claude/agents/` |
| `code-architect` | Thiết kế kiến trúc tính năng | Lập kế hoạch tính năng mới | Dự án | `cp 04-subagents/code-architect.md .claude/agents/` |
| `code-explorer` | Phân tích sâu mã nguồn | Hiểu các tính năng hiện có | Dự án | `cp 04-subagents/code-explorer.md .claude/agents/` |
| `clean-code-reviewer` | Review theo nguyên tắc Clean Code | Review tính bảo trì | Dự án | `cp 04-subagents/clean-code-reviewer.md .claude/agents/` |
| `test-engineer` | Chiến lược & độ bao phủ kiểm thử | Lập kế hoạch kiểm thử | Dự án | `cp 04-subagents/test-engineer.md .claude/agents/` |
| `documentation-writer` | Tài liệu kỹ thuật | Doc API, hướng dẫn | Dự án | `cp 04-subagents/documentation-writer.md .claude/agents/` |
| `secure-reviewer` | Review tập trung bảo mật | Kiểm tra bảo mật | Dự án | `cp 04-subagents/secure-reviewer.md .claude/agents/` |
| `implementation-agent` | Triển khai tính năng đầy đủ | Phát triển tính năng | Dự án | `cp 04-subagents/implementation-agent.md .claude/agents/` |
| `debugger` | Phân tích nguyên nhân gốc rễ | Điều tra lỗi | Người dùng | `cp 04-subagents/debugger.md .claude/agents/` |
| `data-scientist` | Truy vấn SQL, phân tích dữ liệu | Tác vụ dữ liệu | Người dùng | `cp 04-subagents/data-scientist.md .claude/agents/` |

**Tham chiếu**: [04-subagents/](04-subagents/) | [Tài liệu chính thức](https://code.claude.com/docs/en/sub-agents)

**Cài đặt nhanh (Tất cả Agents tùy chỉnh)**:
```bash
cp 04-subagents/*.md .claude/agents/
```

---

## Skills

Các khả năng tự động gọi kèm theo hướng dẫn, script và mẫu.

### Các Skills ví dụ

| Skill | Mô tả | Khi nào tự động gọi | Phạm vi | Cài đặt |
|-------|-------------|-------------------|-------|--------------|
| `code-review` | Review code toàn diện | "Review đoạn code này", "Kiểm tra chất lượng" | Dự án | `cp -r 03-skills/code-review .claude/skills/` |
| `brand-voice` | Kiểm tra tính nhất quán thương hiệu | Khi viết nội dung marketing | Dự án | `cp -r 03-skills/brand-voice .claude/skills/` |
| `doc-generator` | Trình tạo tài liệu API | "Tạo doc", "Viết tài liệu cho API" | Dự án | `cp -r 03-skills/doc-generator .claude/skills/` |
| `refactor` | Tái cấu trúc mã hệ thống | "Refactor đoạn này", "Dọn dẹp mã" | Người dùng | `cp -r 03-skills/refactor ~/.claude/skills/` |

### Cấu trúc Skill

```
~/.claude/skills/skill-name/
├── SKILL.md          # Định nghĩa Skill & hướng dẫn
├── scripts/          # Các script hỗ trợ
└── templates/        # Các mẫu đầu ra
```

### Các trường Skill Frontmatter

Các Skill hỗ trợ YAML frontmatter trong `SKILL.md` để cấu hình:

| Trường | Kiểu | Mô tả |
|-------|------|-------------|
| `name` | string | Tên hiển thị của Skill |
| `description` | string | Skill này làm gì |
| `autoInvoke` | array | Các cụm từ kích hoạt tự động gọi |
| `effort` | string | Mức độ nỗ lực suy luận (`low`, `medium`, `high`) |
| `shell` | string | Shell sử dụng cho script (`bash`, `zsh`, `sh`) |

**Tham chiếu**: [03-skills/](03-skills/) | [Tài liệu chính thức](https://code.claude.com/docs/en/skills)

**Cài đặt nhanh (Tất cả Skills)**:
```bash
cp -r 03-skills/* ~/.claude/skills/
```

### Các Skills đi kèm (Bundled)

| Skill | Mô tả | Khi nào tự động gọi |
|-------|-------------|-------------------|
| `/simplify` | Review mã nguồn về chất lượng | Sau khi viết mã |
| `/batch` | Chạy prompt trên nhiều tệp | Các tác vụ hàng loạt |
| `/debug` | Gỡ lỗi các kiểm thử/lỗi thất bại | Các phiên gỡ lỗi |
| `/loop` | Chạy prompt theo khoảng thời gian | Các tác vụ lặp lại |
| `/claude-api` | Xây dựng ứng dụng với Claude API | Phát triển API |

---

## Plugins

Các bộ sưu tập câu lệnh, agents, máy chủ MCP và hooks đi kèm.

### Các Plugins ví dụ

| Plugin | Mô tả | Thành phần | Khi nào sử dụng | Phạm vi | Cài đặt |
|--------|-------------|------------|-------------|-------|--------------|
| `pr-review` | Quy trình review PR | 3 lệnh, 3 agents, GitHub MCP | Review code | Dự án | `/plugin install pr-review` |
| `devops-automation` | Triển khai & giám sát | 4 lệnh, 3 agents, K8s MCP | Tác vụ DevOps | Dự án | `/plugin install devops-automation` |
| `documentation` | Bộ công cụ tạo tài liệu | 4 lệnh, 3 agents, templates | Tài liệu | Dự án | `/plugin install documentation` |

### Cấu trúc Plugin

```
.claude-plugin/
├── plugin.json       # Tệp manifest
├── commands/         # Slash commands
├── agents/           # Subagents
├── skills/           # Skills
├── mcp/              # Cấu hình MCP
├── hooks/            # Các script Hook
└── scripts/          # Các script tiện ích
```

**Tham chiếu**: [07-plugins/](07-plugins/) | [Tài liệu chính thức](https://code.claude.com/docs/en/plugins)

**Các lệnh quản lý Plugin**:
```bash
/plugin list              # Liệt kê các plugin đã cài
/plugin install <name>    # Cài đặt plugin
/plugin remove <name>     # Xóa plugin
/plugin update <name>     # Cập nhật plugin
```

---

## MCP Servers

Các máy chủ Model Context Protocol để truy cập công cụ và API bên ngoài.

### Các máy chủ MCP phổ biến

| Máy chủ | Mô tả | Khi nào sử dụng | Phạm vi | Cài đặt |
|--------|-------------|-------------|-------|--------------|
| **GitHub** | Quản lý PR, issues, code | Quy trình GitHub | Dự án | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |
| **Database** | Truy vấn SQL, truy cập dữ liệu | Thao tác cơ sở dữ liệu | Dự án | `claude mcp add db -- npx -y @modelcontextprotocol/server-postgres` |
| **Filesystem** | Thao tác tệp nâng cao | Các tác vụ tệp phức tạp | Người dùng | `claude mcp add fs -- npx -y @modelcontextprotocol/server-filesystem` |
| **Slack** | Giao tiếp nhóm | Thông báo, cập nhật | Dự án | Cấu hình trong cài đặt |
| **Google Docs** | Truy cập tài liệu | Sửa, review tài liệu | Dự án | Cấu hình trong cài đặt |
| **Asana** | Quản lý dự án | Theo dõi nhiệm vụ | Dự án | Cấu hình trong cài đặt |
| **Stripe** | Dữ liệu thanh toán | Phân tích tài chính | Dự án | Cấu hình trong cài đặt |
| **Memory** | Bộ nhớ bền vững | Gợi nhớ xuyên suốt các phiên | Người dùng | Cấu hình trong cài đặt |
| **Context7** | Tài liệu thư viện | Tra cứu tài liệu mới nhất | Có sẵn | Có sẵn |

**Tham chiếu**: [05-mcp/](05-mcp/) | [Tài liệu MCP Protocol](https://modelcontextprotocol.io)

---

## Hooks

Tự động hóa dựa trên sự kiện thực thi các lệnh shell khi có sự kiện trong Claude Code.

### Các sự kiện Hook

| Sự kiện | Mô tả | Khi nào kích hoạt | Tình huống sử dụng |
|-------|-------------|----------------|-----------|
| `SessionStart` | Phiên bắt đầu/tiếp tục | Khởi tạo phiên | Các tác vụ thiết lập |
| `InstructionsLoaded` | Hướng dẫn đã tải | Tải CLAUDE.md hoặc tệp quy tắc | Xử lý hướng dẫn tùy chỉnh |
| `UserPromptSubmit` | Trước khi xử lý prompt | Người dùng gửi thông điệp | Xác thực đầu vào |
| `PreToolUse` | Trước khi thực thi công cụ | Trước khi bất kỳ công cụ nào chạy | Xác thực, ghi nhật ký |
| `PermissionRequest` | Hộp thoại yêu cầu quyền xuất hiện | Trước các hành động nhạy cảm | Quy trình phê duyệt tùy chỉnh |
| `PostToolUse` | Sau khi công cụ thành công | Sau khi công cụ hoàn thành | Định dạng, thông báo |
| `PostToolUseFailure` | Thực thi công cụ thất bại | Sau khi có lỗi công cụ | Xử lý lỗi, ghi nhật ký |
| `Notification` | Thông báo được gửi | Claude gửi thông báo | Cảnh báo bên ngoài |
| `SubagentStart` | Subagent được sinh ra | Tác vụ subagent bắt đầu | Khởi tạo ngữ cảnh subagent |
| `SubagentStop` | Subagent kết thúc | Tác vụ subagent hoàn thành | Chuỗi các hành động |
| `Stop` | Claude kết thúc phản hồi | Phản hồi hoàn tất | Dọn dẹp, báo cáo |
| `StopFailure` | Lỗi API kết thúc lượt | Xảy ra lỗi API | Khôi phục lỗi, ghi nhật ký |
| `TeammateIdle` | Agent đồng đội nhàn rỗi | Điều phối nhóm agent | Phân chia công việc |
| `TaskCompleted` | Tác vụ được đánh dấu hoàn thành | Nhiệm vụ đã xong | Xử lý sau tác vụ |
| `TaskCreated` | Tác vụ được tạo qua TaskCreate | Tác vụ mới được tạo | Theo dõi tác vụ, ghi nhật ký |
| `ConfigChange` | Cấu hình được cập nhật | Cài đặt bị thay đổi | Phản ứng với thay đổi cấu hình |
| `CwdChanged` | Thư mục làm việc thay đổi | Thư mục bị thay đổi | Thiết lập riêng cho thư mục |
| `FileChanged` | Tệp đang theo dõi thay đổi | Tệp bị sửa đổi | Theo dõi tệp, build lại |
| `PreCompact` | Trước khi nén ngữ cảnh | Nén ngữ cảnh hội thoại | Bảo toàn trạng thái |
| `PostCompact` | Sau khi nén xong | Nén hoàn tất | Các hành động sau nén |
| `WorktreeCreate` | Đang tạo worktree | Worktree Git được tạo | Thiết lập môi trường worktree |
| `WorktreeRemove` | Đang xóa worktree | Worktree Git bị xóa | Dọn dẹp tài nguyên worktree |
| `Elicitation` | Máy chủ MCP yêu cầu đầu vào | MCP elicitation | Xác thực đầu vào |
| `ElicitationResult` | Người dùng phản hồi elicitation | Người dùng phản hồi | Xử lý phản hồi |
| `SessionEnd` | Kết thúc phiên làm việc | Phiên bị đóng | Dọn dẹp, lưu trạng thái |

**Tham chiếu**: [06-hooks/](06-hooks/) | [Tài liệu chính thức](https://code.claude.com/docs/en/hooks)

**Cài đặt nhanh (Tất cả Hooks)**:
```bash
mkdir -p ~/.claude/hooks && cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh
```

---

## Memory Files (Tệp bộ nhớ)

Ngữ cảnh bền vững được tải tự động xuyên suốt các phiên làm việc.

### Các loại bộ nhớ

| Loại | Vị trí | Phạm vi | Khi nào sử dụng |
|------|----------|-------|-------------|
| **Managed Policy** | Chính sách do tổ chức quản lý | Tổ chức | Áp đặt tiêu chuẩn toàn tổ chức |
| **Project** | `./CLAUDE.md` | Dự án (nhóm) | Tiêu chuẩn nhóm, ngữ cảnh dự án |
| **Project Rules** | `.claude/rules/` | Dự án (nhóm) | Các quy tắc dự án theo module |
| **User** | `~/.claude/CLAUDE.md` | Người dùng | Tùy chỉnh cá nhân |
| **User Rules** | `~/.claude/rules/` | Người dùng | Các quy tắc cá nhân theo module |
| **Auto Memory** | Tự động | Phiên | Tự động ghi lại các hiểu biết và sửa lỗi |

**Tham chiếu**: [02-memory/](02-memory/) | [Tài liệu chính thức](https://code.claude.com/docs/en/memory)

---

## Tính năng mới (Tháng 3/2026)

| Tính năng | Mô tả | Cách sử dụng |
|---------|-------------|------------|
| **Remote Control** | Điều khiển phiên Claude Code từ xa qua API | Sử dụng API remote control để gửi prompt và nhận phản hồi lập trình |
| **Web Sessions** | Chạy Claude Code trên trình duyệt | Truy cập qua `claude web` hoặc qua Anthropic Console |
| **Desktop App** | Ứng dụng máy tính cho Claude Code | Sử dụng `/desktop` hoặc tải từ trang web Anthropic |
| **Agent Teams** | Điều phối nhiều agent làm các tác vụ liên quan | Cấu hình các teammate agents cộng tác và chia sẻ ngữ cảnh |
| **Task List** | Quản lý và giám sát tác vụ nền | Sử dụng `/tasks` để xem và quản lý các hoạt động nền |
| **Git Worktrees** | Các worktree git cô lập để phát triển song song | Sử dụng lệnh worktree để làm việc trên nhiều nhánh an toàn |
| **Sandboxing** | Môi trường thực thi cô lập để đảm bảo an toàn | Sử dụng `/sandbox` để bật; chạy lệnh trong môi trường hạn chế |
| **Auto Mode** | Vận hành tự trị hoàn toàn (Bản xem trước) | Sử dụng `--mode auto` hoặc `/permissions auto` |

---

## Ma trận tham chiếu nhanh

### Hướng dẫn chọn tính năng

| Cần | Tính năng đề xuất | Tại sao |
|------|---------------------|-----|
| Phím tắt nhanh | Slash Command | Thủ công, tức thì |
| Ngữ cảnh bền vững | Memory | Tự động tải |
| Tự động hóa phức tạp | Skill | Tự động gọi |
| Tác vụ chuyên biệt | Subagent | Ngữ cảnh cô lập |
| Dữ liệu bên ngoài | MCP Server | Truy cập thời gian thực |
| Tự động hóa sự kiện | Hook | Kích hoạt theo sự kiện |
| Giải pháp hoàn chỉnh | Plugin | Gói tất cả trong một |

### Thứ tự ưu tiên cài đặt

| Ưu tiên | Tính năng | Câu lệnh |
|----------|---------|---------|
| 1. Thiết yếu | Memory | `cp 02-memory/project-CLAUDE.md ./CLAUDE.md` |
| 2. Hàng ngày | Slash Commands | `cp 01-slash-commands/*.md .claude/commands/` |
| 3. Chất lượng | Subagents | `cp 04-subagents/*.md .claude/agents/` |
| 4. Tự động hóa | Hooks | `cp 06-hooks/*.sh ~/.claude/hooks/ && chmod +x ~/.claude/hooks/*.sh` |
| 5. Bên ngoài | MCP | `claude mcp add github -- npx -y @modelcontextprotocol/server-github` |

---

## Cài đặt đầy đủ chỉ với một lệnh

Cài đặt tất cả các ví dụ từ kho lưu trữ này:

```bash
# Tạo các thư mục
mkdir -p .claude/{commands,agents,skills} ~/.claude/{hooks,skills}

# Cài đặt tất cả tính năng
cp 01-slash-commands/*.md .claude/commands/ && \
cp 02-memory/project-CLAUDE.md ./CLAUDE.md && \
cp -r 03-skills/* ~/.claude/skills/ && \
cp 04-subagents/*.md .claude/agents/ && \
cp 06-hooks/*.sh ~/.claude/hooks/ && \
chmod +x ~/.claude/hooks/*.sh
```

---

## Tài nguyên bổ sung

- [Tài liệu chính thức Claude Code](https://code.claude.com/docs/en/overview)
- [Lộ trình học tập](LEARNING-ROADMAP.md)
- [README chính](README.md)

---

**Cập nhật cuối**: Tháng 3 năm 2026
