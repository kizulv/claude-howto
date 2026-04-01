<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Mục lục Ví dụ Claude Code - Đầy đủ

Tài liệu này cung cấp mục lục đầy đủ của tất cả các tệp ví dụ được tổ chức theo loại tính năng.

## Thống kê tóm tắt

- **Tổng số tệp**: hơn 100 tệp
- **Danh mục**: 10 danh mục tính năng
- **Plugins**: 3 plugin hoàn chỉnh
- **Skills**: 6 skill hoàn chỉnh
- **Hooks**: 8 hook ví dụ
- **Sẵn sàng sử dụng**: Tất cả các ví dụ

---

## 01. Slash Commands (10 tệp)

Các phím tắt do người dùng gọi cho các quy trình làm việc phổ biến.

| Tệp | Mô tả | Tình huống sử dụng |
|------|-------------|----------|
| `optimize.md` | Trình phân tích tối ưu hóa mã | Tìm các vấn đề hiệu suất |
| `pr.md` | Chuẩn bị Pull request | Tự động hóa quy trình PR |
| `generate-api-docs.md` | Trình tạo tài liệu API | Tạo tài liệu API |
| `commit.md` | Trợ lý thông điệp commit | Chuẩn hóa các commit |
| `setup-ci-cd.md` | Thiết lập pipeline CI/CD | Tự động hóa DevOps |
| `push-all.md` | Push tất cả thay đổi | Quy trình push nhanh |
| `unit-test-expand.md` | Mở rộng độ bao phủ unit test | Tự động hóa kiểm thử |
| `doc-refactor.md` | Tái cấu trúc tài liệu | Cải thiện tài liệu |
| `pr-slash-command.png` | Ví dụ ảnh chụp màn hình | Tham chiếu trực quan |
| `README.md` | Tài liệu hướng dẫn | Hướng dẫn thiết lập và sử dụng |

**Đường dẫn cài đặt**: `.claude/commands/`

**Sử dụng**: `/optimize`, `/pr`, `/generate-api-docs`, `/commit`, `/setup-ci-cd`, `/push-all`, `/unit-test-expand`, `/doc-refactor`

---

## 02. Memory (6 tệp)

Ngữ cảnh bền vững và các tiêu chuẩn dự án.

| Tệp | Mô tả | Phạm vi | Vị trí |
|------|-------------|-------|----------|
| `project-CLAUDE.md` | Tiêu chuẩn dự án nhóm | Toàn dự án | `./CLAUDE.md` |
| `directory-api-CLAUDE.md` | Quy tắc riêng cho API | Thư mục | `./src/api/CLAUDE.md` |
| `personal-CLAUDE.md` | Tùy chỉnh cá nhân | Người dùng | `~/.claude/CLAUDE.md` |
| `memory-saved.png` | Ảnh chụp: đã lưu bộ nhớ | - | Tham chiếu trực quan |
| `memory-ask-claude.png` | Ảnh chụp: hỏi Claude | - | Tham chiếu trực quan |
| `README.md` | Tài liệu hướng dẫn | - | Tham chiếu |

**Cài đặt**: Copy vào vị trí tương ứng

**Sử dụng**: Được Claude tự động tải

---

## 03. Skills (28 tệp)

Các khả năng tự động gọi kèm theo script và mẫu.

### Code Review Skill (5 tệp)
```
code-review/
├── SKILL.md                          # Định nghĩa Skill
├── scripts/
│   ├── analyze-metrics.py            # Trình phân tích chỉ số mã
│   └── compare-complexity.py         # So sánh độ phức tạp
└── templates/
    ├── review-checklist.md           # Danh sách kiểm tra review
    └── finding-template.md           # Tài liệu phát hiện
```

**Mục đích**: Review code toàn diện với phân tích bảo mật, hiệu suất và chất lượng.

**Tự động gọi**: Khi thực hiện review code.

---

### Brand Voice Skill (4 tệp)
```
brand-voice/
├── SKILL.md                          # Định nghĩa Skill
├── templates/
│   ├── email-template.txt            # Định dạng email
│   └── social-post-template.txt      # Định dạng bài đăng mạng xã hội
└── tone-examples.md                  # Các thông điệp ví dụ
```

**Mục đích**: Đảm bảo giọng văn thương hiệu nhất quán trong giao tiếp.

**Tự động gọi**: Khi tạo nội dung marketing.

---

