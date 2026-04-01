---
name: claude-md
description: Tạo hoặc cập nhật các tệp CLAUDE.md theo các thực hành tốt nhất để tối ưu hóa việc cung cấp ngữ cảnh (onboarding) cho các AI agent.
---

## Nhập liệu từ Người dùng (User Input)

```text
$ARGUMENTS
```

Bạn **PHẢI** xem xét nội dung nhập liệu của người dùng trước khi tiếp tục (nếu không trống). Người dùng có thể chỉ định:
- `create` - Tạo một tệp CLAUDE.md mới từ đầu
- `update` - Cải thiện tệp CLAUDE.md hiện có
- `audit` - Phân tích và báo cáo về chất lượng của tệp CLAUDE.md hiện tại
- Một đường dẫn cụ thể để tạo/cập nhật (ví dụ: `src/api/CLAUDE.md` cho các hướng dẫn đặc thù của thư mục)

## Các nguyên tắc cốt lõi (Core Principles)

**LLM là phi trạng thái (stateless)**: CLAUDE.md là tệp duy nhất được tự động bao gồm trong mọi cuộc hội thoại. Nó đóng vai trò là tài liệu gia nhập (onboarding) chính cho các AI agent vào mã nguồn của bạn.

### Các Quy tắc Vàng (The Golden Rules)

1. **Càng ít càng tốt (Less is More)**: Các LLM hàng đầu có thể tuân thủ khoảng 150-200 hướng dẫn. Prompt hệ thống của Claude Code đã sử dụng khoảng 50. Hãy giữ tệp CLAUDE.md của bạn tập trung và súc tích.

2. **Tính ứng dụng toàn cục (Universal Applicability)**: Chỉ bao gồm thông tin liên quan đến MỌI phiên làm việc. Các hướng dẫn đặc thù cho từng tác vụ nên thuộc về các tệp riêng biệt.

3. **Đừng dùng Claude làm Linter**: Các hướng dẫn về phong cách viết mã (style guidelines) làm phình to ngữ cảnh và làm giảm khả năng tuân thủ hướng dẫn. Thay vào đó, hãy sử dụng các công cụ mang tính xác định (deterministic) như prettier, eslint, v.v.

4. **Không bao giờ tự động tạo**: CLAUDE.md là điểm tác động cao nhất của hệ thống AI. Hãy soạn thảo nó một cách thủ công với sự cân nhắc kỹ lưỡng.

## Luồng thực thi (Execution Flow)

### 1. Phân tích Dự án

Trước tiên, hãy phân tích trạng thái dự án hiện tại:

1. Kiểm tra các tệp CLAUDE.md hiện có:
   - Cấp độ gốc (Root): `./CLAUDE.md` hoặc `.claude/CLAUDE.md`
   - Đặc thù thư mục: `**/CLAUDE.md`
   - Cấu hình người dùng toàn cục: `~/.claude/CLAUDE.md`

2. Xác định cấu trúc dự án:
   - Công nghệ (ngôn ngữ, framework)
   - Loại dự án (monorepo, ứng dụng đơn lẻ, thư viện)
   - Các công cụ phát triển (trình quản lý gói, hệ thống build, trình chạy kiểm thử)

3. Xem xét tài liệu hiện có:
   - README.md
   - CONTRIBUTING.md
   - package.json, pyproject.toml, Cargo.toml, v.v.

### 2. Chiến lược Nội dung (CÁI GÌ, TẠI SAO, NHƯ THẾ NÀO)

Cấu trúc CLAUDE.md xung quanh ba khía cạnh:

#### CÁI GÌ (WHAT) - Công nghệ & Cấu trúc
- Tổng quan về các công nghệ (Tech stack)
- Tổ chức dự án (đặc biệt quan trọng đối với monorepo)
- Các thư mục chính và mục đích của chúng

#### TẠI SAO (WHY) - Mục đích & Ngữ cảnh
- Dự án làm gì
- Tại sao một số quyết định kiến trúc lại được đưa ra
- Nhiệm vụ của từng thành phần chính là gì

#### NHƯ THẾ NÀO (HOW) - Quy trình & Quy ước
- Quy trình phát triển (bun vs node, pip vs uv, v.v.)
- Các quy trình và lệnh kiểm thử
- Các phương pháp xác minh và build
- Các lưu ý quan trọng (gotchas) hoặc các yêu cầu không hiển nhiên

### 3. Chiến lược Tiết lộ Lũy tiến (Progressive Disclosure Strategy)

Đối với các dự án lớn hơn, khuyến nghị tạo thư mục `agent_docs/`:

```
agent_docs/
  |- building_the_project.md
  |- running_tests.md
  |- code_conventions.md
  |- architecture_decisions.md
```

Trong CLAUDE.md, hãy tham chiếu các tệp này với các hướng dẫn như:
```markdown
Để biết hướng dẫn build chi tiết, hãy xem tệp `agent_docs/building_the_project.md`
```

**Quan trọng**: Sử dụng tham chiếu `tên_tệp:dòng` thay vì các đoạn mã (code snippets) để tránh ngữ cảnh bị lạc hậu.

### 4. Các ràng buộc về Chất lượng

Khi tạo hoặc cập nhật CLAUDE.md:

1. **Độ dài mục tiêu**: Dưới 300 dòng (lý tưởng là dưới 100)
2. **Không quy tắc phong cách (Style Rules)**: Loại bỏ bất kỳ hướng dẫn linting/formatting nào
3. **Không hướng dẫn đặc thù cho tác vụ**: Chuyển sang các tệp riêng biệt
4. **Không đoạn mã**: Sử dụng tham chiếu tệp thay thế
5. **Không thông tin dư thừa**: Đừng lặp lại những gì đã có trong package.json hoặc README

### 5. Các phần thiết yếu

Một tệp CLAUDE.md được cấu trúc tốt nên bao gồm:

```markdown
# Tên Dự án

Mô tả ngắn gọn trong một dòng.

## Công nghệ (Tech Stack)
- Ngôn ngữ chính và phiên bản
- Các framework/thư viện quan trọng
- Cơ sở dữ liệu/lưu trữ (nếu có)

## Cấu trúc Dự án
[Chỉ dành cho monorepo hoặc cấu trúc phức tạp]
- `apps/` - Điểm vào của ứng dụng
- `packages/` - Các thư viện dùng chung

## Các lệnh phát triển
- Cài đặt: `lệnh`
- Kiểm thử: `lệnh`
- Build: `lệnh`

## Các quy ước quan trọng
[Chỉ dành cho các quy ước không hiển nhiên, có tác động cao]
- Quy ước 1 với giải thích ngắn gọn
- Quy ước 2 với giải thích ngắn gọn

## Các vấn đề đã biết / Lưu ý (Gotchas)
[Những thứ thường làm khó các lập trình viên]
- Vấn đề 1
- Vấn đề 2
```

### 6. Các phản mẫu (Anti-Patterns) cần tránh

**KHÔNG bao gồm:**
- Hướng dẫn phong cách mã nguồn (hãy dùng linter)
- Tài liệu về cách sử dụng Claude
- Giải thích dài dòng về các mẫu hình (patterns) hiển nhiên
- Sao chép-dán các ví dụ mã nguồn
- Các thực hành tốt mang tính chung chung ("viết mã sạch")
- Hướng dẫn cho các tác vụ cụ thể
- Nội dung tự động tạo
- Danh sách TODO kéo dài

### 7. Danh sách kiểm tra Xác minh (Validation Checklist)

Trước khi hoàn tất, hãy xác minh:

- [ ] Dưới 300 dòng (ưu tiên dưới 100)
- [ ] Mọi dòng đều áp dụng cho TẤT CẢ các phiên làm việc
- [ ] Không có quy tắc phong cách/định dạng
- [ ] Không có các đoạn mã (sử dụng tham chiếu tệp)
- [ ] Các lệnh đã được xác minh là hoạt động
- [ ] Sử dụng chiến lược tiết lộ lũy tiến cho các dự án phức tạp
- [ ] Các lưu ý quan trọng (gotchas) đã được ghi lại
- [ ] Không dư thừa so với README.md

## Định dạng Đầu ra

### Cho lệnh `create` hoặc mặc định:

1. Phân tích dự án
2. Soạn thảo một tệp CLAUDE.md theo cấu trúc trên
3. Trình bày bản thảo để người dùng review
4. Ghi vào vị trí thích hợp sau khi được phê duyệt

### Cho lệnh `update`:

1. Đọc tệp CLAUDE.md hiện có
2. Kiểm tra dựa trên các thực hành tốt nhất
3. Xác định:
   - Nội dung cần loại bỏ (quy tắc phong cách, đoạn mã, tác vụ cụ thể)
   - Nội dung cần cô đọng
   - Các thông tin thiết yếu còn thiếu
4. Trình bày các thay đổi để review
5. Áp dụng các thay đổi sau khi được phê duyệt

### Cho lệnh `audit`:

1. Đọc tệp CLAUDE.md hiện có
2. Tạo một báo cáo bao gồm:
   - Số dòng hiện tại so với mục tiêu
   - Tỷ lệ nội dung có tính ứng dụng toàn cục
   - Danh sách các phản mẫu (anti-patterns) được tìm thấy
   - Các đề xuất cải thiện
3. KHÔNG chỉnh sửa tệp, chỉ báo cáo

## Xử lý AGENTS.md

Nếu người dùng yêu cầu tạo/cập nhật AGENTS.md:

AGENTS.md được sử dụng để định nghĩa hành vi của các agent chuyên biệt. Khác với CLAUDE.md (dành cho ngữ cảnh dự án), AGENTS.md định nghĩa:
- Các vai trò và khả năng tùy chỉnh của agent
- Các hướng dẫn và ràng buộc đặc thù của agent
- Định nghĩa quy trình làm việc (workflow) cho các kịch bản đa agent

Áp dụng các nguyên tắc tương tự:
- Giữ sự tập trung và súc tích
- Sử dụng tiết lộ lũy tiến
- Tham chiếu đến các tài liệu bên ngoài thay vì nhúng toàn bộ nội dung

## Ghi chú

- Luôn xác minh các lệnh hoạt động trước khi đưa chúng vào
- Khi còn nghi ngờ, hãy loại bỏ - càng ít càng tốt
- Lời nhắc hệ thống nói với Claude rằng CLAUDE.md "có thể có hoặc không liên quan" - càng nhiều thông tin nhiễu, nó càng dễ bị bỏ qua
- Các monorepo hưởng lợi nhiều nhất từ cấu trúc CÁI GÌ/TẠI SAO/NHƯ THẾ NÀO rõ ràng
- Các tệp CLAUDE.md đặc thù cho từng thư mục nên được tập trung nhiều hơn nữa
