<picture>
  <source media="(prefers-color-scheme: dark)" srcset="resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="resources/logos/claude-howto-logo.svg">
</picture>

# Đóng góp cho Claude How To

Cảm ơn bạn đã quan tâm đến việc đóng góp cho dự án này! Hướng dẫn này sẽ giúp bạn hiểu cách đóng góp một cách hiệu quả.

## Về dự án này

Claude How To là một hướng dẫn trực quan, dựa trên ví dụ cho Claude Code. Chúng tôi cung cấp:
- **Sơ đồ Mermaid** giải thích cách thức hoạt động của các tính năng
- **Mẫu sẵn sàng cho sản phẩm (Production-ready templates)** bạn có thể dùng ngay
- **Ví dụ thực tế** kèm theo ngữ cảnh và các thực hành tốt nhất
- **Lộ trình học tập lũy tiến** từ cơ bản đến nâng cao

## Các loại đóng góp

### 1. Ví dụ hoặc Mẫu mới
Thêm ví dụ cho các tính năng hiện có (slash commands, skills, hooks, v.v.):
- Mã nguồn sẵn sàng để sao chép-dán
- Giải thích rõ ràng về cách thức hoạt động
- Các tình huống sử dụng và lợi ích
- Mẹo khắc phục sự cố

### 2. Cải thiện tài liệu
- Làm rõ các phần gây khó hiểu
- Sửa lỗi chính tả và ngữ pháp
- Thêm các thông tin còn thiếu
- Cải thiện các ví dụ mã

### 3. Hướng dẫn tính năng
Tạo hướng dẫn cho các tính năng mới của Claude Code:
- Hướng dẫn từng bước
- Sơ đồ kiến trúc
- Các mẫu (patterns) phổ biến và các lỗi cần tránh (anti-patterns)
- Quy trình làm việc thực tế

### 4. Báo cáo lỗi
Báo cáo các vấn đề bạn gặp phải:
- Mô tả những gì bạn mong đợi
- Mô tả những gì thực tế đã xảy ra
- Bao gồm các bước để tái hiện
- Thêm phiên bản Claude Code và hệ điều hành (OS) liên quan

### 5. Phản hồi và Đề xuất
Giúp cải thiện hướng dẫn:
- Đề xuất các cách giải thích tốt hơn
- Chỉ ra các lỗ hổng trong nội dung
- Đề xuất các phần mới hoặc sắp xếp lại cấu trúc

## Bắt đầu

### 1. Fork và Clone
```bash
git clone https://github.com/luongnv89/claude-howto.git
cd claude-howto
```

### 2. Tạo một Branch
Sử dụng tên branch có tính mô tả:
```bash
git checkout -b add/feature-name
git checkout -b fix/issue-description
git checkout -b docs/improvement-area
```

### 3. Thiết lập môi trường
```bash
# Tạo môi trường ảo
python3 -m venv .venv
source .venv/bin/activate

# Cài đặt pre-commit hooks (tùy chọn nhưng khuyến nghị)
pip install pre-commit
pre-commit install

# Chạy kiểm tra pre-commit thủ công
pre-commit run --all-files
```

## Cấu trúc thư mục

```
├── 01-slash-commands/      # Các phím tắt người dùng gọi
├── 02-memory/              # Các ví dụ về ngữ cảnh bền vững
├── 03-skills/              # Các khả năng có thể tái sử dụng
├── 04-subagents/           # Các trợ lý AI chuyên biệt
├── 05-mcp/                 # Các ví dụ Model Context Protocol
├── 06-hooks/               # Tự động hóa dựa trên sự kiện
├── 07-plugins/             # Các tính năng đóng gói
├── 08-checkpoints/         # Ảnh chụp nhanh phiên làm việc
├── 09-advanced-features/   # Planning, thinking, backgrounds
├── 10-cli/                 # Tham chiếu CLI
├── scripts/                # Script build và tiện ích
└── README.md               # Hướng dẫn chính
```

## Cách đóng góp ví dụ

### Thêm một Slash Command
1. Tạo một tệp `.md` trong `01-slash-commands/`
2. Bao gồm:
   - Mô tả rõ ràng về chức năng
   - Các tình huống sử dụng
   - Hướng dẫn cài đặt
   - Ví dụ sử dụng
   - Mẹo tùy chỉnh
3. Cập nhật `01-slash-commands/README.md`

### Thêm một Skill
1. Tạo một thư mục trong `03-skills/`
2. Bao gồm:
   - `SKILL.md` - Tài liệu chính
   - `scripts/` - Script hỗ trợ nếu cần
   - `templates/` - Các mẫu prompt
   - Ví dụ sử dụng trong README
3. Cập nhật `03-skills/README.md`

## Hướng dẫn viết lách