### Documentation Generator Skill (2 tệp)
```
doc-generator/
├── SKILL.md                          # Định nghĩa Skill
└── generate-docs.py                  # Trình trích xuất doc Python
```

**Mục đích**: Tạo tài liệu API toàn diện từ mã nguồn.

**Tự động gọi**: Khi tạo/cập nhật tài liệu API.

---

### Refactor Skill (5 tệp)
```
refactor/
├── SKILL.md                          # Định nghĩa Skill
├── scripts/
│   ├── analyze-complexity.py         # Trình phân tích độ phức tạp
│   └── detect-smells.py              # Trình phát hiện code smell
├── references/
│   ├── code-smells.md                # Danh mục code smells
│   └── refactoring-catalog.md        # Các mẫu refactoring
└── templates/
    └── refactoring-plan.md           # Mẫu kế hoạch refactoring
```

**Mục đích**: Tái cấu trúc mã hệ thống với phân tích độ phức tạp.

**Tự động gọi**: Khi thực hiện refactor mã.

---

### Claude MD Skill (1 tệp)
```
claude-md/
└── SKILL.md                          # Định nghĩa Skill
```

**Mục đích**: Quản lý và tối ưu hóa các tệp CLAUDE.md.

---

### Blog Draft Skill (3 tệp)
```
blog-draft/
├── SKILL.md                          # Định nghĩa Skill
└── templates/
    ├── draft-template.md             # Mẫu bản thảo blog
    └── outline-template.md           # Mẫu dàn ý blog
```

**Mục đích**: Soạn thảo các bài đăng blog với cấu trúc nhất quán.

**Ngoài ra**: `README.md` - Tổng quan về Skills và hướng dẫn sử dụng.

**Đường dẫn cài đặt**: `~/.claude/skills/` hoặc `.claude/skills/`

---

## 04. Subagents (9 tệp)

Các trợ lý AI chuyên biệt với các khả năng tùy chỉnh.

| Tệp | Mô tả | Công cụ | Tình huống sử dụng |
|------|-------------|-------|----------|
| `code-reviewer.md` | Phân tích chất lượng mã | read, grep, diff, lint_runner | Review toàn diện |
| `test-engineer.md` | Phân tích độ bao phủ kiểm thử | read, write, bash, grep | Tự động hóa kiểm thử |
| `documentation-writer.md` | Tạo tài liệu | read, write, grep | Tạo doc |
| `secure-reviewer.md` | Review bảo mật (read-only) | read, grep | Kiểm tra bảo mật |
| `implementation-agent.md` | Triển khai đầy đủ | read, write, bash, grep, edit, glob | Phát triển tính năng |
| `debugger.md` | Chuyên gia gỡ lỗi | read, bash, grep | Điều tra lỗi |
| `data-scientist.md` | Chuyên gia phân tích dữ liệu | read, write, bash | Quy trình dữ liệu |
| `clean-code-reviewer.md` | Tiêu chuẩn Clean code | read, grep | Chất lượng mã |
| `README.md` | Tài liệu hướng dẫn | - | Hướng dẫn thiết lập và sử dụng |

**Đường dẫn cài đặt**: `.claude/agents/`

**Sử dụng**: Tự động được ủy quyền bởi agent chính.

---

## 05. MCP Protocol (5 tệp)

Tích hợp các công cụ và API bên ngoài.

| Tệp | Mô tả | Tích hợp với | Tình huống sử dụng |
|------|-------------|-----------------|----------|
| `github-mcp.json` | Tích hợp GitHub | GitHub API | Quản lý PR/issue |
| `database-mcp.json` | Truy vấn cơ sở dữ liệu | PostgreSQL/MySQL | Truy vấn dữ liệu sống |
| `filesystem-mcp.json` | Thao tác hệ thống tệp | Hệ thống tệp cục bộ | Quản lý tệp |
| `multi-mcp.json` | Nhiều máy chủ | GitHub + DB + Slack | Tích hợp hoàn chỉnh |
| `README.md` | Tài liệu hướng dẫn | - | Hướng dẫn thiết lập và sử dụng |

**Đường dẫn cài đặt**: `.mcp.json` (phạm vi dự án) hoặc `~/.claude.json` (phạm vi người dùng)

**Sử dụng**: `/mcp__github__list_prs`, vv.

---

## 06. Hooks (9 tệp)

