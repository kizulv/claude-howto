<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Hướng dẫn đầy đủ về các khái niệm của Claude

Một hướng dẫn tham chiếu toàn diện bao gồm Slash Commands, Subagents, Memory, Giao thức MCP và Agent Skills với các bảng, sơ đồ và ví dụ thực tế.

---

## Mục lục

1. [Slash Commands](#slash-commands)
2. [Subagents](#subagents)
3. [Memory](#memory)
4. [Giao thức MCP](#mcp-protocol)
5. [Agent Skills](#agent-skills)
6. [Plugins](#plugins)
7. [Hooks](#hooks)
8. [Checkpoints và Rewind](#checkpoints-and-rewind)
9. [Các tính năng nâng cao](#advanced-features)
10. [So sánh & Tích hợp](#comparison--integration)

---

## Slash Commands

### Tổng quan

Slash commands là các phím tắt do người dùng gọi, được lưu trữ dưới dạng các tệp Markdown mà Claude Code có thể thực thi. Chúng cho phép các nhóm chuẩn hóa các prompt và quy trình làm việc thường xuyên sử dụng.

### Kiến trúc

```mermaid
graph TD
    A["Đầu vào người dùng: /tên-lệnh"] -->|Kích hoạt| B["Tìm kiếm trong .claude/commands/"]
    B -->|Tìm thấy| C["tên-lệnh.md"]
    C -->|Tải| D["Nội dung Markdown"]
    D -->|Thực thi| E["Claude xử lý Prompt"]
    E -->|Trả về| F["Kết quả trong ngữ cảnh"]
```

### Cấu trúc tệp

```mermaid
graph LR
    A["Gốc dự án"] -->|chứa| B[".claude/commands/"]
    B -->|chứa| C["optimize.md"]
    B -->|chứa| D["test.md"]
    B -->|chứa| E["docs/"]
    E -->|chứa| F["generate-api-docs.md"]
    E -->|chứa| G["generate-readme.md"]
```

### Bảng tổ chức lệnh

| Vị trí | Phạm vi | Khả dụng | Tình huống sử dụng | Được theo dõi bởi Git |
|----------|-------|--------------|----------|-------------|
| `.claude/commands/` | Theo dự án | Thành viên trong nhóm | Quy trình làm việc nhóm, tiêu chuẩn chung | ✅ Có |
| `~/.claude/commands/` | Cá nhân | Người dùng cá nhân | Phím tắt cá nhân trên mọi dự án | ❌ Không |
| Thư mục con | Theo không gian tên (Namespaced) | Dựa trên thư mục cha | Tổ chức theo hạng mục | ✅ Có |

### Các tính năng & Khả năng

| Tính năng | Ví dụ | Được hỗ trợ |
|---------|---------|-----------|
| Thực thi shell script | `bash scripts/deploy.sh` | ✅ Có |
| Tham chiếu tệp | `@path/to/file.js` | ✅ Có |
| Tích hợp Bash | `$(git log --oneline)` | ✅ Có |
| Tham số (Arguments) | `/pr --verbose` | ✅ Có |
| Các lệnh MCP | `/mcp__github__list_prs` | ✅ Có |

### Ví dụ thực tế

#### Ví dụ 1: Lệnh tối ưu hóa mã nguồn

**Tệp:** `.claude/commands/optimize.md`

```markdown
---
name: Tối ưu hóa mã nguồn
description: Phân tích mã nguồn để tìm các vấn đề hiệu suất và đề xuất tối ưu hóa
tags: performance, analysis
---

# Tối ưu hóa mã nguồn

Hãy xem xét mã được cung cấp để tìm các vấn đề sau đây theo thứ tự ưu tiên:

1. **Nút thắt hiệu suất** - xác định các toán tử O(n²), các vòng lặp không hiệu quả
2. **Rò rỉ bộ nhớ** - tìm các tài nguyên không được giải phóng, tham chiếu vòng
3. **Cải tiến thuật toán** - đề xuất các thuật toán hoặc cấu trúc dữ liệu tốt hơn
4. **Cơ hội bộ nhớ đệm (Caching)** - xác định các tính toán lặp lại
5. **Vấn đề đồng thời** - tìm các điều kiện đua (race conditions) hoặc vấn đề luồng

Định dạng phản hồi của bạn gồm:
- Mức độ nghiêm trọng (Critical/High/Medium/Low)
- Vị trí trong mã
- Giải thích
- Cách khắc phục đề xuất kèm theo ví dụ mã
```

**Sử dụng:**
```bash
# Người dùng gõ trong Claude Code
/optimize

# Claude tải prompt và đợi đầu vào mã nguồn
```

#### Ví dụ 2: Lệnh hỗ trợ Pull Request

**Tệp:** `.claude/commands/pr.md`

```markdown
---
name: Chuẩn bị Pull Request
description: Dọn dẹp mã, stage các thay đổi và chuẩn bị một pull request
tags: git, workflow
---

# Danh sách kiểm tra chuẩn bị Pull Request

Trước khi tạo một PR, hãy thực hiện các bước sau:

1. Chạy linting: `prettier --write .`
2. Chạy tests: `npm test`
3. Xem xét git diff: `git diff HEAD`
4. Stage các thay đổi: `git add .`
5. Tạo thông điệp commit tuân theo conventional commits:
   - `fix:` cho các bản sửa lỗi
   - `feat:` cho các tính năng mới
   - `docs:` cho tài liệu
   - `refactor:` cho việc tái cấu trúc mã
   - `test:` cho việc thêm kiểm thử
   - `chore:` cho việc bảo trì

6. Tạo bản tóm tắt PR bao gồm:
   - Những gì đã thay đổi
   - Tại sao nó thay đổi
   - Các bài kiểm thử đã thực hiện
   - Các tác động tiềm tàng
```

**Sử dụng:**
```bash
/pr

# Claude chạy qua danh sách kiểm tra và chuẩn bị PR
```

#### Ví dụ 3: Trình tạo tài liệu phân cấp

**Tệp:** `.claude/commands/docs/generate-api-docs.md`

```markdown
---
name: Tạo tài liệu API
description: Tạo tài liệu API toàn diện từ mã nguồn
tags: documentation, api
---

# Trình tạo tài liệu API

Tạo tài liệu API bằng cách:

1. Quét tất cả các tệp trong `/src/api/`
2. Trích xuất chữ ký hàm và các chú thích JSDoc
3. Tổ chức theo endpoint/module
4. Tạo markdown kèm theo ví dụ
5. Bao gồm các schema yêu cầu/phản hồi
6. Thêm tài liệu về lỗi

Định dạng đầu ra:
- Tệp Markdown trong `/docs/api.md`
- Bao gồm các ví dụ curl cho tất cả các endpoint
- Thêm các kiểu dữ liệu TypeScript
```

### Sơ đồ vòng đời của lệnh

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant FS as Hệ thống tệp
    participant CLI as Shell/Bash

    User->>Claude: Gõ /optimize
    Claude->>FS: Tìm kiếm trong .claude/commands/
    FS-->>Claude: Trả về optimize.md
    Claude->>Claude: Tải nội dung Markdown
    Claude->>User: Hiển thị ngữ cảnh prompt
    User->>Claude: Cung cấp mã nguồn để phân tích
    Claude->>CLI: (Có thể thực thi các script)
    CLI-->>Claude: Kết quả
    Claude->>User: Trả về phân tích
```

### Thực hành tốt nhất

| ✅ Nên làm | ❌ Không nên làm |
|------|---------|
| Sử dụng tên rõ ràng, hướng tới hành động | Tạo lệnh cho các tác vụ chỉ dùng một lần |
| Viết từ khóa kích hoạt trong mô tả | Xây dựng logic phức tạp trong các lệnh |
| Giữ các lệnh tập trung vào một tác vụ duy nhất | Tạo các lệnh dư thừa |
| Quản lý phiên bản cho các lệnh dự án | Ghi cứng các thông tin nhạy cảm |
| Tổ chức trong các thư mục con | Tạo các danh sách lệnh quá dài |
| Sử dụng các prompt đơn giản, dễ đọc | Sử dụng các từ viết tắt hoặc khó hiểu |

---

## Subagents

### Tổng quan

Subagents là các trợ lý AI chuyên biệt với các cửa sổ ngữ cảnh độc lập và các system prompt tùy chỉnh. Chúng cho phép ủy quyền thực thi tác vụ trong khi vẫn duy trì sự phân tách rõ ràng các mối quan tâm.

### Sơ đồ kiến trúc

```mermaid
graph TB
    User["👤 Người dùng"]
    Main["🎯 Agent chính<br/>(Điều phối viên)"]
    Reviewer["🔍 Reviewer mã<br/>Subagent"]
    Tester["✅ Kỹ sư kiểm thử<br/>Subagent"]
    Docs["📝 Người viết tài liệu<br/>Subagent"]

    User -->|yêu cầu| Main
    Main -->|ủy quyền| Reviewer
    Main -->|ủy quyền| Tester
    Main -->|ủy quyền| Docs
    Reviewer -->|trả về kết quả| Main
    Tester -->|trả về kết quả| Main
    Docs -->|trả về kết quả| Main
    Main -->|tổng hợp| User
```

### Vòng đời của Subagent

```mermaid
sequenceDiagram
    participant User
    participant MainAgent as Agent chính
    participant CodeReviewer as Reviewer mã<br/>Subagent
    participant Context as Cửa sổ ngữ cảnh<br/>độc lập

    User->>MainAgent: "Xây dựng tính năng auth mới"
    MainAgent->>MainAgent: Phân tích tác vụ
    MainAgent->>CodeReviewer: "Review mã nguồn này"
    CodeReviewer->>Context: Khởi tạo ngữ cảnh sạch
    Context->>CodeReviewer: Tải hướng dẫn cho reviewer
    CodeReviewer->>CodeReviewer: Thực hiện review
    CodeReviewer-->>MainAgent: Trả về kết quả tìm thấy
    MainAgent->>MainAgent: Kết hợp kết quả
    MainAgent-->>User: Cung cấp bản tổng hợp
```

### Bảng cấu hình Subagent

| Cấu hình | Kiểu | Mục đích | Ví dụ |
|---------------|------|---------|---------|
| `name` | Chuỗi | Định danh agent | `code-reviewer` |
| `description` | Chuỗi | Mục đích & các từ khóa kích hoạt | `Phân tích toàn diện chất lượng mã và khả năng bảo trì` |
| `tools` | Danh sách/Chuỗi | Các khả năng được phép | `read, grep, diff, lint_runner` |
| `system_prompt` | Markdown | Hướng dẫn hành vi | Các quy tắc tùy chỉnh |

### Hệ thống quyền hạn công cụ

```mermaid
graph TD
    A["Cấu hình Subagent"] -->|Lựa chọn 1| B["Kế thừa tất cả công cụ<br/>từ luồng chính"]
    A -->|Lựa chọn 2| C["Chỉ định từng công cụ"]
    B -->|Bao gồm| B1["Các thao tác tệp"]
    B -->|Bao gồm| B2["Các câu lệnh Shell"]
    B -->|Bao gồm| B3["Các công cụ MCP"]
    C -->|Danh sách rõ ràng| C1["read, grep, diff"]
    C -->|Danh sách rõ ràng| C2["Bash(npm:*), Bash(test:*)"]
```

### Ví dụ thực tế

#### Ví dụ 1: Thiết lập Subagent hoàn chỉnh

**Tệp:** `.claude/agents/code-reviewer.md`

```yaml
---
name: code-reviewer
description: Phân tích toàn diện chất lượng và khả năng bảo trì mã nguồn
tools: read, grep, diff, lint_runner
---

# Agent Reviewer Mã nguồn

Bạn là một chuyên gia review mã nguồn chuyên về:
- Tối ưu hóa hiệu suất
- Các lỗ hổng bảo mật
- Khả năng bảo trì mã nguồn
- Độ bao phủ kiểm thử (testing coverage)
- Các mẫu thiết kế (design patterns)

## Ưu tiên Review (theo thứ tự)

1. **Vấn đề bảo mật** - Xác thực, phân quyền, lộ dữ liệu
2. **Vấn đề hiệu suất** - Toán tử O(n²), rò rỉ bộ nhớ, truy vấn không hiệu quả
3. **Chất lượng mã** - Khả năng đọc, đặt tên, tài liệu
4. **Độ bao phủ kiểm thử** - Thiếu tests, các trường hợp biên
5. **Mẫu thiết kế** - Các nguyên tắc SOLID, kiến trúc

## Định dạng đầu ra Review

Với mỗi vấn đề:
- **Mức độ nghiêm trọng**: Critical / High / Medium / Low
- **Hạng mục**: Security / Performance / Quality / Testing / Design
- **Vị trí**: Đường dẫn tệp và số dòng
- **Mô tả vấn đề**: Có gì sai và tại sao
- **Cách khắc phục đề xuất**: Ví dụ mã
- **Tác động**: Điều này ảnh hưởng thế nào đến hệ thống
```

**Tệp:** `.claude/agents/test-engineer.md`

```yaml
---
name: test-engineer
description: Chiến lược kiểm thử, phân tích độ bao phủ và kiểm thử tự động
tools: read, write, bash, grep
---

# Agent Kỹ sư Kiểm thử

Bạn là chuyên gia về:
- Viết các bộ kiểm thử (test suites) toàn diện
- Đảm bảo độ bao phủ mã nguồn cao (>80%)
- Kiểm thử các trường hợp biên và kịch bảnh lỗi
- Benchmarking hiệu suất
- Kiểm thử tích hợp (integration testing)

## Chiến lược Kiểm thử

1. **Unit Tests** - Các hàm/phương thức riêng lẻ
2. **Integration Tests** - Sự tương tác giữa các thành phần
3. **End-to-End Tests** - Quy trình làm việc hoàn chỉnh
4. **Edge Cases** - Các điều kiện biên
5. **Error Scenarios** - Xử lý thất bại

## Yêu cầu đầu ra Kiểm thử

- Sử dụng Jest cho JavaScript/TypeScript
- Bao gồm setup/teardown cho mỗi test
- Mock các phụ thuộc bên ngoài
- Viết tài liệu cho mục đích của test
- Bao gồm các khẳng định (assertions) hiệu suất nếu liên quan
```

**Tệp:** `.claude/agents/documentation-writer.md`

```yaml
---
name: documentation-writer
description: Tài liệu kỹ thuật, tài liệu API và hướng dẫn người dùng
tools: read, write, grep
---

```yaml
---
name: secure-reviewer
description: Security-focused code review with minimal permissions
tools: read, grep
---

# Secure Code Reviewer

Reviews code for security vulnerabilities only.

This agent:
- ✅ Reads files to analyze
- ✅ Searches for patterns
- ❌ Cannot execute code
- ❌ Cannot modify files
- ❌ Cannot run tests

This ensures the reviewer doesn't accidentally break anything.
```

**Extended Setup - All Tools for Implementation**

```yaml
---
name: implementation-agent
description: Full implementation capabilities for feature development
tools: read, write, bash, grep, edit, glob
---

# Implementation Agent

Builds features from specifications.

This agent:
- ✅ Reads specifications
- ✅ Writes new code files
- ✅ Runs build commands
- ✅ Searches codebase
- ✅ Edits existing files
- ✅ Finds files matching patterns

Full capabilities for independent feature development.
```

### Subagent Context Management

```mermaid
graph TB
    A["Main Agent Context<br/>50,000 tokens"]
    B["Subagent 1 Context<br/>20,000 tokens"]
    C["Subagent 2 Context<br/>20,000 tokens"]
    D["Subagent 3 Context<br/>20,000 tokens"]

    A -->|Clean slate| B
    A -->|Clean slate| C
    A -->|Clean slate| D

    B -->|Results only| A
    C -->|Results only| A
    D -->|Results only| A

    style A fill:#e1f5ff
    style B fill:#fff9c4
    style C fill:#fff9c4
    style D fill:#fff9c4
```

### When to Use Subagents

| Scenario | Use Subagent | Why |
|----------|--------------|-----|
| Complex feature with many steps | ✅ Yes | Separate concerns, prevent context pollution |
| Quick code review | ❌ No | Not necessary overhead |
| Parallel task execution | ✅ Yes | Each subagent has own context |
| Specialized expertise needed | ✅ Yes | Custom system prompts |
| Long-running analysis | ✅ Yes | Prevents main context exhaustion |
| Single task | ❌ No | Adds latency unnecessarily |

### Agent Teams

Agent Teams coordinate multiple agents working on related tasks. Rather than delegating to one subagent at a time, Agent Teams allow the main agent to orchestrate a group of agents that collaborate, share intermediate results, and work toward a common goal. This is useful for large-scale tasks like full-stack feature development where a frontend agent, backend agent, and testing agent work in parallel.

---

## Memory

### Overview

Memory enables Claude to retain context across sessions and conversations. It exists in two forms: automatic synthesis in claude.ai, and filesystem-based CLAUDE.md in Claude Code.

### Memory Architecture

```mermaid
graph TB
    A["Claude Session"]
    B["User Input"]
    C["Memory System"]
    D["Memory Storage"]

    B -->|User provides info| C
    C -->|Synthesizes every 24h| D
    D -->|Loads automatically| A
    A -->|Uses context| C
```

### Memory Hierarchy in Claude Code (7 Tiers)

Claude Code loads memory from 7 tiers, listed from highest to lowest priority:

```mermaid
graph TD
    A["1. Managed Policy<br/>Enterprise admin policies"] --> B["2. Project Memory<br/>./CLAUDE.md"]
    B --> C["3. Project Rules<br/>.claude/rules/*.md"]
    C --> D["4. User Memory<br/>~/.claude/CLAUDE.md"]
    D --> E["5. User Rules<br/>~/.claude/rules/*.md"]
    E --> F["6. Local Memory<br/>.claude/local/CLAUDE.md"]
    F --> G["7. Auto Memory<br/>Automatically captured preferences"]

    style A fill:#fce4ec,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#e1f5fe,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
    style G fill:#fff3e0,stroke:#333,color:#333
```

### Memory Locations Table

| Tier | Location | Scope | Priority | Shared | Best For |
|------|----------|-------|----------|--------|----------|
| 1. Managed Policy | Enterprise admin | Organization | Highest | All org users | Compliance, security policies |
| 2. Project | `./CLAUDE.md` | Project | High | Team (Git) | Team standards, architecture |
| 3. Project Rules | `.claude/rules/*.md` | Project | High | Team (Git) | Modular project conventions |
| 4. User | `~/.claude/CLAUDE.md` | Personal | Medium | Individual | Personal preferences |
| 5. User Rules | `~/.claude/rules/*.md` | Personal | Medium | Individual | Personal rule modules |
| 6. Local | `.claude/local/CLAUDE.md` | Local | Low | Not shared | Machine-specific settings |
| 7. Auto Memory | Automatic | Session | Lowest | Individual | Learned preferences, patterns |

### Auto Memory

Auto Memory automatically captures user preferences and patterns observed during sessions. Claude learns from your interactions and remembers:

- Coding style preferences
- Common corrections you make
- Framework and tool choices
- Communication style preferences

Auto Memory works in the background and does not require manual configuration.

### Memory Update Lifecycle

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Editor as File System
    participant Memory as CLAUDE.md

    User->>Claude: "Remember: use async/await"
    Claude->>User: "Which memory file?"
    User->>Claude: "Project memory"
    Claude->>Editor: Open ~/.claude/settings.json
    Claude->>Memory: Write to ./CLAUDE.md
    Memory-->>Claude: File saved
    Claude->>Claude: Load updated memory
    Claude-->>User: "Memory saved!"
```

### Practical Examples

#### Example 1: Project Memory Structure

**File:** `./CLAUDE.md`

```markdown
# Project Configuration

## Project Overview
- **Name**: E-commerce Platform
- **Tech Stack**: Node.js, PostgreSQL, React 18, Docker
- **Team Size**: 5 developers
- **Deadline**: Q4 2025

## Architecture
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Development Standards

### Code Style
- Use Prettier for formatting
- Use ESLint with airbnb config
- Maximum line length: 100 characters
- Use 2-space indentation

### Naming Conventions
- **Files**: kebab-case (user-controller.js)
- **Classes**: PascalCase (UserService)
- **Functions/Variables**: camelCase (getUserById)
- **Constants**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Database Tables**: snake_case (user_accounts)

### Git Workflow
- Branch names: `feature/description` or `fix/description`
- Commit messages: Follow conventional commits
- PR required before merge
- All CI/CD checks must pass
- Minimum 1 approval required

### Testing Requirements
- Minimum 80% code coverage
- All critical paths must have tests
- Use Jest for unit tests
- Use Cypress for E2E tests
- Test filenames: `*.test.ts` or `*.spec.ts`

### API Standards
- RESTful endpoints only
- JSON request/response
- Use HTTP status codes correctly
- Version API endpoints: `/api/v1/`
- Document all endpoints with examples

### Database
- Use migrations for schema changes
- Never hardcode credentials
- Use connection pooling
- Enable query logging in development
- Regular backups required

### Deployment
- Docker-based deployment
- Kubernetes orchestration
- Blue-green deployment strategy
- Automatic rollback on failure
- Database migrations run before deploy

## Common Commands

| Command | Purpose |
|---------|---------|
| `npm run dev` | Start development server |
| `npm test` | Run test suite |
| `npm run lint` | Check code style |
| `npm run build` | Build for production |
| `npm run migrate` | Run database migrations |

## Team Contacts
- Tech Lead: Sarah Chen (@sarah.chen)
- Product Manager: Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Known Issues & Workarounds
- PostgreSQL connection pooling limited to 20 during peak hours
- Workaround: Implement query queuing
- Safari 14 compatibility issues with async generators
- Workaround: Use Babel transpiler

## Related Projects
- Analytics Dashboard: `/projects/analytics`
- Mobile App: `/projects/mobile`
- Admin Panel: `/projects/admin`
```

#### Example 2: Directory-Specific Memory

**File:** `./src/api/CLAUDE.md`

~~~~markdown
# API Module Standards

This file overrides root CLAUDE.md for everything in /src/api/

## API-Specific Standards

### Request Validation
- Use Zod for schema validation
- Always validate input
- Return 400 with validation errors
- Include field-level error details

### Authentication
- All endpoints require JWT token
- Token in Authorization header
- Token expires after 24 hours
- Implement refresh token mechanism

### Response Format

All responses must follow this structure:

```json
{
  "success": true,
  "data": { /* actual data */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

### Error responses:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "User message",
    "details": { /* field errors */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Pagination
- Use cursor-based pagination (not offset)
- Include `hasMore` boolean
- Limit max page size to 100
- Default page size: 20

### Rate Limiting#### Ví dụ 4: Cập nhật Memory trong phiên làm việc

**Tương tác trong phiên:**

```markdown
Người dùng: Hãy nhớ rằng tôi ưu tiên sử dụng React hooks thay vì class components
          cho tất cả các component mới.

Claude: Tôi đang thêm điều đó vào bộ nhớ của bạn. Thông tin này nên được lưu vào tệp nào?
        1. Bộ nhớ dự án (./CLAUDE.md)
        2. Bộ nhớ cá nhân (~/.claude/CLAUDE.md)

Người dùng: Bộ nhớ dự án

Claude: ✅ Đã lưu bộ nhớ!

Đã thêm vào ./CLAUDE.md:
---

### Phát triển Component
- Sử dụng functional components với React Hooks
- Ưu tiên hooks thay vì class components
- Sử dụng Custom hooks cho logic có thể tái sử dụng
- Sử dụng useCallback cho các event handlers
- Sử dụng useMemo cho các tính toán tốn kém
```

### Memory trong Claude Web/Desktop

#### Dòng thời gian tổng hợp bộ nhớ

```mermaid
graph LR
    A["Ngày 1: Các hội thoại<br/>của người dùng"] -->|24 giờ| B["Ngày 2: Tổng hợp<br/>Bộ nhớ"]
    B -->|Tự động| C["Bộ nhớ được cập nhật<br/>và tóm tắt"]
    C -->|Được tải vào| D["Ngày 2-N:<br/>Các hội thoại mới"]
    D -->|Thêm vào| E["Bộ nhớ"]
    E -->|24 giờ sau| F["Bộ nhớ được làm mới"]
```

**Ví dụ tóm tắt bộ nhớ:**

```markdown
## Bộ nhớ của Claude về người dùng

### Nền tảng chuyên môn
- Nhà phát triển full-stack cấp cao với 8 năm kinh nghiệm
- Tập trung vào backend Node.js/TypeScript và frontend React
- Người đóng góp tích cực cho mã nguồn mở
- Quan tâm đến AI và Machine Learning

### Ngữ cảnh dự án
- Hiện đang xây dựng nền tảng thương mại điện tử
- Tech stack: Node.js, PostgreSQL, React 18, Docker
- Làm việc trong nhóm gồm 5 nhà phát triển
- Sử dụng CI/CD và blue-green deployments

### Ưu tiên giao tiếp
- Thích các giải thích trực tiếp, ngắn gọn
- Thích các sơ đồ trực quan và ví dụ
- Đánh giá cao các đoạn mã mẫu
- Giải thích logic nghiệp vụ trong chú thích

### Mục tiêu hiện tại
- Cải thiện hiệu suất API
- Tăng độ bao phủ kiểm thử lên 90%
- Triển khai chiến lược bộ nhớ đệm (caching)
- Tài liệu hóa kiến trúc
```

### So sánh các tính năng Memory

| Tính năng | Claude Web/Desktop | Claude Code (CLAUDE.md) |
|---------|-------------------|------------------------|
| Tự động tổng hợp | ✅ Mỗi 24h | ❌ Thủ công |
| Đa dự án | ✅ Chia sẻ chung | ❌ Theo từng dự án |
| Truy cập nhóm | ✅ Các dự án chia sẻ | ✅ Được theo dõi bởi Git |
| Có thể tìm kiếm | ✅ Tích hợp sẵn | ✅ Qua lệnh `/memory` |
| Có thể chỉnh sửa | ✅ Trong cửa sổ chat | ✅ Chỉnh sửa tệp trực tiếp |
| Xuất/Nhập | ✅ Có | ✅ Copy/paste |
| Lưu giữ lâu dài | ✅ Trên 24h | ✅ Vô thời hạn |

---

## Giao thức MCP

### Tổng quan

MCP (Model Context Protocol) là một phương thức tiêu chuẩn hóa để Claude truy cập các công cụ, API và nguồn dữ liệu thời gian thực bên ngoài. Khác với Memory, MCP cung cấp quyền truy cập trực tiếp vào dữ liệu luôn thay đổi.

### Kiến trúc MCP

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["Dịch vụ bên ngoài"]

    A -->|Yêu cầu: list_issues| B
    B -->|Truy vấn| C
    C -->|Dữ liệu| B
    B -->|Phản hồi| A

    A -->|Yêu cầu: create_issue| B
    B -->|Hành động| C
    C -->|Kết quả| B
    B -->|Phản hồi| A
```

### Hệ sinh thái MCP

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]
```

### Quy trình thiết lập MCP

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Tệp cấu hình
    participant Service as Dịch vụ bên ngoài

    User->>Claude: Gõ /mcp
    Claude->>Claude: Liệt kê các MCP server có sẵn
    Claude->>User: Hiển thị các lựa chọn
    User->>Claude: Chọn GitHub MCP
    Claude->>Config: Cập nhật cấu hình
    Config->>Claude: Kích hoạt kết nối
    Claude->>Service: Kiểm tra kết nối
    Service-->>Claude: Xác thực thành công
    Claude->>User: ✅ MCP đã kết nối!
```

### Bảng các MCP Server phổ biến

| MCP Server | Mục đích | Các công cụ phổ biến | Xác thực | Thời gian thực |
|------------|---------|--------------|------|-----------|
| **Filesystem** | Thao tác tệp | read, write, delete | Quyền của OS | ✅ Có |
| **GitHub** | Quản lý kho mã nguồn | list_prs, create_issue, push | OAuth | ✅ Có |
| **Slack** | Giao tiếp nhóm | send_message, list_channels | Token | ✅ Có |
| **Database** | Truy vấn SQL | query, insert, update | Thông tin đăng nhập | ✅ Có |
| **Google Docs** | Truy cập tài liệu | read, write, share | OAuth | ✅ Có |
| **Asana** | Quản lý dự án | create_task, update_status | API Key | ✅ Có |
| **Stripe** | Dữ liệu thanh toán | list_charges, create_invoice | API Key | ✅ Có |
| **Memory** | Bộ nhớ lâu dài | store, retrieve, delete | Cục bộ | ❌ Không |

### Ví dụ thực tế

#### Ví dụ 1: Cấu hình GitHub MCP

**Tệp:** `.mcp.json` (phạm vi dự án) hoặc `~/.claude.json` (phạm vi người dùng)

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Các công cụ GitHub MCP có sẵn:**

~~~~markdown
# Các công cụ GitHub MCP

## Quản lý Pull Request
- `list_prs` - Liệt kê tất cả PR trong repo
- `get_pr` - Lấy chi tiết PR bao gồm cả diff
- `create_pr` - Tạo PR mới
- `update_pr` - Cập nhật mô tả/tiêu đề PR
- `merge_pr` - Merge PR vào nhánh chính
- `review_pr` - Thêm phản hồi (review)

Yêu cầu ví dụ:
```
/mcp__github__get_pr 456

# Trả về:
Tiêu đề: Add dark mode support
Tác giả: @alice
Mô tả: Implements dark theme using CSS variables
Trạng thái: OPEN
Reviewers: @bob, @charlie
```

## Quản lý Issue
- `list_issues` - Liệt kê tất cả các issues
- `get_issue` - Lấy chi tiết issue
- `create_issue` - Tạo issue mới
- `close_issue` - Đóng issue
- `add_comment` - Thêm bình luận vào issue

## Thông tin Kho mã nguồn
- `get_repo_info` - Chi tiết repo
- `list_files` - Cấu trúc cây thư mục
- `get_file_content` - Đọc nội dung tệp
- `search_code` - Tìm kiếm trong toàn bộ mã nguồn

## Các thao tác Commit
- `list_commits` - Lịch sử commit
- `get_commit` - Chi tiết một commit cụ thể
- `create_commit` - Tạo commit mới
~~~~

#### Ví dụ 2: Thiết lập Database MCP

**Cấu hình:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-database"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost/mydb"
      }
    }
  }
}
```

**Sử dụng ví dụ:**

```markdown
Người dùng: Lấy tất cả người dùng có hơn 10 đơn hàng

Claude: Tôi sẽ truy vấn cơ sở dữ liệu của bạn để tìm thông tin đó.

# Sử dụng công cụ database MCP:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Kết quả:
- Alice: 15 đơn hàng
- Bob: 12 đơn hàng
- Charlie: 11 đơn hàng
```

#### Ví dụ 3: Quy trình làm việc đa MCP (Multi-MCP)

**Kịch bản: Tạo báo cáo hàng ngày**

```markdown
# Quy trình báo cáo hàng ngày sử dụng nhiều MCP

## Thiết lập
1. GitHub MCP - lấy các chỉ số PR
2. Database MCP - truy vấn dữ liệu bán hàng
3. Slack MCP - đăng bài báo cáo
4. Filesystem MCP - lưu báo cáo

## Quy trình

### Bước 1: Lấy dữ liệu từ GitHub
/mcp__github__list_prs completed:true last:7days

Đầu ra:
- Tổng số PR: 42
- Thời gian merge trung bình: 2.3 giờ
- Thời gian phản hồi review: 1.1 giờ

### Bước 2: Truy vấn cơ sở dữ liệu
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

Đầu ra:
- Số đơn hàng: 247
- Doanh thu: $12,450

### Bước 3: Tạo báo cáo
Kết hợp dữ liệu vào báo cáo HTML

### Bước 4: Lưu vào hệ thống tệp
Ghi file report.html vào thư mục /reports/

### Bước 5: Đăng lên Slack
Gửi bản tóm tắt vào kênh #daily-reports

Kết quả cuối cùng:
✅ Báo cáo đã được tạo và đăng tải
📊 47 PR đã được merge trong tuần này
💰 Doanh thu hàng ngày đạt $12,450
```

#### Ví dụ 4: Các thao tác Filesystem MCP

**Cấu hình:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**Các thao tác có sẵn:**

| Thao tác | Lệnh | Mục đích |
|-----------|---------|---------|
| Liệt kê tệp | `ls ~/projects` | Hiển thị nội dung thư mục |
| Đọc tệp | `cat src/main.ts` | Đọc nội dung tệp |
| Ghi tệp | `create docs/api.md` | Tạo tệp mới |
| Sửa tệp | `edit src/app.ts` | Thay đổi tệp |
| Tìm kiếm | `grep "async function"` | Tìm kiếm trong các tệp |
| Xóa | `rm old-file.js` | Xóa tệp |

### MCP vs Memory: Ma trận quyết định

```mermaid
graph TD
    A["Cần dữ liệu bên ngoài?"]
    A -->|Không| B["Sử dụng Memory"]
    A -->|Có| C["Dữ liệu có thay đổi thường xuyên không?"]
    C -->|Không hoặc hiếm khi| B
    C -->|Có hoặc thường xuyên| D["Sử dụng MCP"]

    B -->|Lưu trữ| E["Ưu tiên<br/>Ngữ cảnh<br/>Lịch sử"]
    D -->|Truy cập| F["Live APIs<br/>Cơ sở dữ liệu<br/>Dịch vụ"]

    style B fill:#e1f5ff
    style D fill:#fff9c4
```

### Mô hình Yêu cầu/Phản hồi (Request/Response)

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Cơ sở dữ liệu

    App->>MCP: Yêu cầu: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Thực thi truy vấn
    DB-->>MCP: Tập kết quả
    MCP-->>App: Trả về dữ liệu đã phân tích
    App->>App: Xử lý kết quả
    App->>App: Tiếp tục tác vụ

    Note over MCP,DB: Truy cập thời gian thực<br/>Không có bộ nhớ đệm
```

---

## Agent Skills

### Tổng quan

Agent Skills là những khả năng có thể tái sử dụng, do mô hình gọi ra, được đóng gói dưới dạng các thư mục chứa hướng dẫn, script và tài nguyên. Claude tự động phát hiện và sử dụng các skill liên quan.

### Kiến trúc Skill

```mermaid
graph TB
    A["Thư mục Skill"]
    B["SKILL.md"]
    C["Siêu dữ liệu YAML"]
    D["Hướng dẫn"]
    E["Các Script"]
    F["Các Template"]

    A --> B
    B --> C
    B --> D
    E --> A
    F --> A
```

### Quy trình tải Skill

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude
    participant System as Hệ thống
    participant Skill as Skill

    User->>Claude: "Tạo báo cáo Excel"
    Claude->>System: Quét các skill có sẵn
    System->>System: Tải siêu dữ liệu skill
    Claude->>Claude: Khớp yêu cầu người dùng với các skill
    Claude->>Skill: Tải tệp SKILL.md của skill xlsx
    Skill-->>Claude: Trả về hướng dẫn + công cụ
    Claude->>Claude: Thực thi skill
    Claude->>User: Tạo tệp Excel
```

### Bảng các loại Skill & Vị trí

| Loại | Vị trí | Phạm vi | Chia sẻ | Đồng bộ | Phù hợp cho |
|------|----------|-------|--------|------|----------|
| Tích hợp sẵn | Built-in | Toàn cầu | Mọi người dùng | Tự động | Tạo tài liệu |
| Cá nhân | `~/.claude/skills/` | Cá nhân | Không | Thủ công | Tự động hóa cá nhân |
| Dự án | `.claude/skills/` | Nhóm | Có | Git | Tiêu chuẩn nhóm |
| Plugin | Qua cài đặt plugin | Thay đổi | Tùy thuộc | Tự động | Các tính năng tích hợp |

### Các Skill tích hợp sẵn (Pre-built Skills)

```mermaid
graph TB
    A["Các Skill tích hợp sẵn"]
    B["PowerPoint (pptx)"]
    C["Excel (xlsx)"]
    D["Word (docx)"]
    E["PDF"]

    A --> B
    A --> C
    A --> D
    A --> E

    B --> B1["Tạo bài thuyết trình"]
    B --> B2["Chỉnh sửa slide"]
    C --> C1["Tạo bảng tính"]
    C --> C2["Phân tích dữ liệu"]
    D --> D1["Tạo tài liệu"]
    D --> D2["Định dạng văn bản"]
    E --> E1["Tạo tệp PDF"]
    E --> E2["Điền biểu mẫu"]
```

### Các Skill đi kèm (Bundled Skills)

Claude Code hiện bao gồm 5 skill đi kèm sẵn có:

| Skill | Lệnh | Mục đích |
|-------|---------|---------|
| **Simplify** | `/simplify` | Đơn giản hóa mã phức tạp hoặc các giải thích |
| **Batch** | `/batch` | Chạy các thao tác trên nhiều tệp hoặc mục |
| **Debug** | `/debug` | Sửa lỗi hệ thống với phân tích nguyên nhân gốc rễ |
| **Loop** | `/loop` | Lên lịch các tác vụ định kỳ theo thời gian |
| **Claude API** | `/claude-api` | Tương tác trực tiếp với Anthropic API |

Các skill này luôn sẵn có và không yêu cầu cài đặt hay cấu hình thêm.

### Ví dụ thực tế

#### Ví dụ 1: Skill Review mã nguồn tùy chỉnh

**Cấu trúc thư mục:**

```
~/.claude/skills/code-review/
├── SKILL.md
├── templates/
│   ├── review-checklist.md
│   └── finding-template.md
└── scripts/
    ├── analyze-metrics.py
    └── compare-complexity.py
```

**Tệp:** `~/.claude/skills/code-review/SKILL.md`

```yaml
---
name: Chuyên gia Review Mã nguồn
description: Review mã nguồn toàn diện tập trung vào bảo mật, hiệu suất và chất lượng
version: "1.0.0"
tags:
  - code-review
  - quality
  - security
when_to_use: Khi người dùng yêu cầu review mã, phân tích chất lượng hoặc đánh giá pull request
effort: high
shell: bash
---

# Skill Review Mã nguồn

Skill này cung cấp các khả năng review mã nguồn toàn diện tập trung vào:

1. **Phân tích bảo mật**
   - Các vấn đề xác thực/phân quyền
   - Rủi ro lộ dữ liệu
   - Các lỗ hổng injection
   - Điểm yếu mã hóa
   - Việc log dữ liệu nhạy cảm

2. **Đánh giá hiệu suất**
   - Hiệu quả thuật toán (phân tích Big O)
   - Tối ưu hóa bộ nhớ
   - Tối ưu hóa truy vấn cơ sở dữ liệu
   - Các cơ hội sử dụng bộ nhớ đệm
   - Các vấn đề về đồng thời

3. **Chất lượng mã nguồn**
   - Các nguyên tắc SOLID
   - Các mẫu thiết kế (Design patterns)
   - Các quy ước đặt tên
   - Tài liệu
   - Độ bao phủ kiểm thử

4. **Khả năng bảo trì**
   - Độ dễ đọc của mã
   - Kích thước hàm (nên < 50 dòng)
   - Độ phức tạp vòng đời (Cyclomatic complexity)
   - Quản lý phụ thuộc
   - Type safety

## Mẫu Review

Với mỗi đoạn mã được review, hãy cung cấp:

### Tóm tắt (Summary)
- Đánh giá chất lượng tổng thể (1-5)
- Số lượng các phát hiện chính
- Các khu vực ưu tiên khuyến nghị

### Các vấn đề nghiêm trọng (nếu có)
- **Vấn đề**: Mô tả rõ ràng
- **Vị trí**: Tên tệp và số dòng
- **Tác động**: Tại sao điều này lại quan trọng
- **Mức độ**: Critical/High/Medium
- **Cách sửa**: Ví dụ mã

### Các phát hiện theo hạng mục

#### Bảo mật (nếu tìm thấy vấn đề)
Liệt kê các lỗ hổng bảo mật kèm ví dụ

#### Hiệu suất (nếu tìm thấy vấn đề)
Liệt kê các vấn đề hiệu suất kèm phân tích độ phức tạp

#### Chất lượng (nếu tìm thấy vấn đề)
Liệt kê các vấn đề chất lượng mã kèm gợi ý tái cấu trúc

#### Khả năng bảo trì (nếu tìm thấy vấn đề)
Liệt kê các vấn đề bảo trì kèm các cải tiến
```

## Python Script: analyze-metrics.py

```python
#!/usr/bin/env python3
import re
import sys

def analyze_code_metrics(code):
    """Phân tích mã nguồn cho các chỉ số phổ biến."""

    # Đếm số hàm
    functions = len(re.findall(r'^def\s+\w+', code, re.MULTILINE))

    # Đếm số lớp
    classes = len(re.findall(r'^class\s+\w+', code, re.MULTILINE))

    # Độ dài dòng trung bình
    lines = code.split('\n')
    avg_length = sum(len(l) for l in lines) / len(lines) if lines else 0

    # Ước tính độ phức tạp
    complexity = len(re.findall(r'\b(if|elif|else|for|while|and|or)\b', code))

    return {
        'functions': functions,
        'classes': classes,
        'avg_line_length': avg_length,
        'complexity_score': complexity
    }

if __name__ == '__main__':
    with open(sys.argv[1], 'r') as f:
        code = f.read()
    metrics = analyze_code_metrics(code)
    for key, value in metrics.items():
        print(f"{key}: {value:.2f}")
```

## Python Script: compare-complexity.py

```python
#!/usr/bin/env python3
"""
So sánh độ phức tạp cyclomatic của mã nguồn trước và sau khi thay đổi.
Giúp xác định xem việc tái cấu trúc có thực sự làm đơn giản hóa cấu trúc mã hay không.
"""

import re
import sys
from typing import Dict, Tuple

class ComplexityAnalyzer:
    """Phân tích các chỉ số độ phức tạp của mã nguồn."""

    def __init__(self, code: str):
        self.code = code
        self.lines = code.split('\n')

    def calculate_cyclomatic_complexity(self) -> int:
        """
        Tính toán độ phức tạp cyclomatic bằng phương pháp của McCabe.
        Đếm các điểm quyết định: if, elif, else, for, while, except, and, or
        """
        complexity = 1  # Độ phức tạp cơ bản

        # Đếm các điểm quyết định
        decision_patterns = [
            r'\bif\b',
            r'\belif\b',
            r'\bfor\b',
            r'\bwhile\b',
            r'\bexcept\b',
            r'\band\b(?!$)',
            r'\bor\b(?!$)'
        ]

        for pattern in decision_patterns:
            matches = re.findall(pattern, self.code)
            complexity += len(matches)

        return complexity

    def calculate_cognitive_complexity(self) -> int:
        """
        Tính toán độ phức tạp nhận thức - mã nguồn khó hiểu đến mức nào?
        Dựa trên độ sâu lồng nhau và luồng điều khiển.
        """
        cognitive = 0
        nesting_depth = 0

        for line in self.lines:
            # Theo dõi độ sâu lồng nhau
            if re.search(r'^\s*(if|for|while|def|class|try)\b', line):
                nesting_depth += 1
                cognitive += nesting_depth
            elif re.search(r'^\s*(elif|else|except|finally)\b', line):
                cognitive += nesting_depth

            # Giảm độ sâu khi thoát khỏi khối
            if line and not line[0].isspace():
                nesting_depth = 0

        return cognitive

    def calculate_maintainability_index(self) -> float:
        """
        Chỉ số khả năng bảo trì nằm trong khoảng 0-100.
        > 85: Tuyệt vời
        > 65: Tốt
        > 50: Khá
        < 50: Kém
        """
        lines = len(self.lines)
        cyclomatic = self.calculate_cyclomatic_complexity()
        cognitive = self.calculate_cognitive_complexity()

        # Công thức MI đơn giản hóa
        mi = 171 - 5.2 * (cyclomatic / lines) - 0.23 * (cognitive) - 16.2 * (lines / 1000)

        return max(0, min(100, mi))

    def get_complexity_report(self) -> Dict:
        """Tạo báo cáo độ phức tạp toàn diện."""
        return {
            'cyclomatic_complexity': self.calculate_cyclomatic_complexity(),
            'cognitive_complexity': self.calculate_cognitive_complexity(),
            'maintainability_index': round(self.calculate_maintainability_index(), 2),
            'lines_of_code': len(self.lines),
            'avg_line_length': round(sum(len(l) for l in self.lines) / len(self.lines), 2) if self.lines else 0
        }


def compare_files(before_file: str, after_file: str) -> None:
    """So sánh các chỉ số phức tạp giữa hai phiên bản mã nguồn."""

    with open(before_file, 'r') as f:
        before_code = f.read()

    with open(after_file, 'r') as f:
        after_code = f.read()

    before_analyzer = ComplexityAnalyzer(before_code)
    after_analyzer = ComplexityAnalyzer(after_code)

    before_metrics = before_analyzer.get_complexity_report()
    after_metrics = after_analyzer.get_complexity_report()

    print("=" * 60)
    print("SO SÁNH ĐỘ PHỨC TẠP MÃ NGUỒN")
    print("=" * 60)

    print("\nTRƯỚC KHI THAY ĐỔI:")
    print(f"  Độ phức tạp Cyclomatic:    {before_metrics['cyclomatic_complexity']}")
    print(f"  Độ phức tạp Nhận thức:      {before_metrics['cognitive_complexity']}")
    print(f"  Chỉ số Khả năng Bảo trì:    {before_metrics['maintainability_index']}")
    print(f"  Số dòng mã:                {before_metrics['lines_of_code']}")
    print(f"  Độ dài dòng trung bình:    {before_metrics['avg_line_length']}")

    print("\nSAU KHI THAY ĐỔI:")
    print(f"  Độ phức tạp Cyclomatic:    {after_metrics['cyclomatic_complexity']}")
    print(f"  Độ phức tạp Nhận thức:      {after_metrics['cognitive_complexity']}")
    print(f"  Chỉ số Khả năng Bảo trì:    {after_metrics['maintainability_index']}")
    print(f"  Số dòng mã:                {after_metrics['lines_of_code']}")
    print(f"  Độ dài dòng trung bình:    {after_metrics['avg_line_length']}")

    print("\nTHAY ĐỔI:")
    cyclomatic_change = after_metrics['cyclomatic_complexity'] - before_metrics['cyclomatic_complexity']
    cognitive_change = after_metrics['cognitive_complexity'] - before_metrics['cognitive_complexity']
    mi_change = after_metrics['maintainability_index'] - before_metrics['maintainability_index']
    loc_change = after_metrics['lines_of_code'] - before_metrics['lines_of_code']

    print(f"  Độ phức tạp Cyclomatic:    {cyclomatic_change:+d}")
    print(f"  Độ phức tạp Nhận thức:      {cognitive_change:+d}")
    print(f"  Chỉ số Khả năng Bảo trì:    {mi_change:+.2f}")
    print(f"  Số dòng mã:                {loc_change:+d}")

    print("\nĐÁNH GIÁ:")
    if mi_change > 0:
        print("  ✅ Mã nguồn DỄ BẢO TRÌ HƠN")
    elif mi_change < 0:
        print("  ⚠️  Mã nguồn KHÓ BẢO TRÌ HƠN")
    else:
        print("  ➡️  Khả năng bảo trì không đổi")
e versions."""

    with open(before_fconst users = fetchUsers();
users.forEach(user => {
  const posts = fetchUserPosts(user.id); // Truy vấn theo từng user! (Lỗi N+1)
  renderUserPosts(posts);
});
```

#### Cách sửa đề xuất

```typescript
// Được tối ưu hóa với truy vấn JOIN
const usersWithPosts = fetchUsersWithPosts();
usersWithPosts.forEach(({ user, posts }) => {
  renderUserPosts(posts);
});
```

### Phân tích tác động

| Khía cạnh | Tác động | Mức độ nghiêm trọng |
|-----------|----------|-----------------------|
| Hiệu suất | >100 truy vấn cho 20 người dùng | Cao |
| Trải nghiệm người dùng | Trang tải chậm | Cao |
| Khả năng mở rộng | Gây treo hệ thống khi dữ liệu lớn | Nghiêm trọng |
| Khả năng bảo trì | Khó debug | Trung bình |

### Các Issue liên quan

- Lỗi tương tự trong `AdminUserList.tsx` dòng 120
- PR liên quan: #456
- Issue liên quan: #789

### Tài nguyên bổ sung

- [Vấn đề truy vấn N+1](https://en.wikipedia.org/wiki/N%2B1_problem)
- [Tài liệu về Database Join](https://docs.example.com/joins)
- [Hướng dẫn tối ưu hiệu suất](./docs/performance.md)

### Ghi chú của Reviewer

- Đây là một pattern phổ biến trong codebase này
- Cân nhắc thêm nội dung này vào hướng dẫn phong cách code (code style guide)
- Có thể nên tạo một hàm helper dùng chung

### Phản hồi của tác giả (để nhận feedback)

*Phần này dành cho tác giả của mã nguồn điền vào:*

- [ ] Đã sửa trong commit: `abc123`
- [ ] Trạng thái sửa lỗi: Hoàn thành / Đang thực hiện / Cần thảo luận
- [ ] Câu hỏi hoặc lo ngại: (mô tả)

---

## Thống kê phát hiện (Dành cho Reviewer)

Khi review nhiều phát hiện, hãy theo dõi:

- **Tổng số vấn đề tìm thấy:** X
- **Nghiêm trọng (Critical):** X
- **Cao (High):** X
- **Trung bình (Medium):** X
- **Thấp (Low):** X

**Khuyến nghị:** ✅ Phê duyệt (Approve) / ⚠️ Yêu cầu thay đổi (Request Changes) / 🔄 Cần thảo luận thêm

**Chất lượng code tổng thể:** 1-5 sao
~~~~

## Ví dụ sử dụng

~~~~markdown
Người dùng: Review đoạn code React component này giúp tôi

Claude: Tôi sẽ tiến hành review mã nguồn toàn diện bằng Skill Review Mã nguồn của mình.

[Tải SKILL.md]
[Phân tích code dựa trên checklist]
[Chạy script Python phân tích chỉ số]
[Áp dụng các mẫu template]

## Kết quả Review Mã nguồn

### Tóm tắt
Điểm chất lượng: 3.5/5
Các phát hiện chính: 7 mục
Khu vực ưu tiên: Tối ưu hiệu suất, xử lý lỗi

### Các vấn đề nghiêm trọng: 1

**Vấn đề**: Lỗi truy vấn N+1 (N+1 Query Problem)
**Vị trí**: UserComponent.tsx, dòng 45-52
**Tác động**: Thực thi >100 truy vấn DB cho danh sách 20 người dùng
**Mức độ nghiêm trọng**: Cao
**Cách sửa**:
```javascript
// Trước: N+1 truy vấn
const users = fetchUsers();
users.forEach(user => fetchUserPosts(user.id)); // 20+ truy vấn

// Sau: Truy vấn đơn với JOIN
const users = fetchUsersWithPosts(); // 1 truy vấn duy nhất
```

### Phát hiện về Hiệu suất
- Thiếu phân trang (pagination) cho danh sách lớn
- Khuyến nghị: Sử dụng React.memo() cho các item
- Truy vấn DB: Có thể tối ưu hóa bằng index

### Phát hiện về Chất lượng
- Hàm ở dòng 20 dài 127 dòng (tối đa: 50)
- Thiếu error boundary
- Props nên có kiểu dữ liệu TypeScript
~~~~

#### Ví dụ 2: Skill Giọng văn Thương hiệu (Brand Voice)

**Cấu trúc thư mục:**

```
.claude/skills/brand-voice/
├── SKILL.md
├── brand-guidelines.md
├── tone-examples.md
└── templates/
    ├── email-template.txt
    ├── social-post-template.txt
    └── blog-post-template.md
```

**Tệp:** `.claude/skills/brand-voice/SKILL.md`

```yaml
---
name: Tính nhất quán của Thương hiệu
description: Đảm bảo mọi giao tiếp phù hợp với hướng dẫn về giọng văn và tông điệu thương hiệu
tags:
  - brand
  - writing
  - consistency
when_to_use: Khi tạo nội dung marketing, giao tiếp với khách hàng hoặc nội dung công khai
---

# Skill Giọng văn Thương hiệu

## Tổng quan
Skill này đảm bảo mọi giao tiếp duy trì tính nhất quán về giọng văn, tông điệu và thông điệp thương hiệu.

## Bản sắc Thương hiệu

### Sứ mệnh
Giúp các đội ngũ tự động hóa quy trình phát triển của họ bằng AI

### Giá trị cốt lõi
- **Sự đơn giản**: Làm cho những điều phức tạp trở nên đơn giản
- **Sự tin cậy**: Thực thi vững chắc như bàn thạch
- **Sự trao quyền**: Thúc đẩy khả năng sáng tạo của con người

### Tông điệu (Tone of Voice)
- **Thân thiện nhưng chuyên nghiệp** - dễ tiếp cận nhưng không suồng sã
- **Rõ ràng và ngắn gọn** - tránh thuật ngữ khó hiểu, giải thích các khái niệm kỹ thuật một cách đơn giản
- **Tự tin** - chúng tôi biết mình đang làm gì
- **Thấu hiểu** - hiểu nhu cầu và khó khăn của người dùng

## Hướng dẫn Viết

### Nên làm ✅
- Sử dụng "bạn" khi xưng hô với người đọc
- Sử dụng câu chủ động: "Claude tạo báo cáo" thay vì "Báo cáo được tạo bởi Claude"
- Bắt đầu với giá trị mang lại (value proposition)
- Sử dụng các ví dụ cụ thể
- Giữ câu văn dưới 20 từ
- Sử dụng danh sách (list) để tăng độ rõ ràng
- Bao gồm lời kêu gọi hành động (CTA)

### Không nên làm ❌
- Không sử dụng thuật ngữ doanh nghiệp sáo rỗng (corporate jargon)
- Không trịch thượng hoặc làm đơn giản hóa quá mức
- Không sử dụng "chúng tôi tin rằng" hoặc "chúng tôi nghĩ rằng"
- Không viết HOA TOÀN BỘ trừ khi muốn nhấn mạnh
- Không tạo ra những "bức tường văn bản" quá dài
- Không mặc định người dùng đã có kiến thức kỹ thuật

## Từ vựng

### ✅ Thuật ngữ ưu tiên
- Claude (không phải "AI Claude")
- Tạo mã nguồn (không phải "code tự động")
- Agent (không phải "bot")
- Tối ưu hóa (không phải "cách mạng hóa")
- Tích hợp (không phải "hiệp lực")

### ❌ Thuật ngữ cần tránh
- "Đỉnh cao/Hàng đầu" (bị lạm dụng)
- "Thay đổi cuộc chơi" (mơ hồ)
- "Tận dụng/Đòn bẩy" (văn phong công sở sáo rỗng)
- "Vận dụng" (hãy dùng "sử dụng")
- "Bước ngoặt lịch sử" (không rõ ràng)
```

## Ví dụ

### ✅ Ví dụ Tốt
"Claude tự động hóa quy trình review mã nguồn của bạn. Thay vì kiểm tra từng PR một cách thủ công, Claude sẽ review bảo mật, hiệu suất và chất lượng—giúp đội ngũ của bạn tiết kiệm hàng giờ mỗi tuần."

Tại sao hiệu quả: Giá trị rõ ràng, lợi ích cụ thể, hướng tới hành động.

### ❌ Ví dụ Xấu
"Claude vận dụng AI đỉnh cao để cung cấp các giải pháp phát triển phần mềm toàn diện."

Tại sao không hiệu quả: Mơ hồ, dùng thuật ngữ sáo rỗng, không có giá trị cụ thể.

## Template: Email

```
Tiêu đề: [Tiêu đề rõ ràng, hướng tới lợi ích]

Chào [Tên],

[Mở đầu: Giá trị mang lại cho họ là gì]

[Thân bài: Cách thức hoạt động / Họ sẽ nhận được gì]

[Ví dụ hoặc lợi ích cụ thể]

[Lời kêu gọi hành động: Bước tiếp theo rõ ràng]

Trân trọng,
[Tên]
```

## Template: Mạng xã hội

```
[Hook: Thu hút sự chú ý ngay dòng đầu tiên]
[2-3 dòng: Giá trị hoặc sự thật thú vị]
[Lời kêu gọi hành động: Link, câu hỏi hoặc tương tác]
[Emoji: Tối đa 1-2 cái để tăng sự thú vị]
```

## Tệp: tone-examples.md
```
Thông báo hào hứng:
"Tiết kiệm 8 giờ mỗi tuần cho việc review code. Claude sẽ review PR của bạn một cách tự động."

Hỗ trợ thấu hiểu:
"Chúng tôi hiểu rằng việc deploy có thể rất căng thẳng. Claude sẽ đảm nhận phần kiểm thử để bạn không còn phải lo lắng."

Tính năng sản phẩm tự tin:
"Claude không chỉ gợi ý code. Nó hiểu kiến trúc của bạn và duy trì tính nhất quán."

Bài blog giáo dục:
"Hãy cùng khám phá cách các agent cải thiện quy trình review mã nguồn. Đây là những gì chúng tôi đã học được..."
```

#### Ví dụ 3: Skill Tạo Tài liệu (Documentation Generator)

**Tệp:** `.claude/skills/doc-generator/SKILL.md`

~~~~yaml
---
name: Trình tạo Tài liệu API
description: Tạo tài liệu API toàn diện và chính xác từ mã nguồn
version: "1.0.0"
tags:
  - documentation
  - api
  - automation
when_to_use: Khi tạo mới hoặc cập nhật tài liệu API
---

# Skill Trình tạo Tài liệu API

## Các sản phẩm tạo ra

- Đặc tả OpenAPI/Swagger
- Tài liệu chi tiết các endpoint API
- Ví dụ sử dụng SDK
- Hướng dẫn tích hợp
- Danh mục mã lỗi (error codes)
- Hướng dẫn xác thực

## Cấu trúc Tài liệu

### Cho mỗi Endpoint

```markdown
## GET /api/v1/users/:id

### Mô tả
Giải thích ngắn gọn endpoint này làm gì

### Tham số

| Tên | Kiểu | Bắt buộc | Mô tả |
|-----|------|----------|-------|
| id | string | Có | ID người dùng |

### Phản hồi

**200 Thành công**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Không tìm thấy**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "Người dùng không tồn tại"
}
```

### Ví dụ

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```

## Script Python: generate-docs.py

```python
#!/usr/bin/env python3
import ast
import json
from typing import Dict, List

class APIDocExtractor(ast.NodeVisitor):
    """Trích xuất tài liệu API từ mã nguồn Python."""

    def __init__(self):
        self.endpoints = []

    def visit_FunctionDef(self, node):
        """Trích xuất tài liệu của hàm."""
        if node.name.startswith('get_') or node.name.startswith('post_'):
            doc = ast.get_docstring(node)
            endpoint = {
                'name': node.name,
                'docstring': doc,
                'params': [arg.arg for arg in node.args.args],
                'returns': self._extract_return_type(node)
            }
            self.endpoints.append(endpoint)
        self.generic_visit(node)

    def _extract_return_type(self, node):
        """Trích xuất kiểu dữ liệu trả về từ annotation của hàm."""
        if node.returns:
            return ast.unparse(node.returns)
        return "Any"

def generate_markdown_docs(endpoints: List[Dict]) -> str:
    """Tạo tài liệu markdown từ danh sách endpoint."""
    docs = "# Tài liệu API\n\n"

    for endpoint in endpoints:
        docs += f"## {endpoint['name']}\n\n"
        docs += f"{endpoint['docstring']}\n\n"
        docs += f"**Tham số**: {', '.join(endpoint['params'])}\n\n"
        docs += f"**Kiểu trả về**: {endpoint['returns']}\n\n"
        docs += "---\n\n"

    return docs

if __name__ == '__main__':
    import sys
    with open(sys.argv[1], 'r') as f:
        tree = ast.parse(f.read())

    extractor = APIDocExtractor()
    extractor.visit(tree)

    markdown = generate_markdown_docs(extractor.endpoints)
    print(markdown)
```
~~~~

### Quy trình Phát hiện & Gọi Skill

```mermaid
graph TD
    A["Yêu cầu người dùng"] --> B["Claude phân tích"]
    B -->|Quét| C["Các Skill có sẵn"]
    C -->|Kiểm tra Metadata| D["Mô tả Skill phù hợp?"]
    D -->|Có| E["Tải SKILL.md"]
    D -->|Không| F["Thử Skill tiếp theo"]
    F -->|Còn Skill?| D
    F -->|Hết Skill| G["Sử dụng kiến thức chung"]
    E --> H["Trích xuất hướng dẫn"]
    H --> I["Thực thi Skill"]
    I --> J["Trả về kết quả"]
```

### So sánh Skill với các tính năng khác

```mermaid
graph TB
    A["Mở rộng Claude"]
    B["Slash Commands"]
    C["Subagents"]
    D["Memory"]
    E["MCP"]
    F["Skills"]

    A --> B
    A --> C
    A --> D
    A --> E
    A --> F

    B -->|Người dùng gọi| G["Phím tắt nhanh"]
    C -->|Tự động ủy quyền| H["Ngữ cảnh cô lập"]
    D -->|Lưu trữ lâu dài| I["Ngữ cảnh đa phiên"]
    E -->|Thời gian thực| J["Truy cập dữ liệu ngoài"]
    F -->|Tự động gọi| K["Thực thi tự chủ"]
```

---

## Claude Code Plugins

### Tổng quan

Claude Code Plugins là tập hợp các tùy chỉnh (slash lệnh, subagents, MCP server và hooks) được đóng gói và cài đặt chỉ với một lệnh duy nhất. Chúng đại diện cho cơ chế mở rộng cấp cao nhất—kết hợp nhiều tính năng thành các gói thống nhất và có thể chia sẻ.

### Kiến trúc Plugin

```mermaid
graph TB
    A["Plugin"]
    B["Slash Commands"]
    C["Subagents"]
    D["MCP Servers"]
    E["Hooks"]
    F["Cấu hình"]

    A -->|đóng gói| B
    A -->|đóng gói| C
    A -->|đóng gói| D
    A -->|đóng gói| E
    A -->|đóng gói| F
```

### Quy trình tải Plugin

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Plugin as Chợ Plugin
    participant Install as Cài đặt
    participant SlashCmds as Slash Commands
    participant Subagents
    participant MCPServers as MCP Servers
    participant Hooks
    participant Tools as Công cụ đã cấu hình

    User->>Claude: /plugin install pr-review
    Claude->>Plugin: Tải plugin manifest
    Plugin-->>Claude: Trả về định nghĩa plugin
    Claude->>Install: Trích xuất các thành phần
    Install->>SlashCmds: Cấu hình
    Install->>Subagents: Cấu hình
    Install->>MCPServers: Cấu hình
    Install->>Hooks: Cấu hình
    SlashCmds-->>Tools: Sẵn sàng sử dụng
    Subagents-->>Tools: Sẵn sàng sử dụng
    MCPServers-->>Tools: Sẵn sàng sử dụng
    Hooks-->>Tools: Sẵn sàng sử dụng
    Tools-->>Claude: Đã cài đặt Plugin ✅
```

### Loại Plugin & Phân phối

| Loại | Phạm vi | Chia sẻ | Thẩm quyền | Ví dụ |
|------|---------|---------|-----------|--------|
| Chính thức | Toàn cầu | Mọi người dùng | Anthropic | Review PR, Hướng dẫn bảo mật |
| Cộng đồng | Công khai | Mọi người dùng | Cộng đồng | DevOps, Khoa học dữ liệu |
| Tổ chức | Nội bộ | Thành viên nhóm | Công ty | Tiêu chuẩn nội bộ, công cụ riêng |
| Cá nhân | Cá nhân | Một người dùng | Nhà phát triển | Quy trình làm việc tùy chỉnh |

### Cấu trúc định nghĩa Plugin

```yaml
---
name: ten-plugin
version: "1.0.0"
description: "Plugin này làm gì"
author: "Tên của bạn"
license: MIT

# Siêu dữ liệu plugin
tags:
  - danh-muc
  - truong-hop-su-dung

# Yêu cầu
requires:
  - claude-code: ">=1.0.0"

# Các thành phần đi kèm
components:
  - type: commands
    path: commands/
  - type: agents
    path: agents/
  - type: mcp
    path: mcp/
  - type: hooks
    path: hooks/

# Cấu hình
config:
  auto_load: true
  enabled_by_default: true
---
```

### Cấu trúc thư mục Plugin

```
my-plugin/
├── .claude-plugin/
│   └── plugin.json
├── commands/
│   ├── task-1.md
│   ├── task-2.md
│   └── workflows/
├── agents/
│   ├── specialist-1.md
│   ├── specialist-2.md
│   └── configs/
├── skills/
│   ├── skill-1.md
│   └── skill-2.md
├── hooks/
│   └── hooks.json
├── .mcp.json
├── .lsp.json
├── settings.json
├── templates/
│   └── issue-template.md
├── scripts/
│   ├── helper-1.sh
│   └── helper-2.py
├── docs/
│   ├── README.md
│   └── USAGE.md
└── tests/
    └── plugin.test.js
```

### Ví dụ thực tế

#### Ví dụ 1: Plugin Review PR

**Tệp:** `.claude-plugin/plugin.json`

```json
{
  "name": "pr-review",
  "version": "1.0.0",
  "description": "Toàn bộ quy trình review PR với bảo mật, kiểm thử và tài liệu",
  "author": {
    "name": "Anthropic"
  },
  "license": "MIT"
}
```

**Tệp:** `commands/review-pr.md`

```markdown
---
name: Review PR
description: Bắt đầu review PR toàn diện với các kiểm tra bảo mật và kiểm thử
---

# PR Review

Lệnh này bắt đầu một quy trình review pull request đầy đủ bao gồm:

1. Phân tích bảo mật
2. Xác minh độ bao phủ kiểm thử
3. Cập nhật tài liệu
4. Kiểm tra chất lượng code
5. Đánh giá tác động hiệu suất
```

**Tệp:** `agents/security-reviewer.md`

```yaml
---
name: security-reviewer
description: Review mã nguồn tập trung vào bảo mật
tools: read, grep, diff
---

# Chuyên gia Review Bảo mật

Chuyên sâu vào việc tìm kiếm các lỗ hổng bảo mật:
- Các vấn đề xác thực/phân quyền
- Rò rỉ dữ liệu
- Các cuộc tấn công Injection
- Cấu hình bảo mật
```

**Cài đặt:**

```bash
/plugin install pr-review

# Kết quả:
# ✅ Đã cài đặt 3 slash lệnh
# ✅ Đã cấu hình 3 subagents
# ✅ Đã kết nối 2 MCP server
# ✅ Đã đăng ký 4 hooks
# ✅ Sẵn sàng sử dụng!
```

#### Ví dụ 2: Plugin DevOps

**Các thành phần:**

```
devops-automation/
├── commands/
│   ├── deploy.md
│   ├── rollback.md
│   ├── status.md
│   └── incident.md
├── agents/
│   ├── deployment-specialist.md
│   ├── incident-commander.md
│   └── alert-analyzer.md
├── mcp/
│   ├── github-config.json
│   ├── kubernetes-config.json
│   └── prometheus-config.json
├── hooks/
│   ├── pre-deploy.js
│   ├── post-deploy.js
│   └── on-error.js
└── scripts/
    ├── deploy.sh
    ├── rollback.sh
    └── health-check.sh
```

#### Ví dụ 3: Plugin Tài liệu (Documentation)

**Các thành phần đi kèm:**

```
documentation/
├── commands/
│   ├── generate-api-docs.md
│   ├── generate-readme.md
│   ├── sync-docs.md
│   └── validate-docs.md
├── agents/
│   ├── api-documenter.md
│   ├── code-commentator.md
│   └── example-generator.md
├── mcp/
│   ├── github-docs-config.json
│   └── slack-announce-config.json
└── templates/
    ├── api-endpoint.md
    ├── function-docs.md
    └── adr-template.md
```

### Plugin Marketplace (Chợ Plugin)

```mermaid
graph TB
    A["Chợ Plugin"]
    B["Chính thức<br/>Anthropic"]
    C["Chợ ứng dụng<br/>Cộng đồng"]
    D["Kho lưu trữ<br/>Doanh nghiệp"]

    A --> B
    A --> C
    A --> D

    B -->|Danh mục| B1["Phát triển"]
    B -->|Danh mục| B2["DevOps"]
    B -->|Danh mục| B3["Tài liệu"]

    C -->|Tìm kiếm| C1["Tự động hóa DevOps"]
    C -->|Tìm kiếm| C2["Phát triển Mobile"]
    C -->|Tìm kiếm| C3["Khoa học dữ liệu"]

    D -->|Nội bộ| D1["Tiêu chuẩn công ty"]
    D -->|Nội bộ| D2["Hệ thống cũ (Legacy)"]
    D -->|Nội bộ| D3["Tuân thủ (Compliance)"]
```

### Cài đặt Plugin & Vòng đời

```mermaid
graph LR
    A["Khám phá"] -->|Duyệt| B["Marketplace"]
    B -->|Chọn| C["Trang Plugin"]
    C -->|Xem| D["Các thành phần"]
    D -->|Cài đặt| E["/plugin install"]
    E -->|Trích xuất| F["Cấu hình"]
    F -->|Kích hoạt| G["Sử dụng"]
    G -->|Kiểm tra| H["Cập nhật"]
    H -->|Có bản mới| G
    G -->|Xong| I["Vô hiệu hóa"]
    I -->|Sau đó| J["Bật lại"]
    J -->|Quay lại| G
```

### So sánh các tính năng Plugin

| Tính năng | Slash Command | Skill | Subagent | Plugin |
|-----------|---------------|-------|----------|--------|
| **Cài đặt** | Copy thủ công | Copy thủ công | Cấu hình thủ công | Một lệnh duy nhất |
| **Thời gian thiết lập** | 5 phút | 10 phút | 15 phút | 2 phút |
| **Đóng gói** | Một tệp đơn | Một tệp đơn | Một tệp đơn | Nhiều tệp |
| **Phiên bản** | Thủ công | Thủ công | Thủ công | Tự động |
| **Chia sẻ nhóm** | Copy tệp | Copy tệp | Copy tệp | Install ID |
| **Cập nhật** | Thủ công | Thủ công | Thủ công | Có sẵn tự động |
| **Phụ thuộc** | Không có | Không có | Không có | Có thể bao gồm |
| **Marketplace** | Không | Không | Không | Có |
| **Phân phối** | Kho lưu trữ | Kho lưu trữ | Kho lưu trữ | Marketplace |

### Các trường hợp sử dụng Plugin

| Trường hợp | Khuyến nghị | Tại sao |
|------------|-------------|---------|
| **Onboarding nhóm** | ✅ Dùng Plugin | Cài đặt tức thì mọi cấu hình |
| **Thiết lập Framework** | ✅ Dùng Plugin | Đóng gói các lệnh đặc thù cho framework |
| **Tiêu chuẩn doanh nghiệp** | ✅ Dùng Plugin | Phân phối tập trung, kiểm soát phiên bản |
| **Tự động hóa tác vụ nhanh** | ❌ Dùng Command | Quá phức tạp cho việc nhỏ |
| **Chuyên môn một lĩnh vực** | ❌ Dùng Skill | Quá nặng, hãy dùng skill thay thế |
| **Phân tích chuyên dụng** | ❌ Dùng Subagent | Tạo thủ công hoặc dùng skill |
| **Truy cập dữ liệu thực** | ❌ Dùng MCP | Đứng độc lập, không cần đóng gói |

### Khi nào nên tạo Plugin

```mermaid
graph TD
    A["Tôi có nên tạo một plugin?"]
    A -->|Cần nhiều thành phần| B{"Nhiều lệnh<br/>hoặc subagents<br/>hoặc MCP?"}
    B -->|Có| C["✅ Tạo Plugin"]
    B -->|Không| D["Sử dụng tính năng lẻ"]
    A -->|Quy trình nhóm| E{"Chia sẻ với<br/>nhóm?"}
    E -->|Có| C
    E -->|Không| F["Giữ cấu hình cục bộ"]
    A -->|Thiết lập phức tạp| G{"Cần tự động<br/>cấu hình?"}
    G -->|Có| C
    G -->|Không| D
```

### Xuất bản một Plugin

**Các bước xuất bản:**

1. Tạo cấu trúc plugin với tất cả các thành phần
2. Viết manifest `.claude-plugin/plugin.json`
3. Tạo `README.md` kèm tài liệu hướng dẫn
4. Kiểm thử cục bộ với `/plugin install ./my-plugin`
5. Gửi lên chợ plugin (plugin marketplace)
6. Được review và phê duyệt
7. Được xuất bản trên marketplace
8. Người dùng có thể cài đặt với một lệnh duy nhất

**Ví dụ nội dung đệ trình:**

~~~~markdown
# Plugin Review PR

## Mô tả
Toàn bộ quy trình review PR với các kiểm tra về bảo mật, kiểm thử và tài liệu.
 review workflow with security, testing, and docs",
  "author": {
    "name": "Anthropic"
  },
  "license": "MIT"
}
```

**File:** `commands/review-pr.md`

```markdown
---
name: Review PR
description: Start comprehensive PR review with security and testing checks
---

# PR Review

This command initiates a complete pull request review including:

1. Security analysis
2. Test coverage verification
3. Documentation updates
4. Code quality checks
5. Performance impact assessment
```

**File:** `agents/security-reviewer.md`

```yaml
---
name: security-reviewer
description: Security-focused code review
tools: read, grep, diff
---

# Security Reviewer

Specializes in finding security vulnerabilities:
- Authentication/authorization issues
- Data exposure
- Injection attacks
- Secure configuration
```

**Installation:**

```bash
/plugin install pr-review

# Result:
# ✅ 3 slash commands installed
# ✅ 3 subagents configured
# ✅ 2 MCP servers connected
# ✅ 4 hooks registered
# ✅ Ready to use!
```

#### Example 2: DevOps Plugin

**Components:**

```
devops-automation/
├── commands/
│   ├── deploy.md
│   ├── rollback.md
│   ├── status.md
│   └── incident.md
├── agents/
│   ├── deployment-specialist.md
│   ├── incident-commander.md
│   └── alert-analyzer.md
├── mcp/
│   ├── github-config.json
│   ├── kubernetes-config.json
│   └── prometheus-config.json
├── hooks/
│   ├── pre-deploy.js
│   ├── post-deploy.js
│   └── on-error.js
└── scripts/
    ├── deploy.sh
    ├── rollback.sh
    └── health-check.sh
```

#### Example 3: Documentation Plugin

**Bundled Components:**

```
documentation/
├── commands/
│   ├── generate-api-docs.md
│   ├── generate-readme.md
│   ├── sync-docs.md
│   └── validate-docs.md
├── agents/
│   ├── api-documenter.md
│   ├── code-commentator.md
│   └── example-generator.md
├── mcp/
│   ├── github-docs-config.json
│   └── slack-announce-config.json
└── templates/
    ├── api-endpoint.md
    ├── function-docs.md
    └── adr-template.md
```

### Plugin Marketplace

```mermaid
graph TB
    A["Plugin Marketplace"]
    B["Official<br/>Anthropic"]
    C["Community<br/>Marketplace"]
    D["Enterprise<br/>Registry"]

    A --> B
    A --> C
    A --> D

    B -->|Categories| B1["Development"]
    B -->|Categories| B2["DevOps"]
    B -->|Categories| B3["Documentation"]

    C -->|Search| C1["DevOps Automation"]
    C -->|Search| C2["Mobile Dev"]
    C -->|Search| C3["Data Science"]

    D -->|Internal| D1["Company Standards"]
    D -->|Internal| D2["Legacy Systems"]
    D -->|Internal| D3["Compliance"]
```

### Plugin Installation & Lifecycle

```mermaid
graph LR
    A["Discover"] -->|Browse| B["Marketplace"]
    B -->|Select| C["Plugin Page"]
    C -->|View| D["Components"]
    D -->|Install| E["/plugin install"]
    E -->|Extract| F["Configure"]
    F -->|Activate| G["Use"]
    G -->|Check| H["Update"]
    H -->|Available| G
    G -->|Done| I["Disable"]
    I -->|Later| J["Enable"]
    J -->|Back| G
```

### Plugin Features Comparison

| Feature | Slash Command | Skill | Subagent | Plugin |
|---------|---------------|-------|----------|--------|
| **Installation** | Manual copy | Manual copy | Manual config | One command |
| **Setup Time** | 5 minutes | 10 minutes | 15 minutes | 2 minutes |
| **Bundling** | Single file | Single file | Single file | Multiple |
| **Versioning** | Manual | Manual | Manual | Automatic |
| **Team Sharing** | Copy file | Copy file | Copy file | Install ID |
| **Updates** | Manual | Manual | Manual | Auto-available |
| **Dependencies** | None | None | None | May include |
| **Marketplace** | No | No | No | Yes |
| **Phân phối** | Repository | Repository | Repository | Marketplace |

### Các trường hợp sử dụng Plugin

| Trường hợp | Khuyến nghị | Tại sao |
|----------|-----------------|-----|
| **Onboarding nhóm** | ✅ Dùng Plugin | Cài đặt tức thì, đầy đủ cấu hình |
| **Thiết lập Framework** | ✅ Dùng Plugin | Gói các lệnh đặc thù của framework |
| **Tiêu chuẩn doanh nghiệp** | ✅ Dùng Plugin | Phân phối tập trung, quản lý phiên bản |
| **Tự động hóa tác vụ nhanh** | ❌ Dùng Command | Quá phức tạp không cần thiết |
| **Chuyên môn một lĩnh vực** | ❌ Dùng Skill | Quá nặng, hãy dùng skill thay thế |
| **Phân tích chuyên biệt** | ❌ Dùng Subagent | Tạo thủ công hoặc dùng skill |
| **Truy cập dữ liệu trực tiếp** | ❌ Dùng MCP | Độc lập, không nên đóng gói kèm |

### Khi nào nên tạo Plugin

```mermaid
graph TD
    A["Tôi có nên tạo plugin không?"]
    A -->|Cần nhiều thành phần| B{"Nhiều lệnh<br/>hoặc subagents<br/>hoặc MCPs?"}
    B -->|Có| C["✅ Tạo Plugin"]
    B -->|Không| D["Dùng tính năng riêng lẻ"]
    A -->|Quy trình làm việc nhóm| E{"Chia sẻ với<br/>nhóm?"}
    E -->|Có| C
    E -->|Không| F["Giữ thiết lập cục bộ"]
    A -->|Thiết lập phức tạp| G{"Cần tự động<br/>cấu hình?"}
    G -->|Có| C
    G -->|Không| D
```

### Xuất bản Plugin

**Các bước xuất bản:**

1. Tạo cấu trúc plugin với tất cả các thành phần
2. Viết manifest `.claude-plugin/plugin.json`
3. Tạo `README.md` với tài liệu hướng dẫn
4. Kiểm tra cục bộ với `/plugin install ./my-plugin`
5. Gửi lên marketplace của plugin
6. Được xem xét và phê duyệt
7. Được xuất bản trên marketplace
8. Người dùng có thể cài đặt bằng một lệnh duy nhất

**Ví dụ bản đăng ký:**

~~~~markdown
# PR Review Plugin

## Mô tả
Quy trình review PR hoàn chỉnh với các kiểm tra về bảo mật, thử nghiệm và tài liệu.

## Những gì bao gồm
- 3 slash commands cho các loại review khác nhau
- 3 subagents chuyên biệt
- Tích hợp GitHub và CodeQL MCP
- Các hook quét bảo mật tự động

## Cài đặt
```bash
/plugin install pr-review
```

## Tính năng
✅ Phân tích bảo mật
✅ Kiểm tra độ bao phủ thử nghiệm (test coverage)
✅ Xác minh tài liệu
✅ Đánh giá chất lượng mã nguồn
✅ Phân tích tác động hiệu năng

## Cách dùng
```bash
/review-pr
/check-security
/check-tests
```

## Yêu cầu
- Claude Code 1.0+
- Quyền truy cập GitHub
- CodeQL (tùy chọn)
~~~~

### Plugin so với Cấu hình thủ công

**Thiết lập thủ công (2+ giờ):**
- Cài đặt từng slash command một
- Tạo từng subagent riêng lẻ
- Cấu hình các MCP riêng biệt
- Thiết lập các hook thủ công
- Tài liệu hóa mọi thứ
- Chia sẻ với nhóm (hy vọng họ cấu hình đúng)

**Với Plugin (2 phút):**
```bash
/plugin install pr-review
# ✅ Mọi thứ đã được cài đặt và cấu hình
# ✅ Sẵn sàng sử dụng ngay lập tức
# ✅ Nhóm có thể tái lập chính xác thiết lập
```

---

## So sánh & Tích hợp

### Bảng so sánh tính năng

| Tính năng | Cách gọi | Tính bền vững | Phạm vi | Trường hợp sử dụng |
|---------|-----------|------------|-------|----------|
| **Slash Commands** | Thủ công (`/cmd`) | Chỉ trong phiên | Lệnh đơn lẻ | Phím tắt nhanh |
| **Subagents** | Tự động điều phối | Ngữ cảnh cô lập | Tác vụ chuyên biệt | Phân chia công việc |
| **Memory** | Tự động tải | Xuyên suốt các phiên | Ngữ cảnh người dùng/nhóm | Học tập dài hạn |
| **MCP Protocol** | Tự động truy vấn | Ngoại vi thời gian thực | Truy cập dữ liệu sống | Thông tin động |
| **Skills** | Tự động kích hoạt | Dựa trên hệ thống tệp | Chuyên môn tái sử dụng | Quy trình tự động |

### Dòng thời gian tương tác

```mermaid
graph LR
    A["Bắt đầu phiên"] -->|Tải| B["Memory (CLAUDE.md)"]
    B -->|Khám phá| C["Các Skills có sẵn"]
    C -->|Đăng ký| D["Slash Commands"]
    D -->|Kết nối| E["MCP Servers"]
    E -->|Sẵn sàng| F["Tương tác người dùng"]

    F -->|Nhập /cmd| G["Slash Command"]
    F -->|Yêu cầu| H["Tự động gọi Skill"]
    F -->|Truy vấn| I["Dữ liệu MCP"]
    F -->|Tác vụ phức tạp| J["Ủy quyền cho Subagent"]

    G -->|Sử dụng| B
    H -->|Sử dụng| B
    I -->|Sử dụng| B
    J -->|Sử dụng| B
```

### Ví dụ tích hợp thực tế: Tự động hóa hỗ trợ khách hàng

#### Kiến trúc

```mermaid
graph TB
    User["Email khách hàng"] -->|Nhận| Router["Bộ định tuyến hỗ trợ"]

    Router -->|Phân tích| Memory["Bộ nhớ<br/>Lịch sử khách hàng"]
    Router -->|Tra cứu| MCP1["MCP: DB Khách hàng<br/>Các ticket trước đó"]
    Router -->|Kiểm tra| MCP2["MCP: Slack<br/>Trạng thái nhóm"]

    Router -->|Điều hướng phức tạp| Sub1["Subagent: Hỗ trợ kỹ thuật<br/>Ngữ cảnh: Vấn đề kỹ thuật"]
    Router -->|Điều hướng đơn giản| Sub2["Subagent: Thanh toán<br/>Ngữ cảnh: Vấn đề thanh toán"]
    Router -->|Điều hướng khẩn cấp| Sub3["Subagent: Leo thang<br/>Ngữ cảnh: Xử lý ưu tiên"]

    Sub1 -->|Định dạng| Skill1["Skill: Trình tạo câu trả lời<br/>Duy trì giọng điệu thương hiệu"]
    Sub2 -->|Định dạng| Skill2["Skill: Trình tạo câu trả lời"]
    Sub3 -->|Định dạng| Skill3["Skill: Trình tạo câu trả lời"]

    Skill1 -->|Tạo ra| Output["Câu trả lời đã định dạng"]
    Skill2 -->|Tạo ra| Output
    Skill3 -->|Tạo ra| Output

    Output -->|Đăng| MCP3["MCP: Slack<br/>Thông báo cho nhóm"]
    Output -->|Gửi| Reply["Phản hồi khách hàng"]
```

#### Luồng yêu cầu

```markdown
## Luồng yêu cầu hỗ trợ khách hàng

### 1. Email đến
"Tôi gặp lỗi 500 khi cố gắng tải tập tin. Điều này đang làm gián đoạn công việc của tôi!"

### 2. Tra cứu bộ nhớ
- Tải CLAUDE.md với các tiêu chuẩn hỗ trợ
- Kiểm tra lịch sử khách hàng: Khách hàng VIP, sự cố thứ 3 trong tháng này

### 3. Truy vấn MCP
- GitHub MCP: Liệt kê các vấn đề đang mở (tìm thấy báo cáo lỗi liên quan)
- Database MCP: Kiểm tra trạng thái hệ thống (không có báo cáo ngừng hoạt động)
- Slack MCP: Kiểm tra xem đội ngũ kỹ thuật đã biết chưa

### 4. Phát hiện & Tải Skill
- Yêu cầu khớp với skill "Hỗ trợ kỹ thuật"
- Tải mẫu phản hồi hỗ trợ từ Skill

### 5. Ủy quyền Subagent
- Điều hướng đến Subagent Hỗ trợ kỹ thuật
- Cung cấp ngữ cảnh: lịch sử khách hàng, chi tiết lỗi, các vấn đề đã biết
- Subagent có toàn quyền truy cập: các công cụ read, bash, grep

### 6. Xử lý của Subagent
Subagent Hỗ trợ kỹ thuật:
- Tìm kiếm trong mã nguồn lỗi 500 khi tải tập tin
- Tìm thấy thay đổi gần đây trong commit 8f4a2c
- Tạo tài liệu hướng dẫn khắc phục tạm thời

### 7. Thực thi Skill
Skill Trình tạo câu trả lời:
- Sử dụng hướng dẫn Giọng điệu thương hiệu
- Định dạng phản hồi với sự thấu cảm
- Bao gồm các bước khắc phục tạm thời
- Liên kết đến tài liệu liên quan

### 8. Đầu ra MCP
- Đăng cập nhật lên kênh Slack #support
- Gắn thẻ đội ngũ kỹ thuật
- Cập nhật ticket trong Jira MCP

### 9. Phản hồi
Khách hàng nhận được:
- Sự xác nhận thấu hiểu
- Giải thích nguyên nhân
- Cách khắc phục tạm thời ngay lập tức
- Lộ trình sửa lỗi vĩnh viễn
- Liên kết đến các vấn đề liên quan
```

### Điều phối tính năng hoàn chỉnh

```mermaid
sequenceDiagram
    participant User as Người dùng
    participant Claude as Claude Code
    participant Memory as Bộ nhớ<br/>CLAUDE.md
    participant MCP as MCP Servers
    participant Skills as Skills
    participant SubAgent as Subagents

    User->>Claude: Yêu cầu: "Xây dựng hệ thống auth"
    Claude->>Memory: Tải các tiêu chuẩn dự án
    Memory-->>Claude: Tiêu chuẩn auth, thực hành của nhóm
    Claude->>MCP: Truy vấn GitHub cho các triển khai tương tự
    MCP-->>Claude: Ví dụ mã, thực hành tốt nhất
    Claude->>Skills: Phát hiện các Skills phù hợp
    Skills-->>Claude: Skill Review Bảo mật + Skill Testing
    Claude->>SubAgent: Ủy quyền triển khai
    SubAgent->>SubAgent: Xây dựng tính năng
    Claude->>Skills: Áp dụng Skill Review Bảo mật
    Skills-->>Claude: Kết quả checklist bảo mật
    Claude->>SubAgent: Ủy quyền thử nghiệm
    SubAgent-->>Claude: Kết quả thử nghiệm
    Claude->>User: Hệ thống hoàn chỉnh đã được bàn giao
```

### Khi nào nên dùng từng tính năng

```mermaid
graph TD
    A["Tác vụ mới"] --> B{Loại tác vụ?}

    B -->|Quy trình lặp lại| C["Slash Command"]
    B -->|Cần dữ liệu thời gian thực| D["Giao thức MCP"]
    B -->|Ghi nhớ cho lần sau| E["Bộ nhớ (Memory)"]
    B -->|Tác vụ con chuyên biệt| F["Subagent"]
    B -->|Công việc đặc thù lĩnh vực| G["Skill"]

    C --> C1["✅ Phím tắt của nhóm"]
    D --> D1["✅ Truy cập API trực tiếp"]
    E --> E1["✅ Ngữ cảnh bền vững"]
    F --> F1["✅ Thực thi song song"]
    G --> G1["✅ Chuyên môn tự động gọi"]
```

### Cây quyết định lựa chọn

```mermaid
graph TD
    Start["Cần mở rộng Claude?"]

    Start -->|Tác vụ nhanh lặp lại| A{"Thủ công hay Tự động?"}
    A -->|Thủ công| B["Slash Command"]
    A -->|Tự động| C["Skill"]

    Start -->|Cần dữ liệu bên ngoài| D{"Thời gian thực?"}
    D -->|Có| E["Giao thức MCP"]
    D -->|Không/Xuyên suốt các phiên| F["Bộ nhớ (Memory)"]

    Start -->|Dự án phức tạp| G{"Nhiều vai trò?"}
    G -->|Có| H["Subagents"]
    G -->|Không| I["Skills + Bộ nhớ"]

    Start -->|Ngữ cảnh dài hạn| J["Bộ nhớ (Memory)"]
    Start -->|Quy trình làm việc nhóm| K["Slash Command +<br/>Bộ nhớ"]
    Start -->|Tự động hóa hoàn toàn| L["Skills +<br/>Subagents +<br/>MCP"]
```

---

## Bảng tóm tắt

| Khía cạnh | Slash Commands | Subagents | Memory | MCP | Skills | Plugins |
|--------|---|---|---|---|---|---|
| **Độ khó thiết lập** | Dễ | Trung bình | Dễ | Trung bình | Trung bình | Dễ |
| **Đường cong học tập** | Thấp | Trung bình | Thấp | Trung bình | Trung bình | Thấp |
| **Lợi ích cho nhóm** | Cao | Cao | Trung bình | Cao | Cao | Rất cao |
| **Mức độ tự động hóa** | Thấp | Cao | Trung bình | Cao | Cao | Rất cao |
| **Quản lý ngữ cảnh** | Phiên đơn lẻ | Cô lập | Bền vững | Thời gian thực | Bền vững | Tất cả tính năng |
| **Gánh nặng bảo trì** | Thấp | Trung bình | Thấp | Trung bình | Trung bình | Thấp |
| **Khả năng mở rộng** | Tốt | Xuất sắc | Tốt | Xuất sắc | Xuất sắc | Xuất sắc |
| **Khả năng chia sẻ** | Khá | Khá | Tốt | Tốt | Tốt | Xuất sắc |
| **Quản lý phiên bản** | Thủ công | Thủ công | Thủ công | Thủ công | Thủ công | Tự động |
| **Cài đặt** | Sao chép thủ công | Cấu hình thủ công | N/A | Cấu hình thủ công | Sao chép thủ công | Một lệnh duy nhất |

---

## Hướng dẫn bắt đầu nhanh

### Tuần 1: Bắt đầu đơn giản
- Tạo 2-3 slash commands cho các tác vụ phổ biến
- Bật Memory trong Cài đặt
- Tài liệu hóa các tiêu chuẩn của nhóm trong CLAUDE.md

### Tuần 2: Thêm truy cập thời gian thực
- Thiết lập 1 MCP (GitHub hoặc Database)
- Sử dụng lệnh `/mcp` để cấu hình
- Truy vấn dữ liệu thực trong quy trình của bạn

### Tuần 3: Phân chia công việc
- Tạo Subagent đầu tiên cho một vai trò cụ thể
- Sử dụng lệnh `/agents`
- Kiểm tra việc ủy quyền với một tác vụ đơn giản

### Tuần 4: Tự động hóa mọi thứ
- Tạo Skill đầu tiên cho việc tự động hóa lặp lại
- Sử dụng Skill marketplace hoặc tự xây dựng
- Kết hợp tất cả các tính năng cho một quy trình làm việc hoàn chỉnh

### Tiếp tục duy trì
- Xem lại và cập nhật Memory hàng tháng
- Thêm các Skill mới khi các khuôn mẫu xuất hiện
- Tối ưu hóa các truy vấn MCP
- Tinh chỉnh các dòng lệnh (prompts) cho Subagent

---

## Hooks

### Tổng quan

Hooks là các lệnh shell được định hướng theo sự kiện, tự động thực thi khi có các sự kiện tương ứng trong Claude Code. Chúng cho phép tự động hóa, xác thực và tùy chỉnh quy trình làm việc mà không cần can thiệp thủ công.

### Các sự kiện Hook

Claude Code hỗ trợ **25 sự kiện hook** thuộc bốn loại (command, http, prompt, agent):

| Sự kiện Hook | Kích hoạt khi | Trường hợp sử dụng |
|------------|---------|-----------|
| **SessionStart** | Phiên bắt đầu/tiếp tục/xóa/nén | Thiết lập môi trường, khởi tạo |
| **InstructionsLoaded** | Tải file CLAUDE.md hoặc quy tắc | Xác thực, biến đổi, bổ sung thông tin |
| **UserPromptSubmit** | Người dùng gửi câu lệnh | Xác thực đầu vào, lọc câu lệnh |
| **PreToolUse** | Trước khi bất kỳ công cụ nào chạy | Xác thực, cổng phê duyệt, ghi nhật ký |
| **PermissionRequest** | Hiển thị hộp thoại xin quyền | Luồng tự động phê duyệt/từ chối |
| **PostToolUse** | Sau khi công cụ chạy thành công | Tự động định dạng, thông báo, dọn dẹp |
| **PostToolUseFailure** | Công cụ thực thi thất bại | Xử lý lỗi, ghi nhật ký |
| **Notification** | Thông báo được gửi đi | Cảnh báo, tích hợp bên ngoài |
| **SubagentStart** | Subagent được tạo ra | Chèn ngữ cảnh, khởi tạo |
| **SubagentStop** | Subagent hoàn thành | Xác thực kết quả, ghi nhật ký |
| **Stop** | Claude hoàn tất phản hồi | Tạo tóm tắt, các tác vụ dọn dẹp |
| **StopFailure** | Lỗi API kết thúc lượt | Khôi phục sau lỗi, ghi nhật ký |
| **TeammateIdle** | Đồng đội trong nhóm agent rảnh rỗi | Phân chia công việc, điều phối |
| **TaskCompleted** | Tác vụ được đánh dấu hoàn tất | Xử lý sau tác vụ |
| **TaskCreated** | Tác vụ được tạo qua TaskCreate | Theo dõi tác vụ, ghi nhật ký |
| **ConfigChange** | File cấu hình thay đổi | Xác thực, lan truyền thay đổi |
| **CwdChanged** | Thư mục làm việc thay đổi | Thiết lập riêng cho thư mục |
| **FileChanged** | File đang theo dõi thay đổi | Giám sát file, kích hoạt build lại |
| **PreCompact** | Trước khi nén ngữ cảnh | Bảo toàn trạng thái |
| **PostCompact** | Sau khi nén hoàn tất | Các hành động sau khi nén |
| **WorktreeCreate** | Worktree đang được tạo | Thiết lập môi trường, cài đặt dependency |
| **WorktreeRemove** | Worktree đang bị xóa | Dọn dẹp, giải phóng tài nguyên |
| **Elicitation** | Server MCP yêu cầu người dùng nhập | Xác thực đầu vào |
| **ElicitationResult** | Người dùng phản hồi yêu cầu nhập | Xử lý phản hồi |
| **SessionEnd** | Phiên kết thúc | Dọn dẹp, ghi nhật ký cuối cùng |

### Các Hook phổ biến

Hooks được cấu hình trong `~/.claude/settings.json` (cấp người dùng) hoặc `.claude/settings.json` (cấp dự án):

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write",
        "hooks": [
          {
            "type": "command",
            "command": "prettier --write $CLAUDE_FILE_PATH"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Edit",
        "hooks": [
          {
            "type": "command",
            "command": "eslint $CLAUDE_FILE_PATH"
          }
        ]
      }
    ]
  }
}
```

### Biến môi trường trong Hook

- `$CLAUDE_FILE_PATH` - Đường dẫn tới file đang được sửa/viết
- `$CLAUDE_TOOL_NAME` - Tên của công cụ đang được dùng
- `$CLAUDE_SESSION_ID` - Mã định danh phiên hiện tại
- `$CLAUDE_PROJECT_DIR` - Đường dẫn thư mục dự án

### Thực hành tốt nhất

✅ **Nên:**
- Giữ cho hook chạy nhanh (< 1 giây)
- Dùng hook để xác thực và tự động hóa
- Xử lý lỗi một cách khéo léo
- Dùng đường dẫn tuyệt đối

❌ **Không nên:**
- Làm cho hook có tính tương tác (yêu cầu người dùng nhập)
- Dùng hook cho các tác vụ chạy lâu
- Lưu cứng (hardcode) thông tin đăng nhập trong lệnh

**Xem thêm**: [06-hooks/](06-hooks/) để biết các ví dụ chi tiết

---

## Checkpoints và Rewind

### Tổng quan

Checkpoints cho phép bạn lưu trạng thái cuộc hội thoại và quay lại (rewind) các điểm trước đó, giúp thử nghiệm an toàn và khám phá nhiều cách tiếp cận khác nhau.

### Các khái niệm chính

| Khái niệm | Mô tả |
|---------|-------------|
| **Checkpoint** | Ảnh chụp trạng thái hội thoại bao gồm tin nhắn, tập tin và ngữ cảnh |
| **Rewind** | Quay lại một checkpoint trước đó, hủy bỏ các thay đổi sau đó |
| **Branch Point** | Điểm checkpoint mà từ đó nhiều cách tiếp cận được khám phá |

### Truy cập Checkpoints

Checkpoints được tạo tự động sau mỗi câu lệnh của người dùng. Để quay lại:

```bash
# Nhấn Esc hai lần để mở trình duyệt checkpoint
Esc + Esc

# Hoặc dùng lệnh /rewind
/rewind
```

Khi bạn chọn một checkpoint, bạn có 5 tùy chọn:
1. **Restore code and conversation** -- Khôi phục cả mã nguồn và hội thoại về điểm đó
2. **Restore conversation** -- Quay lại các tin nhắn, nhưng giữ mã nguồn hiện tại
3. **Restore code** -- Khôi phục các tập tin, nhưng giữ hội thoại hiện tại
4. **Summarize from here** -- Nén hội thoại thành một bản tóm tắt
5. **Never mind** -- Hủy bỏ

### Các trường hợp sử dụng

| Tình huống | Quy trình |
|----------|----------|
| **Khám phá cách tiếp cận** | Lưu → Thử A → Lưu → Rewind → Thử B → So sánh |
| **Refactor an toàn** | Lưu → Refactor → Thử nghiệm → Nếu lỗi: Rewind |
| **Thử nghiệm A/B** | Lưu → Thiết kế A → Lưu → Rewind → Thiết kế B → So sánh |
| **Khôi phục sai lầm** | Phát hiện vấn đề → Rewind về trạng thái tốt nhất gần nhất |

### Cấu hình

```json
{
  "autoCheckpoint": true
}
```

**Xem thêm**: [08-checkpoints/](08-checkpoints/) để biết các ví dụ chi tiết

---

## Các tính năng nâng cao

### Planning Mode (Chế độ lập kế hoạch)

Tạo kế hoạch triển khai chi tiết trước khi bắt đầu viết code.

**Kích hoạt:**
```bash
/plan Triển khai hệ thống xác thực người dùng
```

**Lợi ích:**
- Lộ trình rõ ràng với ước tính thời gian
- Đánh giá rủi ro
- Chia nhỏ tác vụ một cách hệ thống
- Cơ hội để xem xét và sửa đổi kế hoạch

### Extended Thinking (Suy nghĩ mở rộng)

Lập luận sâu cho các vấn đề phức tạp.

**Kích hoạt:**
- Bật/tắt bằng phím `Alt+T` (hoặc `Option+T` trên macOS) trong phiên làm việc
- Thiết lập biến môi trường `MAX_THINKING_TOKENS` để điều khiển bằng lập trình

```bash
# Bật suy nghĩ mở rộng qua biến môi trường
export MAX_THINKING_TOKENS=50000
claude -p "Chúng ta nên dùng microservices hay monolith?"
```

**Lợi ích:**
- Phân tích kỹ lưỡng các ưu nhược điểm
- Đưa ra quyết định kiến trúc tốt hơn
- Xem xét các trường hợp biên (edge cases)
- Đánh giá một cách hệ thống

### Background Tasks (Tác vụ nền)

Chạy các hoạt động lâu mà không làm gián đoạn hội thoại.

**Cách dùng:**
```bash
User: Chạy các bài kiểm tra trong nền

Claude: Đã bắt đầu tác vụ bg-1234

/task list           # Hiển thị tất cả tác vụ
/task status bg-1234 # Kiểm tra tiến độ
/task show bg-1234   # Xem kết quả đầu ra
/task cancel bg-1234 # Hủy tác vụ
```

### Các chế độ phân quyền (Permission Modes)

Kiểm soát những gì Claude có thể làm.

| Chế độ | Mô tả | Trường hợp sử dụng |
|------|-------------|----------|
| **default** | Quyền tiêu chuẩn, hỏi trước khi thực hiện các hành động nhạy cảm | Phát triển thông thường |
| **acceptEdits** | Tự động chấp nhận sửa đổi file mà không cần xác nhận | Quy trình chỉnh sửa tin cậy |
| **plan** | Chỉ phân tích và lập kế hoạch, không sửa đổi file | Review code, lập kế hoạch kiến trúc |
| **auto** | Tự động phê duyệt các hành động an toàn, chỉ hỏi các hành động rủi ro | Cân bằng giữa tự chủ và an toàn |
| **dontAsk** | Thực hiện mọi hành động mà không cần thông báo xác nhận | Người dùng kinh nghiệm, tự động hóa |
| **bypassPermissions** | Toàn quyền không giới hạn, không kiểm tra an toàn | Đường ống CI/CD, script tin cậy |

**Cách dùng:**
```bash
claude --permission-mode plan          # Phân tích chỉ đọc
claude --permission-mode acceptEdits   # Tự động chấp nhận chỉnh sửa
claude --permission-mode auto          # Tự động phê duyệt hành động an toàn
claude --permission-mode dontAsk       # Không hiển thị thông báo xác nhận
```

### Headless Mode (Chế độ Print)

Chạy Claude Code mà không cần nhập liệu tương tác, dùng cho tự động hóa và CI/CD bằng cờ `-p` (print).

**Cách dùng:**
```bash
# Chạy tác vụ cụ thể
claude -p "Chạy tất cả bài kiểm tra"

# Chuyển hướng đầu vào để phân tích
cat error.log | claude -p "giải thích lỗi này"

# Tích hợp CI/CD (GitHub Actions)
- name: AI Code Review
  run: claude -p "Review các thay đổi PR và báo cáo vấn đề"

# Đầu ra dạng JSON cho lập trình script
claude -p --output-format json "liệt kê tất cả hàm trong src/"
```

### Scheduled Tasks (Tác vụ định kỳ)

Chạy các tác vụ theo lịch trình lặp lại bằng lệnh `/loop`.

**Cách dùng:**
```bash
/loop every 30m "Chạy kiểm tra và báo cáo lỗi"
/loop every 2h "Kiểm tra cập nhật dependency"
/loop every 1d "Tạo tóm tắt thay đổi mã nguồn hàng ngày"
```

Các tác vụ định kỳ chạy trong nền và báo cáo kết quả khi hoàn thành. Chúng hữu ích cho việc giám sát liên tục, kiểm tra định kỳ và quy trình bảo trì tự động.

### Tích hợp Chrome

Claude Code có thể tích hợp với trình duyệt Chrome cho các tác vụ tự động hóa web. Điều này cho phép các khả năng như điều hướng trang web, điền form, chụp ảnh màn hình và trích xuất dữ liệu từ các trang web trực tiếp trong quy trình phát triển của bạn.

### Quản lý phiên (Session Management)

Quản lý nhiều phiên làm việc.

**Các lệnh:**
```bash
/resume                # Tiếp tục một hội thoại trước đó
/rename "Feature"      # Đặt tên cho phiên hiện tại
/fork                  # Nhánh sang một phiên mới
claude -c              # Tiếp tục hội thoại gần đây nhất
claude -r "Feature"    # Tiếp tục phiên theo tên/ID
```

### Tính năng tương tác

**Phím tắt:**
- `Ctrl + R` - Tìm kiếm lịch sử lệnh
- `Tab` - Tự động hoàn thành
- `↑ / ↓` - Lịch sử lệnh
- `Ctrl + L` - Xóa màn hình

**Nhập liệu nhiều dòng:**
```bash
User: \
> Câu lệnh dài và phức tạp
> trải dài trên nhiều dòng
> \end
```

### Cấu hình

Ví dụ cấu hình đầy đủ:

```json
{
  "planning": {
    "autoEnter": true,
    "requireApproval": true
  },
  "extendedThinking": {
    "enabled": true,
    "showThinkingProcess": true
  },
  "backgroundTasks": {
    "enabled": true,
    "maxConcurrentTasks": 5
  },
  "permissions": {
    "mode": "default"
  }
}
```

**Xem thêm**: [09-advanced-features/](09-advanced-features/) để biết hướng dẫn toàn diện

---

## Tài nguyên

- [Tài liệu Claude Code](https://code.claude.com/docs/en/overview)
- [Tài liệu Anthropic](https://docs.anthropic.com)
- [Các Server MCP trên GitHub](https://github.com/modelcontextprotocol/servers)
- [Anthropic Cookbook](https://github.com/anthropics/anthropic-cookbook)

---

*Cập nhật lần cuối: Tháng 3 năm 2026*
*Dùng cho Claude Haiku 4.5, Sonnet 4.6, và Opus 4.6*
*Hiện bao gồm: Hooks, Checkpoints, Planning Mode, Extended Thinking, Background Tasks, Permission Modes (6 chế độ), Headless Mode, Quản lý phiên, Tự động ghi nhớ, Nhóm Agent, Tác vụ định kỳ, Tích hợp Chrome, Kênh, Đọc chính tả giọng nói, và Các Skills đóng gói sẵn*
