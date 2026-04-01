# Nhật ký thay đổi (Changelog)

## v2.2.0 — 26-03-2026

### Tài liệu

- Đồng bộ hóa tất cả các hướng dẫn và tham chiếu với Claude Code v2.1.84 (f78c094) @luongnv89
  - Cập nhật các lệnh slash thành hơn 55 lệnh tích hợp + 5 skill đóng gói, đánh dấu 3 lệnh đã lỗi thời (deprecated)
  - Mở rộng các sự kiện hook từ 18 lên 25, thêm loại hook `agent` (hiện có 4 loại)
  - Thêm Auto Mode, Channels, Voice Dictation vào các tính năng nâng cao
  - Thêm các trường frontmatter `effort`, `shell` cho skill; các trường `initialPrompt`, `disallowedTools` cho agent
  - Thêm transport WebSocket cho MCP, elicitation, giới hạn công cụ 2KB
  - Thêm hỗ trợ LSP cho plugin, `userConfig`, `${CLAUDE_PLUGIN_DATA}`
  - Cập nhật tất cả tài liệu tham khảo (CATALOG, QUICK_REFERENCE, LEARNING-ROADMAP, INDEX)
- Viết lại README dưới dạng hướng dẫn có cấu trúc trang đích (landing page) (32a0776) @luongnv89

### Sửa lỗi

- Thêm các từ còn thiếu trong cSpell và các phần README để tuân thủ CI (93f9d51) @luongnv89
- Thêm `Sandboxing` vào từ điển cSpell (b80ce6f) @luongnv89

**Toàn bộ thay đổi**: https://github.com/luongnv89/claude-howto/compare/v2.1.1...v2.2.0

---

## v2.1.1 — 13-03-2026

### Sửa lỗi

- Loại bỏ liên kết marketplace đã hỏng làm lỗi kiểm tra liên kết của CI (3fdf0d6) @luongnv89
- Thêm `sandboxed` và `pycache` vào từ điển cSpell (dc64618) @luongnv89

**Toàn bộ thay đổi**: https://github.com/luongnv89/claude-howto/compare/v2.1.0...v2.1.1

---

## v2.1.0 — 13-03-2026

### Tính năng

- Thêm lộ trình học tập thích ứng với các skill tự đánh giá và bài kiểm tra bài học (1ef46cd) @luongnv89
  - `/self-assessment` — bài kiểm tra trình độ tương tác qua 10 lĩnh vực tính năng với lộ trình học tập cá nhân hóa
  - `/lesson-quiz [lesson]` — kiểm tra kiến thức theo từng bài học với 8-10 câu hỏi mục tiêu

### Sửa lỗi

- Cập nhật các URL bị hỏng, các phần lỗi thời và các tham chiếu cũ (8fe4520) @luongnv89
- Sửa các liên kết hỏng trong tài nguyên và skill tự đánh giá (7a05863) @luongnv89
- Sử dụng dấu ngã (tilde fences) cho các khối mã lồng nhau trong hướng dẫn khái niệm (5f82719) @VikalpP
- Thêm các từ còn thiếu vào từ điển cSpell (8df7572) @luongnv89

### Tài liệu

- QA Giai đoạn 5 — sửa tính nhất quán, URL và thuật ngữ trên toàn bộ tài liệu (00bbe4c) @luongnv89
- Hoàn thành Giai đoạn 3-4 — bao phủ các tính năng mới và cập nhật tài liệu tham khảo (132de29) @luongnv89
- Thêm runtime MCPorter vào phần thảo luận về MCP context (ef52705) @luongnv89
- Thêm các lệnh, tính năng và cài đặt còn thiếu trên 6 hướng dẫn (4bc8f15) @luongnv89
- Thêm hướng dẫn phong cách (style guide) dựa trên các quy ước hiện có của kho lưu trữ (84141d0) @luongnv89
- Thêm hàng tự đánh giá vào bảng so sánh hướng dẫn (8fe0c96) @luongnv89
- Thêm @VikalpP vào danh sách người đóng góp cho PR #7 (d5b4350) @luongnv89
- Thêm tham chiếu skill tự đánh giá và bài kiểm tra vào README và lộ trình (d5a6106) @luongnv89