Các script tự động hóa dựa trên sự kiện được thực thi tự động.

| Tệp | Mô tả | Sự kiện | Tình huống sử dụng |
|------|-------------|-------|----------|
| `format-code.sh` | Tự động định dạng mã | PreToolUse:Write | Định dạng mã |
| `pre-commit.sh` | Chạy kiểm thử trước khi commit | PreToolUse:Bash | Tự động hóa kiểm thử |
| `security-scan.sh` | Quét bảo mật | PostToolUse:Write | Kiểm tra bảo mật |
| `log-bash.sh` | Ghi nhật ký lệnh bash | PostToolUse:Bash | Ghi nhật ký lệnh |
| `validate-prompt.sh` | Xác thực prompt | PreToolUse | Xác thực đầu vào |
| `notify-team.sh` | Gửi thông báo | Notification | Thông báo cho nhóm |
| `context-tracker.py` | Theo dõi sử dụng context window | PostToolUse | Giám sát ngữ cảnh |
| `context-tracker-tiktoken.py` | Theo dõi ngữ cảnh dựa trên token | PostToolUse | Đếm token chính xác |
| `README.md` | Tài liệu hướng dẫn | - | Hướng dẫn thiết lập và sử dụng |

**Đường dẫn cài đặt**: Cấu hình trong `~/.claude/settings.json`

**Sử dụng**: Được cấu hình trong cài đặt, thực thi tự động.

**Các loại Hook** (4 loại, 25 sự kiện):
- Tool Hooks: PreToolUse, PostToolUse, PostToolUseFailure, PermissionRequest
- Session Hooks: SessionStart, SessionEnd, Stop, StopFailure, SubagentStart, SubagentStop
- Task Hooks: UserPromptSubmit, TaskCompleted, TaskCreated, TeammateIdle
- Lifecycle Hooks: ConfigChange, CwdChanged, FileChanged, PreCompact, PostCompact, WorktreeCreate, WorktreeRemove, Notification, InstructionsLoaded, Elicitation, ElicitationResult

---

## 07. Plugins (3 plugin hoàn chỉnh, 40 tệp)

Các bộ sưu tập tính năng đi kèm.

### PR Review Plugin (10 tệp)
```
pr-review/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── review-pr.md                  # Review toàn diện
│   ├── check-security.md             # Kiểm tra bảo mật
│   └── check-tests.md                # Kiểm tra độ bao phủ kiểm thử
├── agents/
│   ├── security-reviewer.md          # Chuyên gia bảo mật
│   ├── test-checker.md               # Chuyên gia kiểm thử
│   └── performance-analyzer.md       # Chuyên gia hiệu suất
├── mcp/
│   └── github-config.json            # Tích hợp GitHub
├── hooks/
│   └── pre-review.js                 # Xác thực trước review
└── README.md                         # Tài liệu hướng dẫn plugin
```

**Tính năng**: Phân tích bảo mật, độ bao phủ kiểm thử, tác động hiệu suất.

**Câu lệnh**: `/review-pr`, `/check-security`, `/check-tests`

**Cài đặt**: `/plugin install pr-review`

---

### DevOps Automation Plugin (15 tệp)
```
devops-automation/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── deploy.md                     # Triển khai
│   ├── rollback.md                   # Quay lại (Rollback)
│   ├── status.md                     # Trạng thái hệ thống
│   └── incident.md                   # Phản ứng sự cố
├── agents/
│   ├── deployment-specialist.md      # Chuyên gia triển khai
│   ├── incident-commander.md         # Điều phối viên sự cố
│   └── alert-analyzer.md             # Phân tích cảnh báo
├── mcp/
│   └── kubernetes-config.json        # Tích hợp Kubernetes
├── hooks/
│   ├── pre-deploy.js                 # Kiểm tra trước triển khai
│   └── post-deploy.js                # Tác vụ sau triển khai
├── scripts/
│   ├── deploy.sh                     # Tự động hóa triển khai
│   ├── rollback.sh                   # Tự động hóa rollback
│   └── health-check.sh               # Kiểm tra sức khỏe hệ thống
└── README.md                         # Tài liệu hướng dẫn plugin
```

**Tính năng**: Triển khai Kubernetes, rollback, giám sát, phản ứng sự cố.

**Câu lệnh**: `/deploy`, `/rollback`, `/status`, `/incident`

**Cài đặt**: `/plugin install devops-automation`

---

