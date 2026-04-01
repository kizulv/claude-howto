<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Hướng dẫn phong cách (Style Guide)

> Các quy ước và quy tắc định dạng để đóng góp cho Claude How To. Hãy tuân thủ hướng dẫn này để giữ cho nội dung nhất quán, chuyên nghiệp và dễ bảo trì.

---

## Mục lục

- [Đặt tên Tệp và Thư mục](#đặt-tên-tệp-và-thư-mục)
- [Cấu trúc tài liệu](#cấu-trúc-tài-liệu)
- [Tiêu đề (Headings)](#tiêu-đề-headings)
- [Định dạng văn bản](#định-dạng-văn-bản)
- [Danh sách (Lists)](#danh-sách-lists)
- [Bảng (Tables)](#bảng-tables)
- [Khối mã (Code Blocks)](#khối-mã-code-blocks)
- [Liên kết và Tham chiếu chéo](#liên kết-và-tham-chiếu-chéo)
- [Sơ đồ (Diagrams)](#sơ-đồ-diagrams)
- [Cách dùng Emoji](#cách-dùng-emoji)
- [YAML Frontmatter](#yaml-frontmatter)
- [Hình ảnh và Phương tiện](#hình-ảnh-và-phương-tiện)
- [Giọng văn và Thái độ](#giọng-văn-và-thái-độ)
- [Thông điệp Commit](#thông-điệp-commit)
- [Danh sách kiểm tra cho Tác giả](#danh-sách-kiểm-tra-cho-tác-giả)

---

## Đặt tên Tệp và Thư mục

### Thư mục bài học

Các thư mục bài học sử dụng **tiền tố số có hai chữ số** theo sau là phần mô tả định dạng **kebab-case**:

```
01-slash-commands/
02-memory/
03-skills/
04-subagents/
05-mcp/
```

Các con số phản ánh thứ tự lộ trình học tập từ cơ bản đến nâng cao.

### Tên tệp

| Loại | Quy ước | Ví dụ |
|------|-----------|----------|
| **Bài học README** | `README.md` | `01-slash-commands/README.md` |
| **Tệp tính năng** | Kebab-case `.md` | `code-reviewer.md`, `generate-api-docs.md` |
| **Shell script** | Kebab-case `.sh` | `format-code.sh`, `validate-input.sh` |
| **Tệp cấu hình** | Tên tiêu chuẩn | `.mcp.json`, `settings.json` |
| **Tệp bộ nhớ** | Tiền tố phạm vi | `project-CLAUDE.md`, `personal-CLAUDE.md` |
| **Tài liệu cấp cao** | CHỮ_HOA `.md` | `CATALOG.md`, `QUICK_REFERENCE.md`, `CONTRIBUTING.md` |
| **Hình ảnh** | Kebab-case | `pr-slash-command.png`, `claude-howto-logo.svg` |

### Quy tắc

- Sử dụng **chữ thường** cho tất cả tên tệp và thư mục (ngoại trừ các tài liệu cấp cao như `README.md`, `CATALOG.md`)
- Sử dụng **dấu gạch nối** (`-`) để phân tách từ, không bao giờ dùng dấu gạch dưới hoặc khoảng trắng
- Đặt tên mô tả nhưng súc tích

---

## Cấu trúc tài liệu

### README gốc

Tệp `README.md` ở thư mục gốc tuân theo thứ tự sau:

1. Logo (phần tử `<picture>` với các biến thể sáng/tối)
2. Tiêu đề H1
3. Đoạn trích dẫn giới thiệu (blockquote - giá trị cốt lõi trong một dòng)
4. Phần "Tại sao có hướng dẫn này?" với bảng so sánh
5. Đường kẻ ngang (`---`)
6. Mục lục
7. Danh mục tính năng
8. Điều hướng nhanh
9. Lộ trình học tập
10. Các phần tính năng
11. Bắt đầu (Getting Started)
12. Thực hành tốt nhất / Khắc phục sự cố
13. Đóng góp / Giấy phép

### README bài học

Mỗi bài học `README.md` tuân theo thứ tự sau:

1. Tiêu đề H1 (ví dụ: `# Slash Commands`)
2. Đoạn văn tổng quan ngắn gọn
3. Bảng tham khảo nhanh (tùy chọn)
4. Sơ đồ kiến trúc (Mermaid)
5. Các phần chi tiết (H2)
6. Các ví dụ thực tế (đánh số, từ 4-6 ví dụ)
7. Thực hành tốt nhất (bảng Nên và Không nên)
8. Khắc phục sự cố
9. Các hướng dẫn liên quan / Tài liệu chính thức
10. Chân trang siêu dữ liệu tài liệu

### Tệp Tính năng/Ví dụ

Các tệp tính năng riêng lẻ (ví dụ: `optimize.md`, `pr.md`):

1. YAML frontmatter (nếu có)
2. Tiêu đề H1
3. Mục đích / Mô tả
4. Hướng dẫn sử dụng
5. Các ví dụ mã
6. Mẹo tùy chỉnh

### Phân cách các phần

Sử dụng đường kẻ ngang (`---`) để phân tách các vùng chính trong tài liệu:

```markdown
---

## Phần chính mới
```

Đặt chúng sau phần trích dẫn giới thiệu và giữa các phần logic khác nhau của tài liệu.

---

## Tiêu đề (Headings)

### Phân cấp

| Cấp | Sử dụng | Ví dụ |
|-------|-----|---------|
| `#` H1 | Tiêu đề trang (một tệp có một tiêu đề) | `# Slash Commands` |
| `##` H2 | Các phần chính | `## Thực hành tốt nhất` |
| `###` H3 | Các phần phụ | `### Thêm một Skill` |
| `####` H4 | Phần phụ nhỏ hơn (hiếm dùng) | `#### Các tùy chọn cấu hình` |

### Quy tắc

- **Một H1 mỗi tài liệu** — chỉ dành cho tiêu đề trang
- **Không bao giờ nhảy cấp** — không nhảy từ H2 sang H4
- **Giữ tiêu đề súc tích** — mục tiêu từ 2-5 từ
- **Sử dụng viết hoa chữ cái đầu** — chỉ viết hoa từ đầu tiên và danh từ riêng (ngoại trừ: tên tính năng giữ nguyên)
- **Chỉ thêm tiền tố emoji trên các tiêu đề phần README gốc** (xem [Cách dùng Emoji](#cách-dùng-emoji))

---

## Định dạng văn bản

### Nhấn mạnh

| Kiểu | Khi nào sử dụng | Ví dụ |
|-------|------------|---------|
| **In đậm** (`**văn bản**`) | Các thuật ngữ chính, nhãn trong bảng, khái niệm quan trọng | `**Cài đặt**:` |
| *In nghiêng* (`*văn bản*`) | Lần đầu dùng thuật ngữ kỹ thuật, tiêu đề sách/tài liệu | `*frontmatter*` |
| `Code` (`` `văn bản` ``) | Tên tệp, câu lệnh, giá trị cấu hình, tham chiếu mã | `` `CLAUDE.md` `` |

### Blockquotes cho các ghi chú

Sử dụng blockquotes với tiền tố in đậm cho các lưu ý quan trọng:

```markdown
> **Ghi chú**: Các câu lệnh slash tùy chỉnh đã được gộp vào skills kể từ v2.0.

> **Quan trọng**: Không bao giờ commit các khóa API hoặc thông tin xác thực.

> **Mẹo**: Kết hợp bộ nhớ với skills để đạt hiệu quả tối đa.
```

Các loại ghi chú được hỗ trợ: **Ghi chú** (Note), **Quan trọng** (Important), **Mẹo** (Tip), **Cảnh báo** (Warning).

---

## Danh sách (Lists)

### Danh sách không thứ tự

Sử dụng dấu gạch ngang (`-`) với thụt đầu dòng 2 khoảng trắng để lồng nhau:

```markdown
- Mục thứ nhất
- Mục thứ hai
  - Mục con
  - Một mục con khác
    - Mục sâu hơn (tránh đi sâu quá 3 cấp)
- Mục thứ ba
```

### Danh sách có thứ tự

Sử dụng danh sách đánh số cho các bước tuần tự, hướng dẫn và các mục có xếp hạng:

```markdown
1. Bước đầu tiên
2. Bước thứ hai
   - Chi tiết điểm phụ
   - Một điểm phụ khác
3. Bước thứ ba
```

### Quy tắc

- Duy trì thụt đầu dòng nhất quán (2 khoảng trắng mỗi cấp)
- Thêm một dòng trống trước và sau một danh sách
- Tránh lồng nhau sâu quá 3 cấp

---

## Bảng (Tables)

### Định dạng tiêu chuẩn

```markdown
| Cột 1 | Cột 2 | Cột 3 |
|----------|----------|----------|
| Dữ liệu  | Dữ liệu  | Dữ liệu  |
```

### Quy tắc

- **In đậm tiêu đề bảng** khi chúng là nhãn hàng (cột đầu tiên)
- Giữ nội dung trong ô súc tích; sử dụng liên kết cho chi tiết
- Sử dụng `định dạng mã` cho các câu lệnh và đường dẫn tệp bên trong ô

---

## Khối mã (Code Blocks)

### Thẻ ngôn ngữ (Language Tags)

Luôn chỉ định thẻ ngôn ngữ để làm nổi bật cú pháp:

| Ngôn ngữ | Thẻ | Sử dụng cho |
|----------|-----|---------|
| Shell | `bash` | Các câu lệnh CLI, script |
| Python | `python` | Mã Python |
| JSON | `json` | Tệp cấu hình |
| YAML | `yaml` | Frontmatter, cấu hình |
| Markdown | `markdown` | Ví dụ Markdown |
| Plain text | (không thẻ) | Kết quả mong đợi, cây thư mục |

---

## Liên kết và Tham chiếu chéo

### Liên kết nội bộ (Tương đối)

Sử dụng đường dẫn tương đối cho tất cả các liên kết nội bộ:

```markdown
[Slash Commands](01-slash-commands/)
[Hướng dẫn Skills](03-skills/)
```

### Liên kết ngoài (Tuyệt đối)

Sử dụng URL đầy đủ với văn bản liên kết mô tả:

```markdown
[Tài liệu chính thức của Anthropic](https://code.claude.com/docs/en/overview)
```

- Không bao giờ sử dụng "nhấn vào đây" làm văn bản liên kết

---

## Sơ đồ (Diagrams)

### Mermaid

Sử dụng Mermaid cho tất cả các sơ đồ.

### Quy tắc

- Sử dụng `["Văn bản nhãn"]` cho nhãn node (cho phép ký tự đặc biệt)
- Giữ sơ đồ đơn giản (tối đa 10-12 nodes)
- Thêm mô tả văn bản ngắn bên dưới sơ đồ để hỗ trợ khả năng truy cập (accessibility)
- Sử dụng trên-dưới (`TB`) cho phân cấp, trái-sang-phải (`LR`) cho quy trình làm việc

---

## Cách dùng Emoji

### Nơi sử dụng Emoji

Emoji được sử dụng **tiết kiệm và có mục đích** — chỉ trong các ngữ cảnh cụ thể:

| Ngữ cảnh | Emojis | Ví dụ |
|---------|--------|---------|
| Tiêu đề phần README gốc | Các biểu tượng danh mục | `## 📚 Lộ trình học tập` |
| Chỉ báo cấp độ kỹ năng | Các vòng tròn màu | 🟢 Người mới, 🔵 Trung cấp, 🔴 Nâng cao |
| Nên và Không nên | Dấu tích/gạch chéo | ✅ Nên làm, ❌ Không nên làm |
| Xếp hạng độ phức tạp | Các ngôi sao | ⭐⭐⭐ |

---

## YAML Frontmatter

### Tệp tính năng (Skills, Commands, Agents)

```yaml
---
name: dinh-danh-duy-nhat
description: Tính năng này làm gì và khi nào nên dùng
allowed-tools: Bash, Read, Grep
---
```

### Quy tắc

- Đặt frontmatter ở ngay đầu tệp
- Sử dụng **kebab-case** cho trường `name`
- Giữ `description` trong một câu

---

## Giọng văn và Thái độ

### Phong cách viết

- **Chuyên nghiệp nhưng dễ tiếp cận** — chính xác về kỹ thuật mà không gây ngợp bởi thuật ngữ chuyên ngành
- **Thể chủ động** — "Tạo một tệp" thay vì "Một tệp nên được tạo"
- **Hướng dẫn trực tiếp** — "Chạy lệnh này" thay vì "Bạn có thể muốn chạy lệnh này"
- **Thân thiện với người mới** — giả định người đọc mới sử dụng Claude Code, chứ không phải mới học lập trình

---

## Danh sách kiểm tra cho Tác giả

Trước khi gửi nội dung, hãy kiểm tra:

- [ ] Tên tệp/thư mục dùng kebab-case
- [ ] Tài liệu bắt đầu bằng tiêu đề H1 (một tệp có một cái)
- [ ] Phân cấp tiêu đề chính xác (không nhảy cấp)
- [ ] Tất cả khối mã có thẻ ngôn ngữ
- [ ] Các ví dụ mã sẵn sàng để sao chép-dán
- [ ] Liên kết nội bộ dùng đường dẫn tương đối
- [ ] Liên kết ngoài có văn bản liên kết mô tả
- [ ] Bảng được định dạng đúng
- [ ] Emojis tuân thủ bộ tiêu chuẩn (nếu có dùng)
- [ ] Sơ đồ Mermaid dùng bảng màu tiêu chuẩn
- [ ] Không có thông tin nhạy cảm (khóa API, thông tin xác thực)
- [ ] Hình ảnh có văn bản thay thế (alt text)
- [ ] Các đoạn văn ngắn và tập trung
- [ ] Thông điệp commit tuân theo định dạng conventional commits