### Người đóng góp mới

- @VikalpP đã đóng góp lần đầu tiên trong #7

**Toàn bộ thay đổi**: https://github.com/luongnv89/claude-howto/compare/v2.0.0...v2.1.0

---

## v2.0.0 — 01-02-2026

### Tính năng

- Đồng bộ hóa tất cả tài liệu với các tính năng của Claude Code tháng 2 năm 2026 (487c96d)
  - Cập nhật 26 tệp trên tất cả 10 thư mục hướng dẫn và 7 tài liệu tham khảo
  - Thêm tài liệu cho **Auto Memory** — học tập bền vững theo từng dự án
  - Thêm tài liệu cho **Remote Control**, **Web Sessions**, và **Desktop App**
  - Thêm tài liệu cho **Agent Teams** (cộng tác đa agent thực nghiệm)
  - Thêm tài liệu cho **MCP OAuth 2.0**, **Tool Search**, và **Claude.ai Connectors**
  - Thêm tài liệu cho **Persistent Memory** và **Worktree Isolation** cho các subagent
  - Thêm tài liệu cho **Background Subagents**, **Task List**, **Prompt Suggestions**
  - Thêm tài liệu cho **Sandboxing** và **Managed Settings** (Doanh nghiệp)
  - Thêm tài liệu cho **HTTP Hooks** và 7 sự kiện hook mới
  - Thêm tài liệu cho **Plugin Settings**, **LSP Servers**, và cập nhật Marketplace
  - Thêm tài liệu cho tùy chọn tua lại **Summarize from Checkpoint**
  - Tài liệu hóa 17 lệnh slash mới (`/fork`, `/desktop`, `/teleport`, `/tasks`, `/fast`, v.v.)
  - Tài liệu hóa các flag CLI mới (`--worktree`, `--from-pr`, `--remote`, `--teleport`, `--teammate-mode`, v.v.)
  - Tài liệu hóa các biến môi trường mới cho auto memory, mức độ nỗ lực, agent teams, và nhiều hơn nữa

### Thiết kế

- Thiết kế lại logo thành biểu tượng compass-bracket với bảng màu tối giản (20779db)

### Sửa lỗi / Điều chỉnh

- Cập nhật tên mô hình: Sonnet 4.5 → **Sonnet 4.6**, Opus 4.5 → **Opus 4.6**
- Sửa tên các chế độ cấp quyền: thay thế các tên giả định bằng tên thực tế `default`/`acceptEdits`/`plan`/`dontAsk`/`bypassPermissions`
- Sửa các sự kiện hook: loại bỏ các sự kiện giả định, thêm các sự kiện thực tế (`SubagentStart`, `WorktreeCreate`, `ConfigChange`, v.v.)
- Sửa cú pháp CLI: thay thế `claude-code --headless` bằng `claude -p` (chế độ in)
- Sửa các lệnh checkpoint: thay thế các lệnh giả bằng giao diện `Esc+Esc` / `/rewind` thực tế
- Sửa quản lý phiên làm việc: thay thế các lệnh giả bằng `/resume`/`/rename`/`/fork` thực tế
- Sửa định dạng manifest plugin: chuyển đổi `plugin.yaml` → `.claude-plugin/plugin.json`
- Sửa đường dẫn cấu hình MCP: `~/.claude/mcp.json` → `.mcp.json` (dự án) / `~/.claude.json` (người dùng)
- Sửa URL tài liệu: `docs.claude.com` → `docs.anthropic.com`
- Loại bỏ các trường cấu hình không có thực trên nhiều tệp
- Cập nhật tất cả các ngày "Cập nhật lần cuối" thành tháng 2 năm 2026

**Toàn bộ thay đổi**: https://github.com/luongnv89/claude-howto/compare/20779db...v2.0.0