### Documentation Plugin (14 tệp)
```
documentation/
├── .claude-plugin/
│   └── plugin.json                   # Plugin manifest
├── commands/
│   ├── generate-api-docs.md          # Tạo tài liệu API
│   ├── generate-readme.md            # Tạo README
│   ├── sync-docs.md                  # Đồng bộ hóa tài liệu
│   └── validate-docs.md              # Xác thực tài liệu
├── agents/
│   ├── api-documenter.md             # Chuyên gia doc API
│   ├── code-commentator.md           # Chuyên gia chú thích mã
│   └── example-generator.md          # Trình tạo ví dụ
├── mcp/
│   └── github-docs-config.json       # Tích hợp GitHub
├── templates/
│   ├── api-endpoint.md               # Mẫu endpoint API
│   ├── function-docs.md              # Mẫu doc hàm
│   └── adr-template.md               # Mẫu ADR
└── README.md                         # Tài liệu hướng dẫn plugin
```

**Tính năng**: Tài liệu API, tạo README, đồng bộ hóa và xác thực tài liệu.

**Câu lệnh**: `/generate-api-docs`, `/generate-readme`, `/sync-docs`, `/validate-docs`

**Cài đặt**: `/plugin install documentation`

**Ngoài ra**: `README.md` - Tổng quan về Plugins và hướng dẫn sử dụng.

---

## 08. Checkpoints và Rewind (2 tệp)

Lưu trạng thái hội thoại và khám phá các hướng tiếp cận khác nhau.

| Tệp | Mô tả | Nội dung |
|------|-------------|---------|
| `README.md` | Tài liệu hướng dẫn | Hướng dẫn toàn diện về checkpoint |
| `checkpoint-examples.md` | Ví dụ thực tế | Di chuyển DB, tối ưu hiệu suất, lặp lại giao diện, gỡ lỗi |

**Khái niệm chính**:
- **Checkpoint**: Ảnh chụp trạng thái hội thoại
- **Rewind**: Quay lại checkpoint trước đó
- **Branch Point**: Khám phá nhiều hướng tiếp cận

**Sử dụng**:
```
# Checkpoints được tạo tự động với mỗi prompt của người dùng
# Để quay lại: nhấn Esc hai lần hoặc sử dụng:
/rewind
# Sau đó chọn: Restore code and conversation, Restore conversation,
# Restore code, Summarize from here, hoặc Never mind
```

**Tình huống sử dụng**:
- Thử các cách triển khai khác nhau
- Khắc phục sai lầm
- Thử nghiệm an toàn
- So sánh các giải pháp
- A/B testing

---

## 09. Advanced Features (3 tệp)

Các khả năng nâng cao cho các quy trình làm việc phức tạp.

| Tệp | Mô tả | Tính năng |
|------|-------------|----------|
| `README.md` | Hướng dẫn đầy đủ | Tài liệu về tất cả tính năng nâng cao |
| `config-examples.json` | Ví dụ cấu hình | Hơn 10 cấu hình cho các trường hợp cụ thể |
| `planning-mode-examples.md` | Ví dụ lập kế hoạch | REST API, di chuyển DB, refactoring |
| Tác vụ định kỳ | Tác vụ lặp lại với `/loop` và công cụ cron | Quy trình tự động lặp lại |
| Tích hợp Chrome | Tự động hóa trình duyệt qua headless Chromium | Kiểm thử web và cào dữ liệu |
| Remote Control (mở rộng) | Phương thức kết nối, bảo mật, bảng so sánh | Quản lý phiên từ xa |
| Tùy chỉnh bàn phím | Cấu hình phím tắt riêng, hỗ trợ chord, ngữ cảnh | Phím tắt cá nhân hóa |
| Desktop App (mở rộng) | Trình kết nối, launch.json, tính năng doanh nghiệp | Tích hợp máy tính để bàn |

**Các tính năng nâng cao bao gồm**:

### Planning Mode
- Tạo kế hoạch triển khai chi tiết
- Ước tính thời gian và đánh giá rủi ro
- Phân chia nhiệm vụ có hệ thống

### Extended Thinking
- Suy luận sâu cho các vấn đề phức tạp
- Phân tích quyết định kiến trúc
- Đánh giá sự đánh đổi (trade-offs)

### Background Tasks
- Các hoạt động chạy lâu mà không gây nghẽn
- Quy trình phát triển song song
- Quản lý và giám sát tác vụ

