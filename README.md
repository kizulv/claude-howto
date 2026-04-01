<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

[![GitHub Stars](https://img.shields.io/github/stars/luongnv89/claude-howto?style=flat&color=gold)](https://github.com/luongnv89/claude-howto/stargazers)
[![GitHub Forks](https://img.shields.io/github/forks/luongnv89/claude-howto?style=flat)](https://github.com/luongnv89/claude-howto/network/members)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-2.2.0-brightgreen)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-2.1+-purple)](https://code.claude.com)

# Làm chủ Claude Code trong một cuối tuần

Từ việc chỉ biết gõ `claude` đến việc điều phối subagents, hooks, skills và MCP servers — với các hướng dẫn trực quan, mẫu copy-paste và lộ trình học tập có hướng dẫn.

**[Bắt đầu sau 15 phút](#-bắt-đầu-sau-15-phút)** | **[Xác định trình độ của bạn](#-chưa-biết-bắt-đầu-từ-đâu)** | **[Xem danh mục tính năng](CATALOG.md)**

---

## Mục lục

- [Vấn đề](#vấn-đề)
- [Claude How To giải quyết vấn đề này như thế nào](#claude-how-to-giải-quyết-vấn-đề-này-như-thế-nào)
- [Cách hoạt động](#cách-hoạt-động)
- [Chưa biết bắt đầu từ đâu?](#-chưa-biết-bắt-đầu-từ-đâu)
- [Bắt đầu sau 15 phút](#-bắt-đầu-sau-15-phút)
- [Bạn có thể xây dựng gì với dự án này?](#bạn-có-thể-xây-dựng-gì-với-dự-án-này)
- [Câu hỏi thường gặp (FAQ)](#faq)
- [Đóng góp](#đóng-góp)
- [Giấy phép](#giấy-phép)

---

## Vấn đề

Bạn đã cài đặt Claude Code. Bạn đã chạy một vài câu lệnh. Bây giờ thì sao?

- **Tài liệu chính thức mô tả các tính năng — nhưng không chỉ cho bạn cách kết hợp chúng.** Bạn biết Slash commands tồn tại, nhưng không biết cách chuỗi chúng với hooks, memory và subagents thành một quy trình làm việc thực sự giúp tiết kiệm hàng giờ đồng hồ.
- **Không có lộ trình học tập rõ ràng.** Bạn nên học MCP trước hooks? Skills trước subagents? Cuối cùng bạn chỉ đọc lướt qua mọi thứ và không làm chủ được cái nào.
- **Các ví dụ quá cơ bản.** Một lệnh slash "hello world" không giúp ích gì cho bạn trong việc xây dựng một pipeline review code thực tế sử dụng memory, ủy quyền cho các agents chuyên dụng và chạy quét bảo mật tự động.

Bạn đang bỏ lỡ 90% sức mạnh của Claude Code — và bạn thậm chí không biết mình đang thiếu những gì.

---

## Claude How To giải quyết vấn đề này như thế nào

Đây không phải là một tài liệu tham khảo tính năng thông thường. Đây là một **hướng dẫn có cấu trúc, trực quan và dựa trên ví dụ** giúp bạn học cách sử dụng mọi tính năng của Claude Code với các mẫu thực tế mà bạn có thể copy vào dự án của mình ngay hôm nay.

| | Tài liệu chính thức | Hướng dẫn này |
|--|---------------|------------|
| **Định dạng** | Tài liệu tham khảo | Hướng dẫn trực quan với sơ đồ Mermaid |
| **Độ sâu** | Mô tả tính năng | Cách hoạt động chi tiết bên dưới |
| **Ví dụ** | Các đoạn mã cơ bản | Các mẫu sẵn sàng cho sản xuất dùng được ngay |
| **Cấu trúc** | Tổ chức theo tính năng | Lộ trình học tập tiến bộ (từ cơ bản đến nâng cao) |
| **Hướng dẫn mới** | Tự tìm hiểu | Lộ trình có hướng dẫn với thời gian ước tính |
| **Tự đánh giá** | Không có | Các bài trắc nghiệm tương tác để tìm lỗ hổng kiến thức |

### Những gì bạn nhận được:

- **10 module hướng dẫn** bao gồm mọi tính năng của Claude Code — từ slash commands đến các nhóm agent tùy chỉnh.
- **Các cấu hình copy-paste** — slash commands, mẫu CLAUDE.md, hook scripts, cấu hình MCP, định nghĩa subagent và các bộ plugin đầy đủ.
- **Sơ đồ Mermaid** hiển thị cách mỗi tính năng hoạt động nội bộ, để bạn hiểu *tại sao*, không chỉ là *làm thế nào*.
- **Lộ trình học tập có hướng dẫn** đưa bạn từ người mới bắt đầu thành người dùng thành thạo trong 11-13 giờ.
- **Tự đánh giá tích hợp** — chạy `/self-assessment` hoặc `/lesson-quiz hooks` trực tiếp trong Claude Code để xác định các lỗ hổng kiến thức.

**[Bắt đầu lộ trình học tập  ->](LEARNING-ROADMAP.md)**

---

## Cách hoạt động

### 1. Tìm trình độ của bạn

Làm [bài trắc nghiệm tự đánh giá](LEARNING-ROADMAP.md#-find-your-level) hoặc chạy `/self-assessment` trong Claude Code. Nhận lộ trình cá nhân hóa dựa trên những gì bạn đã biết.

### 2. Theo lộ trình có hướng dẫn

Làm việc qua 10 module theo thứ tự — mỗi module xây dựng dựa trên module trước đó. Copy các mẫu trực tiếp vào dự án của bạn khi học.

### 3. Kết hợp các tính năng thành quy trình làm việc

Sức mạnh thực sự nằm ở việc kết hợp các tính năng. Học cách kết nối slash commands + memory + subagents + hooks thành các pipeline tự động xử lý review code, triển khai và tạo tài liệu.

### 4. Kiểm tra mức độ hiểu

Chạy `/lesson-quiz [chủ đề]` sau mỗi module. Bài trắc nghiệm sẽ chỉ ra những gì bạn còn thiếu để có thể bổ sung nhanh chóng.

**[Bắt đầu sau 15 phút](#-bắt-đầu-sau-15-phút)**

---

## Được tin dùng bởi hơn 5.900 lập trình viên

- **Hơn 5.900 GitHub stars** từ các lập trình viên sử dụng Claude Code hàng ngày.
- **Hơn 690 forks** — các nhóm tùy chỉnh hướng dẫn này cho quy trình làm việc riêng của họ.
- **Được bảo trì tích cực** — cập nhật theo mỗi bản phát hành Claude Code (mới nhất: v2.2.0, tháng 3 năm 2026).
- **Hướng tới cộng đồng** — đóng góp từ các lập trình viên chia sẻ cấu hình thực tế của họ.

---

## Chưa biết bắt đầu từ đâu?

Làm bài tự đánh giá hoặc chọn trình độ của bạn:

| Trình độ | Bạn có thể... | Bắt đầu tại đây | Thời gian |
|-------|-----------|------------|------|
| **Cơ bản** | Khởi động Claude Code và chat | [Slash Commands](01-slash-commands/) | ~2.5 giờ |
| **Trung bình** | Sử dụng CLAUDE.md và các lệnh tùy chỉnh | [Skills](03-skills/) | ~3.5 giờ |
| **Nâng cao** | Cấu hình các MCP servers và hooks | [Advanced Features](09-advanced-features/) | ~5 giờ |

**Lộ trình học tập đầy đủ với tất cả 10 module:**

| Thứ tự | Module | Trình độ | Thời gian |
|-------|--------|-------|------|
| 1 | [Slash Commands](01-slash-commands/) | Cơ bản | 30 phút |
| 2 | [Memory](02-memory/) | Cơ bản+ | 45 phút |
| 3 | [Checkpoints](08-checkpoints/) | Trung bình | 45 phút |
| 4 | [CLI Basics](10-cli/) | Cơ bản+ | 30 phút |
| 5 | [Skills](03-skills/) | Trung bình | 1 giờ |
| 6 | [Hooks](06-hooks/) | Trung bình | 1 giờ |
| 7 | [MCP](05-mcp/) | Trung bình+ | 1 giờ |
| 8 | [Subagents](04-subagents/) | Trung bình+ | 1.5 giờ |
| 9 | [Advanced Features](09-advanced-features/) | Nâng cao | 2-3 giờ |
| 10 | [Plugins](07-plugins/) | Nâng cao | 2 giờ |

**[Lộ trình học tập hoàn chỉnh ->](LEARNING-ROADMAP.md)**

---

## Bắt đầu sau 15 phút

```bash
# 1. Clone hướng dẫn
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto

# 2. Copy lệnh slash đầu tiên
mkdir -p /path/to/your-project/.claude/commands
cp 01-slash-commands/optimize.md /path/to/your-project/.claude/commands/

# 3. Thử nghiệm — trong Claude Code, gõ:
# /optimize

# 4. Sẵn sàng cho nhiều hơn? Thiết lập bộ nhớ dự án (project memory):
cp 02-memory/project-CLAUDE.md /path/to/your-project/CLAUDE.md

# 5. Cài đặt một skill:
cp -r 03-skills/code-review ~/.claude/skills/
```

Bạn muốn thiết lập đầy đủ? Đây là các bước **thiết lập thiết yếu trong 1 giờ**:

```bash
# Slash commands (15 phút)
cp 01-slash-commands/*.md .claude/commands/

# Project memory (15 phút)
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Cài đặt một skill (15 phút)
cp -r 03-skills/code-review ~/.claude/skills/

# Mục tiêu cuối tuần: thêm hooks, subagents, MCP, và plugins
# Theo dõi lộ trình học tập để được hướng dẫn thiết lập
```

**[Xem chi tiết hướng dẫn cài đặt](#hướng-dẫn-cài-đặt-nhanh)**

---

## Bạn có thể xây dựng gì với dự án này?

| Tình huống sử dụng | Các tính năng bạn sẽ kết hợp |
|----------|------------------------|
| **Tự động Review Code** | Slash Commands + Subagents + Memory + MCP |
| **Hướng dẫn thành viên mới** | Memory + Slash Commands + Plugins |
| **Tự động hóa CI/CD** | CLI Reference + Hooks + Background Tasks |
| **Tạo tài liệu tự động** | Skills + Subagents + Plugins |
| **Kiểm tra bảo mật** | Subagents + Skills + Hooks (chế độ read-only) |
| **DevOps Pipelines** | Plugins + MCP + Hooks + Background Tasks |
| **Refactoring phức tạp** | Checkpoints + Planning Mode + Hooks |

---

## Câu hỏi thường gặp (FAQ)

**Dự án này có miễn phí không?**
Có. Được cấp phép MIT, miễn phí mãi mãi. Sử dụng cho dự án cá nhân, tại nơi làm việc, trong nhóm của bạn — không có hạn chế nào ngoài việc kèm theo thông báo giấy phép.

**Dự án có được bảo trì không?**
Có, tích cực. Hướng dẫn được đồng bộ hóa với mọi bản phát hành Claude Code. Phiên bản hiện tại: v2.2.0 (tháng 3 năm 2026), tương thích với Claude Code 2.1+.

**Hướng dẫn này khác gì so với tài liệu chính thức?**
Tài liệu chính thức là tài liệu tham khảo tính năng. Hướng dẫn này là một bài học với các sơ đồ, các mẫu sẵn sàng cho sản xuất và lộ trình học tập tiến bộ. Chúng bổ sung cho nhau — hãy bắt đầu ở đây để học, và tham khảo tài liệu chính thức khi bạn cần các chi tiết cụ thể.

**Mất bao lâu để đi hết mọi thứ?**
Mất 11-13 giờ cho toàn bộ lộ trình. Nhưng bạn sẽ nhận được giá trị tức thì sau 15 phút — chỉ cần copy một mẫu lệnh slash và dùng thử.

**Tôi có thể sử dụng với Claude Sonnet / Haiku / Opus không?**
Có. Tất cả các mẫu đều hoạt động với Claude Sonnet 4.6, Claude Opus 4.6 và Claude Haiku 4.5.

**Tôi có thể đóng góp không?**
Chắc chắn rồi. Xem [CONTRIBUTING.md](CONTRIBUTING.md) để biết các hướng dẫn. Chúng tôi hoan nghênh các ví dụ mới, sửa lỗi, cải thiện tài liệu và các mẫu từ cộng đồng.

**Tôi có thể đọc ngoại tuyến (offline) không?**
Có. Chạy `uv run scripts/build_epub.py` để tạo ebook EPUB với tất cả nội dung và sơ đồ đã được hiển thị.

---

## Bắt đầu làm chủ Claude Code ngay hôm nay

Bạn đã cài đặt Claude Code. Điều duy nhất cản trở bạn đạt được năng suất gấp 10 lần là biết cách sử dụng nó. Hướng dẫn này cung cấp cho bạn lộ trình có cấu trúc, các giải thích trực quan và các mẫu copy-paste để đạt được điều đó.

Cấp phép MIT. Miễn phí mãi mãi. Clone nó, fork nó, biến nó thành của bạn.

**[Bắt đầu lộ trình học tập ->](LEARNING-ROADMAP.md)** | **[Xem danh mục tính năng](CATALOG.md)** | **[Bắt đầu sau 15 phút](#-bắt-đầu-sau-15-phút)**

---

<details>
<summary>Điều hướng nhanh — Tất cả tính năng</summary>

| Tính năng | Mô tả | Thư mục |
|---------|-------------|--------|
| **Danh mục tính năng** | Tài liệu tham khảo đầy đủ với lệnh cài đặt | [CATALOG.md](CATALOG.md) |
| **Slash Commands** | Phím tắt do người dùng gọi | [01-slash-commands/](01-slash-commands/) |
| **Memory** | Ngữ cảnh lâu dài | [02-memory/](02-memory/) |
| **Skills** | Khả năng có thể tái sử dụng | [03-skills/](03-skills/) |
| **Subagents** | Các trợ lý AI chuyên biệt | [04-subagents/](04-subagents/) |
| **MCP Protocol** | Truy cập công cụ bên ngoài | [05-mcp/](05-mcp/) |
| **Hooks** | Tự động hóa dựa trên sự kiện | [06-hooks/](06-hooks/) |
| **Plugins** | Bộ sưu tập tính năng đi kèm | [07-plugins/](07-plugins/) |
| **Checkpoints** | Ảnh chụp phiên làm việc & quay lại | [08-checkpoints/](08-checkpoints/) |
| **Tính năng nâng cao** | Lập kế hoạch, suy nghĩ, tác vụ nền | [09-advanced-features/](09-advanced-features/) |
| **CLI Reference** | Các câu lệnh, cờ và tùy chọn | [10-cli/](10-cli/) |
| **Bài viết Blog** | Các ví dụ sử dụng thực tế | [Blog Posts](https://medium.com/@luongnv89) |

</details>

<details>
<summary>So sánh tính năng</summary>

| Tính năng | Cách gọi | Tính bền vững | Tốt nhất cho |
|---------|-----------|------------|----------|
| **Slash Commands** | Thủ công (`/cmd`) | Chỉ trong phiên | Các phím tắt nhanh |
| **Memory** | Tự động tải | Xuyên suốt các phiên | Học tập dài hạn |
| **Skills** | Tự động gọi | Hệ thống tệp | Quy trình tự động |
| **Subagents** | Tự động ủy quyền | Ngữ cảnh riêng biệt | Phân chia nhiệm vụ |
| **MCP Protocol** | Tự động truy vấn | Thời gian thực | Truy cập dữ liệu sống |
| **Hooks** | Kích hoạt theo sự kiện | Được cấu hình | Tự động hóa & xác thực |
| **Plugins** | Một câu lệnh | Tất cả tính năng | Giải pháp hoàn chỉnh |
| **Checkpoints** | Thủ công/Tự động | Dựa trên phiên | Thử nghiệm an toàn |
| **Planning Mode** | Thủ công/Tự động | Giai đoạn lập kế hoạch | Triển khai phức tạp |
| **Background Tasks** | Thủ công | Thời gian thực hiện | Các hoạt động chạy lâu |
| **CLI Reference** | Lệnh terminal | Phiên/Script | Tự động hóa & scripting |

</details>

<details>
<summary>Hướng dẫn cài đặt nhanh</summary>

```bash
# Slash Commands
cp 01-slash-commands/*.md .claude/commands/

# Memory
cp 02-memory/project-CLAUDE.md ./CLAUDE.md

# Skills
cp -r 03-skills/code-review ~/.claude/skills/

# Subagents
cp 04-subagents/*.md .claude/agents/

# MCP
export GITHUB_TOKEN="token"
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# Hooks
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh

# Plugins
/plugin install pr-review

# Checkpoints (tự động bật, cấu hình trong cài đặt)
# Xem 08-checkpoints/README.md

# Advanced Features (cấu hình trong cài đặt)
# Xem 09-advanced-features/config-examples.json

# CLI Reference (không cần cài đặt)
# Xem 10-cli/README.md cho các ví dụ sử dụng
```

</details>

<details>
<summary>01. Slash Commands</summary>

**Vị trí**: [01-slash-commands/](01-slash-commands/)

**Là gì**: Các phím tắt do người dùng gọi, được lưu dưới dạng tệp Markdown.

**Ví dụ**:
- `optimize.md` - Phân tích tối ưu hóa mã
- `pr.md` - Chuẩn bị Pull request
- `generate-api-docs.md` - Trình tạo tài liệu API

**Cài đặt**:
```bash
cp 01-slash-commands/*.md /path/to/project/.claude/commands/
```

**Sử dụng**:
```
/optimize
/pr
/generate-api-docs
```

**Tìm hiểu thêm**: [Khám phá Claude Code Slash Commands](https://medium.com/@luongnv89/discovering-claude-code-slash-commands-cdc17f0dfb29)

</details>

<details>
<summary>02. Memory</summary>

**Vị trí**: [02-memory/](02-memory/)

**Là gì**: Ngữ cảnh bền vững xuyên suốt các phiên làm việc.

**Ví dụ**:
- `project-CLAUDE.md` - Tiêu chuẩn dự án cho cả nhóm
- `directory-api-CLAUDE.md` - Các quy tắc riêng cho từng thư mục
- `personal-CLAUDE.md` - Tùy chỉnh cá nhân

**Cài đặt**:
```bash
# Bộ nhớ dự án
cp 02-memory/project-CLAUDE.md /path/to/project/CLAUDE.md

# Bộ nhớ thư mục
cp 02-memory/directory-api-CLAUDE.md /path/to/project/src/api/CLAUDE.md

# Bộ nhớ cá nhân
cp 02-memory/personal-CLAUDE.md ~/.claude/CLAUDE.md
```

**Sử dụng**: Được Claude tự động tải.

</details>

<details>
<summary>03. Skills</summary>

**Vị trí**: [03-skills/](03-skills/)

**Là gì**: Các khả năng có thể tái sử dụng, tự động gọi kèm theo hướng dẫn và script.

**Ví dụ**:
- `code-review/` - Review code toàn diện với script
- `brand-voice/` - Kiểm tra tính nhất quán của giọng văn thương hiệu
- `doc-generator/` - Trình tạo tài liệu API

**Cài đặt**:
```bash
# Skills cá nhân
cp -r 03-skills/code-review ~/.claude/skills/

# Skills dự án
cp -r 03-skills/code-review /path/to/project/.claude/skills/
```

**Sử dụng**: Tự động được gọi khi có liên quan.

</details>

<details>
<summary>04. Subagents</summary>

**Vị trí**: [04-subagents/](04-subagents/)

**Là gì**: Các trợ lý AI chuyên biệt với ngữ cảnh riêng lập và prompt tùy chỉnh.

**Ví dụ**:
- `code-reviewer.md` - Phân tích chất lượng mã toàn diện
- `test-engineer.md` - Chiến lược kiểm thử và độ bao phủ
- `documentation-writer.md` - Viết tài liệu kỹ thuật
- `secure-reviewer.md` - Review tập trung vào bảo mật (read-only)
- `implementation-agent.md` - Triển khai tính năng đầy đủ

**Cài đặt**:
```bash
cp 04-subagents/*.md /path/to/project/.claude/agents/
```

**Sử dụng**: Tự động được ủy quyền bởi agent chính.

</details>

<details>
<summary>05. MCP Protocol</summary>

**Vị trí**: [05-mcp/](05-mcp/)

**Là gì**: Model Context Protocol để truy cập các công cụ và API bên ngoài.

**Ví dụ**:
- `github-mcp.json` - Tích hợp GitHub
- `database-mcp.json` - Truy vấn cơ sở dữ liệu
- `filesystem-mcp.json` - Thao tác hệ thống tệp
- `multi-mcp.json` - Nhiều MCP servers

**Cài đặt**:
```bash
# Thiết lập biến môi trường
export GITHUB_TOKEN="your_token"
export DATABASE_URL="postgresql://..."

# Thêm MCP server qua CLI
claude mcp add github -- npx -y @modelcontextprotocol/server-github

# Hoặc thêm vào .mcp.json của dự án thủ công (xem ví dụ trong 05-mcp/)
```

**Sử dụng**: Các công cụ MCP tự động có sẵn cho Claude sau khi cấu hình.

</details>

<details>
<summary>06. Hooks</summary>

**Vị trí**: [06-hooks/](06-hooks/)

**Là gì**: Các lệnh shell được kích hoạt theo sự kiện, tự động thực thi phản hồi lại các sự kiện của Claude Code.

**Ví dụ**:
- `format-code.sh` - Tự động định dạng mã trước khi ghi
- `pre-commit.sh` - Chạy kiểm thử trước khi commit
- `security-scan.sh` - Quét các vấn đề bảo mật
- `log-bash.sh` - Ghi lại tất cả các lệnh bash
- `validate-prompt.sh` - Xác thực prompt người dùng
- `notify-team.sh` - Gửi thông báo về các sự kiện

**Cài đặt**:
```bash
mkdir -p ~/.claude/hooks
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

Cấu hình hooks trong `~/.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/format-code.sh"]
    }],
    "PostToolUse": [{
      "matcher": "Write",
      "hooks": ["~/.claude/hooks/security-scan.sh"]
    }]
  }
}
```

**Sử dụng**: Hooks tự động thực thi khi sảy ra sự kiện.

**Các loại Hook** (4 loại, 25 sự kiện):
- **Tool Hooks**: `PreToolUse`, `PostToolUse`, `PostToolUseFailure`, `PermissionRequest`
- **Session Hooks**: `SessionStart`, `SessionEnd`, `Stop`, `StopFailure`, `SubagentStart`, `SubagentStop`
- **Task Hooks**: `UserPromptSubmit`, `TaskCompleted`, `TaskCreated`, `TeammateIdle`
- **Lifecycle Hooks**: `ConfigChange`, `CwdChanged`, `FileChanged`, `PreCompact`, `PostCompact`, `WorktreeCreate`, `WorktreeRemove`, `Notification`, `InstructionsLoaded`, `Elicitation`, `ElicitationResult`

</details>

<details>
<summary>07. Plugins</summary>

**Vị trí**: [07-plugins/](07-plugins/)

**Là gì**: Các bộ sưu tập lệnh, agents, MCP và hooks đi kèm với nhau.

**Ví dụ**:
- `pr-review/` - Quy trình review PR hoàn chỉnh
- `devops-automation/` - Triển khai và giám sát
- `documentation/` - Tạo tài liệu

**Cài đặt**:
```bash
/plugin install pr-review
/plugin install devops-automation
/plugin install documentation
```

**Sử dụng**: Sử dụng các lệnh slash và tính năng đi kèm.

</details>

<details>
<summary>08. Checkpoints và Rewind</summary>

**Vị trí**: [08-checkpoints/](08-checkpoints/)

**Là gì**: Lưu trạng thái hội thoại và quay lại các điểm trước đó để thử nghiệm các hướng tiếp cận khác nhau.

**Khái niệm chính**:
- **Checkpoint**: Ảnh chụp trạng thái hội thoại
- **Rewind**: Quay lại checkpoint trước đó
- **Branch Point**: Khám phá nhiều hướng từ cùng một checkpoint

**Sử dụng**:
```
# Checkpoints được tạo tự động với mỗi prompt của người dùng
# Để quay lại, nhấn Esc hai lần hoặc sử dụng:
/rewind

# Sau đó chọn từ năm tùy chọn:
# 1. Khôi phục mã và cuộc hội thoại
# 2. Khôi phục cuộc hội thoại
# 3. Khôi phục mã
# 4. Tóm tắt từ đây
# 5. Bỏ qua
```

**Tình huống sử dụng**:
- Thử các phương pháp triển khai khác nhau
- Khắc phục sai lầm
- Thử nghiệm an toàn
- So sánh các giải pháp thay thế
- A/B testing các thiết kế khác nhau

</details>

<details>
<summary>09. Advanced Features</summary>

**Vị trí**: [09-advanced-features/](09-advanced-features/)

**Là gì**: Các khả năng nâng cao cho quy trình làm việc phức tạp và tự động hóa.

**Bao gồm**:
- **Planning Mode** — Tạo kế hoạch triển khai chi tiết trước khi code
- **Extended Thinking** — Suy luận sâu cho các vấn đề phức tạp (bật/tắt bằng `Alt+T` / `Option+T`)
- **Background Tasks** — Chạy các hoạt động dài mà không gây nghẽn
- **Permission Modes** — `default`, `acceptEdits`, `plan`, `dontAsk`, `bypassPermissions`
- **Headless Mode** — Chạy Claude Code trong CI/CD: `claude -p "Run tests and generate report"`
- **Session Management** — `/resume`, `/rename`, `/fork`, `claude -c`, `claude -r`
- **Configuration** — Tùy chỉnh hành vi trong `~/.claude/settings.json`

Xem [config-examples.json](09-advanced-features/config-examples.json) cho các cấu hình đầy đủ.

</details>

<details>
<summary>10. CLI Reference</summary>

**Vị trí**: [10-cli/](10-cli/)

**Là gì**: Tài liệu tham khảo giao diện dòng lệnh đầy đủ cho Claude Code.

**Ví dụ nhanh**:
```bash
# Chế độ tương tác
claude "giải thích dự án này"

# Chế độ in (không tương tác)
claude -p "review đoạn code này"

# Xử lý nội dung tệp
cat error.log | claude -p "giải thích lỗi này"

# Đầu ra JSON cho script
claude -p --output-format json "list functions"

# Tiếp tục phiên làm việc
claude -r "feature-auth" "tiếp tục triển khai"
```

**Tình huống sử dụng**: Tích hợp CI/CD pipeline, tự động hóa script, xử lý hàng loạt, quy trình làm việc đa phiên, cấu hình agent tùy chỉnh.

</details>

<details>
<summary>Ví dụ quy trình làm việc (Workflows)</summary>

### Quy trình Review Code hoàn chỉnh

```markdown
# Sử dụng: Slash Commands + Subagents + Memory + MCP

Người dùng: /review-pr

Claude:
1. Tải bộ nhớ dự án (tiêu chuẩn coding)
2. Lấy PR qua GitHub MCP
3. Ủy quyền cho subagent code-reviewer
4. Ủy quyền cho subagent test-engineer
5. Tổng hợp các phát hiện
6. Cung cấp review toàn diện
```

### Tạo tài liệu tự động

```markdown
# Sử dụng: Skills + Subagents + Memory

Người dùng: "Tạo tài liệu API cho module auth"

Claude:
1. Tải bộ nhớ dự án (tiêu chuẩn tài liệu)
2. Nhận diện yêu cầu tạo tài liệu
3. Tự động gọi skill doc-generator
4. Ủy quyền cho subagent api-documenter
5. Tạo tài liệu đầy đủ với các ví dụ
```

### DevOps Deployment

```markdown
# Sử dụng: Plugins + MCP + Hooks

Người dùng: /deploy production

Claude:
1. Chạy hook pre-deploy (xác thực môi trường)
2. Ủy quyền cho subagent deployment-specialist
3. Thực hiện triển khai qua Kubernetes MCP
4. Giám sát tiến độ
5. Chạy hook post-deploy (health checks)
6. Báo cáo trạng thái
```

</details>

<details>
<summary>Cấu trúc thư mục</summary>

```
├── 01-slash-commands/
├── 02-memory/
├── 03-skills/
├── 04-subagents/
├── 05-mcp/
├── 06-hooks/
├── 07-plugins/
├── 08-checkpoints/
├── 09-advanced-features/
├── 10-cli/
└── README.md (tệp này)
```

</details>

<details>
<summary>Nên làm (Do's) và Không nên làm (Don'ts)</summary>

### Nên làm
- Bắt đầu đơn giản với slash commands
- Thêm các tính năng dần dần
- Sử dụng memory cho tiêu chuẩn nhóm
- Kiểm tra cấu hình cục bộ trước
- Viết tài liệu cho các triển khai tùy chỉnh
- Quản lý phiên bản cho cấu hình dự án
- Chia sẻ plugins với nhóm

### Không nên làm
- Đừng tạo các tính năng dư thừa
- Đừng để lộ thông tin xác thực
- Đừng bỏ qua việc viết tài liệu
- Đừng làm phức tạp các tác vụ đơn giản
- Đừng phớt lờ các thực hành bảo mật tốt nhất
- Đừng commit dữ liệu nhạy cảm

</details>

<details>
<summary>Khắc phục sự cố</summary>

### Tính năng không tải được
1. Kiểm tra vị trí tệp và cách đặt tên
2. Xác thực cú pháp YAML frontmatter
3. Kiểm tra quyền truy cập tệp
4. Xem xét khả năng tương thích phiên bản Claude Code

### Kết nối MCP thất bại
1. Xác thực các biến môi trường
2. Kiểm tra cài đặt MCP server
3. Kiểm tra thông tin xác thực
4. Kiểm tra kết nối mạng

### Subagent không ủy quyền được
1. Kiểm tra quyền của công cụ
2. Xác thực mô tả của agent rõ ràng
3. Xem xét độ phức tạp của nhiệm vụ
4. Kiểm tra agent độc lập

</details>

<details>
<summary>Kiểm thử (Testing)</summary>

Dự án này bao gồm kiểm thử tự động toàn diện:

- **Unit Tests**: Kiểm thử Python bằng pytest (Python 3.10, 3.11, 3.12)
- **Chất lượng mã**: Linting và formatting với Ruff
- **Bảo mật**: Quét lỗ hổng với Bandit
- **Kiểm tra kiểu dữ liệu**: Phân tích kiểu tĩnh với mypy
- **Xác minh bản dựng**: Kiểm tra tạo EPUB
- **Theo dõi độ bao phủ**: Tích hợp Codecov

```bash
# Cài đặt các phụ thuộc phát triển
uv pip install -r requirements-dev.txt

# Chạy tất cả unit tests
pytest scripts/tests/ -v

# Chạy kiểm thử với báo cáo độ bao phủ
pytest scripts/tests/ -v --cov=scripts --cov-report=html

# Chạy kiểm tra chất lượng mã
ruff check scripts/
ruff format --check scripts/

# Chạy quét bảo mật
bandit -c pyproject.toml -r scripts/ --exclude scripts/tests/

# Chạy kiểm tra kiểu
mypy scripts/ --ignore-missing-imports
```

Kiểm thử chạy tự động mỗi khi push lên `main`/`develop` và mỗi PR. Xem [TESTING.md](.github/TESTING.md) cho thông tin chi tiết.

</details>

<details>
<summary>Tạo EPUB</summary>

Bạn muốn đọc hướng dẫn này ngoại tuyến? Hãy tạo một ebook EPUB:

```bash
uv run scripts/build_epub.py
```

Lệnh này sẽ tạo tệp `claude-howto-guide.epub` với đầy đủ nội dung, bao gồm cả các sơ đồ Mermaid.

</details>