### Phong cách Markdown
- Sử dụng các tiêu đề rõ ràng (H2 cho các phần chính, H3 cho các phần phụ)
- Giữ các đoạn văn ngắn và tập trung
- Sử dụng gạch đầu dòng cho danh sách
- Bao gồm các khối mã với chỉ định ngôn ngữ
- Thêm dòng trống giữa các phần

### Các ví dụ mã
- Đảm bảo ví dụ sẵn sàng để sao chép-dán
- Chú thích các logic không hiển nhiên
- Bao gồm cả phiên bản đơn giản và nâng cao
- Hiển thị các tình huống sử dụng thực tế

## Quy tắc Commit

Tuân theo định dạng conventional commit:
```
type(scope): mô tả

[phần thân tùy chọn]
```

Các loại (Types):
- `feat`: Tính năng hoặc ví dụ mới
- `fix`: Sửa lỗi hoặc đính chính
- `docs`: Các thay đổi về tài liệu
- `refactor`: Tái cấu trúc mã
- `style`: Các thay đổi về định dạng
- `test`: Thêm hoặc thay đổi kiểm thử
- `chore`: Build, phụ thuộc, v.v.

Ví dụ:
```
feat(slash-commands): Thêm trình tạo tài liệu API
docs(memory): Cải thiện ví dụ về tùy chỉnh cá nhân
fix(README): Sửa lỗi liên kết mục lục
docs(skills): Thêm skill review mã nguồn toàn diện
```

## Trước khi gửi

### Danh sách kiểm tra
- [ ] Mã tuân thủ phong cách và quy ước của dự án
- [ ] Các ví dụ mới bao gồm tài liệu rõ ràng
- [ ] Các tệp README đã được cập nhật (cả ở thư mục bộ phận và gốc)
- [ ] Không có thông tin nhạy cảm (khóa API, thông tin xác thực)
- [ ] Các ví dụ đã được kiểm tra và hoạt động đúng
- [ ] Các liên kết đã được xác minh và chính xác
- [ ] Các tệp có quyền hạn phù hợp (scripts có quyền thực thi)
- [ ] Thông điệp commit rõ ràng và có tính mô tả

## Quy trình Pull Request

1. **Tạo PR với mô tả rõ ràng**:
   - PR này thêm/sửa cái gì?
   - Tại sao nó cần thiết?
   - Các issue liên quan (nếu có)

2. **Bao gồm các chi tiết liên quan**:
   - Tính năng mới? Bao gồm các tình huống sử dụng
   - Tài liệu? Giải thích các điểm cải thiện
   - Ví dụ? Hiển thị trước/sau khi thay đổi

3. **Liên kết tới issues**:
   - Sử dụng `Closes #123` để tự động đóng các issue liên quan

4. **Kiên nhẫn với các phản hồi**:
   - Người duy trì có thể đề xuất các cải tiến
   - Lặp lại dựa trên phản hồi

## Chính sách dự án

### Thông tin nhạy cảm
- Không bao giờ commit khóa API, token hoặc thông tin xác thực
- Sử dụng các giá trị làm mẫu trong các ví dụ
- Bao gồm `.env.example` cho các tệp cấu hình
- Viết tài liệu về các biến môi trường bắt buộc

### Chất lượng mã nguồn
- Giữ các ví dụ tập trung và dễ đọc
- Tránh các giải pháp quá phức tạp (over-engineering)
- Chú thích cho các logic không hiển nhiên
- Kiểm tra kỹ lưỡng trước khi gửi

## Nhận sự trợ giúp

- **Câu hỏi**: Mở một cuộc thảo luận trong GitHub Issues
- **Trợ giúp chung**: Kiểm tra tài liệu hiện có
- **Trợ giúp phát triển**: Xem lại các ví dụ tương tự

## Bảo mật

Khi đóng góp ví dụ và tài liệu, vui lòng tuân thủ các thực hành lập trình an toàn:
- **Không bao giờ ghi cứng (hardcode) bí mật hoặc khóa API** - Sử dụng biến môi trường
- **Cảnh báo về các tác động bảo mật** - Nêu bật các rủi ro tiềm ẩn

Đối với các vấn đề bảo mật, xem [SECURITY.md](SECURITY.md) về quy trình báo cáo lỗ hổng của chúng tôi.

## Quy tắc ứng xử

Chúng tôi cam kết cung cấp một cộng đồng cởi mở và hòa nhập. Vui lòng đọc [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) để biết đầy đủ các tiêu chuẩn cộng đồng của chúng tôi.

Tóm lại:
- Hãy tôn trọng và hòa nhập
- Đón nhận phản hồi một cách lịch sự
- Tránh quấy rối hoặc phân biệt đối xử

## Giấy phép

Bằng cách đóng góp cho dự án này, bạn đồng ý rằng các đóng góp của bạn sẽ được cấp phép theo Giấy phép MIT. Xem tệp [LICENSE](LICENSE) để biết chi tiết.

Cảm ơn bạn đã đóng góp! 🙏