### Permission Modes
- **default**: Hỏi ý kiến cho các hành động nguy hiểm
- **acceptEdits**: Tự động chấp nhận sửa đổi tệp, hỏi cái khác
- **plan**: Phân tích read-only, không sửa đổi
- **auto**: Tự động phê duyệt hành động an toàn, hỏi cái nguy hiểm
- **dontAsk**: Chấp nhận tất cả hành động trừ cái nguy hiểm
- **bypassPermissions**: Chấp nhận tất cả (yêu cầu `--dangerously-skip-permissions`)

### Headless Mode (`claude -p`)
- Tích hợp CI/CD
- Thực thi tác vụ tự động
- Xử lý hàng loạt

### Session Management
- Nhiều phiên làm việc đa dạng
- Chuyển đổi và lưu phiên
- Lưu trữ phiên bền vững

### Tính năng tương tác
- Phím tắt bàn phím
- Lịch sử câu lệnh
- Tab completion
- Nhập liệu nhiều dòng

### Cấu hình
- Quản lý cài đặt toàn diện
- Cấu hình riêng cho từng môi trường
- Tùy chỉnh cho từng dự án

---

## 10. CLI Usage (1 tệp)

Các mẫu sử dụng và tham chiếu giao diện dòng lệnh.

| Tệp | Mô tả | Nội dung |
|------|-------------|---------|
| `README.md` | Tài liệu CLI | Các cờ, tùy chọn và mẫu sử dụng |

**Các tính năng CLI chính**:
- `claude` - Bắt đầu phiên tương tác
- `claude -p "prompt"` - Chế độ headless/không tương tác
- `claude web` - Mở phiên web
- `claude --model` - Chọn model (Sonnet 4.6, Opus 4.6)
- `claude --permission-mode` - Thiết lập chế độ quyền
- `claude --remote` - Bật điều khiển từ xa qua WebSocket

---

## Các tệp tài liệu (13 tệp)

| Tệp | Vị trí | Mô tả |
|------|----------|-------------|
| `README.md` | `/` | Tổng quan chính về các ví dụ |
| `INDEX.md` | `/` | Mục lục đầy đủ này |
| `QUICK_REFERENCE.md` | `/` | Thẻ tham chiếu nhanh |
| `README.md` | `/01-slash-commands/` | Hướng dẫn Slash commands |
| `README.md` | `/02-memory/` | Hướng dẫn Memory |
| `README.md` | `/03-skills/` | Hướng dẫn Skills |
| `README.md` | `/04-subagents/` | Hướng dẫn Subagents |
| `README.md` | `/05-mcp/` | Hướng dẫn MCP |
| `README.md` | `/06-hooks/` | Hướng dẫn Hooks |
| `README.md` | `/07-plugins/` | Hướng dẫn Plugins |
| `README.md` | `/08-checkpoints/` | Hướng dẫn Checkpoints |
| `README.md` | `/09-advanced-features/` | Hướng dẫn tính năng nâng cao |
| `README.md` | `/10-cli/` | Hướng dẫn CLI |

---

## Cấu trúc tệp đầy đủ (File Tree)

```
claude-howto/
├── README.md                                    # Tổng quan chính
├── INDEX.md                                     # Tệp này
├── QUICK_REFERENCE.md                           # Thẻ tham chiếu nhanh
├── claude_concepts_guide.md                     # Hướng dẫn gốc
│
├── 01-slash-commands/                           # Slash Commands
│   ├── optimize.md
│   ├── pr.md
│   ├── generate-api-docs.md
│   ├── commit.md
│   ├── setup-ci-cd.md
│   ├── push-all.md
│   ├── unit-test-expand.md
│   ├── doc-refactor.md
│   ├── pr-slash-command.png
│   └── README.md
│
├── 02-memory/                                   # Memory
│   ├── project-CLAUDE.md
│   ├── directory-api-CLAUDE.md
│   ├── personal-CLAUDE.md
│   ├── memory-saved.png
│   ├── memory-ask-claude.png
│   └── README.md
│
├── 03-skills/                                   # Skills
│   ├── code-review/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-metrics.py
│   │   │   └── compare-complexity.py
│   │   └── templates/
│   │       ├── review-checklist.md
│   │       └── finding-template.md
│   ├── brand-voice/
│   │   ├── SKILL.md
│   │   ├── templates/
│   │   │   ├── email-template.txt
│   │   │   └── social-post-template.txt
│   │   └── tone-examples.md
│   ├── doc-generator/
│   │   ├── SKILL.md
│   │   └── generate-docs.py
│   ├── refactor/
│   │   ├── SKILL.md
│   │   ├── scripts/
│   │   │   ├── analyze-complexity.py
│   │   │   └── detect-smells.py
│   │   ├── references/
│   │   │   ├── code-smells.md
│   │   │   └── refactoring-catalog.md
│   │   └── templates/
│   │       └── refactoring-plan.md
│   ├── claude-md/
│   │   └── SKILL.md
│   ├── blog-draft/
│   │   ├── SKILL.md
│   │   └── templates/
│   │       ├── draft-template.md
│   │       └── outline-template.md
│   └── README.md
│
├── 04-subagents/                                # Subagents
│   ├── code-reviewer.md
│   ├── test-engineer.md
│   ├── documentation-writer.md
│   ├── secure-reviewer.md
│   ├── implementation-agent.md
│   ├── debugger.md
│   ├── data-scientist.md
│   ├── clean-code-reviewer.md
│   └── README.md
│
├── 05-mcp/                                      # MCP Protocol
│   ├── github-mcp.json
│   ├── database-mcp.json
│   ├── filesystem-mcp.json
│   ├── multi-mcp.json
│   └── README.md
│
├── 06-hooks/                                    # Hooks
│   ├── format-code.sh
│   ├── pre-commit.sh
│   ├── security-scan.sh
│   ├── log-bash.sh
│   ├── validate-prompt.sh
│   ├── notify-team.sh
│   ├── context-tracker.py
│   ├── context-tracker-tiktoken.py
│   └── README.md
│
├── 07-plugins/                                  # Plugins
│   ├── pr-review/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── review-pr.md
│   │   │   ├── check-security.md
│   │   │   └── check-tests.md
│   │   ├── agents/
│   │   │   ├── security-reviewer.md
│   │   │   ├── test-checker.md
│   │   │   └── performance-analyzer.md
│   │   ├── mcp/
│   │   │   └── github-config.json
│   │   ├── hooks/
│   │   │   └── pre-review.js
│   │   └── README.md
│   ├── devops-automation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── deploy.md
│   │   │   ├── rollback.md
│   │   │   ├── status.md
│   │   │   └── incident.md
│   │   ├── agents/
│   │   │   ├── deployment-specialist.md
│   │   │   ├── incident-commander.md
│   │   │   └── alert-analyzer.md
│   │   ├── mcp/
│   │   │   └── kubernetes-config.json
│   │   ├── hooks/
│   │   │   ├── pre-deploy.js
│   │   │   └── post-deploy.js
│   │   ├── scripts/
│   │   │   ├── deploy.sh
│   │   │   ├── rollback.sh
│   │   │   └── health-check.sh
│   │   └── README.md
│   ├── documentation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json
│   │   ├── commands/
│   │   │   ├── generate-api-docs.md
│   │   │   ├── generate-readme.md
│   │   │   ├── sync-docs.md
│   │   │   └── validate-docs.md
│   │   ├── agents/
│   │   │   ├── api-documenter.md
│   │   │   ├── code-commentator.md
│   │   │   └── example-generator.md
│   │   ├── mcp/
│   │   │   └── github-docs-config.json
│   │   ├── templates/
│   │   │   ├── api-endpoint.md
│   │   │   ├── function-docs.md
│   │   │   └── adr-template.md
│   │   └── README.md
│   └── README.md
│
├── 08-checkpoints/                              # Checkpoints
│   ├── checkpoint-examples.md
│   └── README.md
│
├── 09-advanced-features/                        # Advanced Features
│   ├── config-examples.json
│   ├── planning-mode-examples.md
│   └── README.md
│
└── 10-cli/                                      # CLI Usage
    └── README.md
```

---

## Bắt đầu nhanh theo Tình huống

### Chất lượng mã & Review
```bash
# Cài đặt slash command
cp 01-slash-commands/optimize.md .claude/commands/

# Cài đặt subagent
cp 04-subagents/code-reviewer.md .claude/agents/

# Cài đặt skill
cp -r 03-skills/code-review ~/.claude/skills/

# Hoặc cài đặt plugin hoàn chỉnh
/plugin install pr-review
```

### DevOps & Triển khai
```bash
# Cài đặt plugin (bao gồm tất cả)
/plugin install devops-automation
```

### Tài liệu
```bash
# Cài đặt slash command
cp 01-slash-commands/generate-api-docs.md .claude/commands/

# Cài đặt subagent
cp 04-subagents/documentation-writer.md .claude/agents/

# Cài đặt skill
cp -r 03-skills/doc-generator ~/.claude/skills/

# Hoặc cài đặt plugin hoàn chỉnh
/plugin install documentation
```

### Tiêu chuẩn nhóm
```bash
# Thiết lập bộ nhớ dự án
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Sửa đổi để phù hợp với tiêu chuẩn nhóm của bạn
```

### Tích hợp bên ngoài
```bash
# Thiết lập biến môi trường
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# Cài đặt cấu hình MCP (phạm vi dự án)
cp 05-mcp/multi-mcp.json .mcp.json
```

### Tự động hóa & Xác thực
```bash
# Cài đặt hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Cấu hình hooks trong cài đặt (~/.claude/settings.json)
# Xem 06-hooks/README.md
```

### Thử nghiệm an toàn
```bash
# Checkpoints được tạo tự động với mỗi prompt của người dùng
# Để quay lại: nhấn Esc+Esc hoặc sử dụng /rewind
# Sau đó chọn nội dung cần khôi phục từ menu rewind

# Xem 08-checkpoints/README.md để biết ví dụ
```

### Quy trình nâng cao
```bash
# Cấu hình tính năng nâng cao
# Xem 09-advanced-features/config-examples.json

# Sử dụng planning mode
/plan Implement feature X

# Sử dụng chế độ quyền
claude --permission-mode plan          # Review code (read-only)
claude --permission-mode acceptEdits   # Tự động chấp nhận edits
claude --permission-mode auto          # Tự động phê duyệt hành động an toàn

# Chạy ở chế độ headless cho CI/CD
claude -p "Run tests and report results"

# Chạy tác vụ nền
Run tests in background

# Xem 09-advanced-features/README.md để biết hướng dẫn đầy đủ
```

---

## Ma trận Bao phủ tính năng

| Danh mục | Commands | Agents | MCP | Hooks | Scripts | Templates | Docs | Images | Tổng |
|----------|----------|--------|-----|-------|---------|-----------|------|--------|-------|
| **01 Slash Commands** | 8 | - | - | - | - | - | 1 | 1 | **10** |
| **02 Memory** | - | - | - | - | - | 3 | 1 | 2 | **6** |
| **03 Skills** | - | - | - | - | 5 | 9 | 1 | - | **28** |
| **04 Subagents** | - | 8 | - | - | - | - | 1 | - | **9** |
| **05 MCP** | - | - | 4 | - | - | - | 1 | - | **5** |
| **06 Hooks** | - | - | - | 8 | - | - | 1 | - | **9** |
| **07 Plugins** | 11 | 9 | 3 | 3 | 3 | 3 | 4 | - | **40** |
| **08 Checkpoints** | - | - | - | - | - | - | 1 | 1 | **2** |
| **09 Advanced** | - | - | - | - | - | - | 1 | 2 | **3** |
| **10 CLI** | - | - | - | - | - | - | 1 | - | **1** |

---

## Lộ trình học tập

### Mới bắt đầu (Tuần 1)
1. ✅ Đọc `README.md`
2. ✅ Cài đặt 1-2 slash commands
3. ✅ Tạo tệp bộ nhớ dự án
4. ✅ Thử các câu lệnh cơ bản

### Trung bình (Tuần 2-3)
1. ✅ Thiết lập GitHub MCP
2. ✅ Cài đặt một subagent
3. ✅ Thử ủy quyền tác vụ
4. ✅ Cài đặt một skill

### Nâng cao (Tuần 4+)
1. ✅ Cài đặt plugin hoàn chỉnh
2. ✅ Tạo slash command tùy chỉnh
3. ✅ Tạo subagent tùy chỉnh
4. ✅ Tạo skill tùy chỉnh
5. ✅ Xây dựng plugin của riêng bạn

### Chuyên gia (Tuần 5+)
1. ✅ Thiết lập hooks để tự động hóa
2. ✅ Sử dụng checkpoints để thử nghiệm
3. ✅ Cấu hình planning mode
4. ✅ Sử dụng các chế độ quyền một cách hiệu quả
