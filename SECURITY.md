# Chính sách bảo mật

## Tổng quan

Bảo mật của dự án Claude How To là điều quan trọng đối với chúng tôi. Tài liệu này phác thảo các thực hành bảo mật của chúng tôi và mô tả cách báo cáo các lỗ hổng bảo mật một cách có trách nhiệm.

## Các phiên bản được hỗ trợ

Chúng tôi cung cấp các bản cập nhật bảo mật cho các phiên bản sau:

| Phiên bản | Trạng thái | Hỗ trợ đến khi |
|---------|--------|---------------|
| Mới nhất (main) | ✅ Đang hoạt động | Hiện tại + 6 tháng |
| Các bản phát hành 1.x | ✅ Đang hoạt động | Cho đến phiên bản lớn tiếp theo |

**Ghi chú**: Là một dự án hướng dẫn giáo dục, chúng tôi tập trung vào việc duy trì các thực hành tốt nhất hiện tại và bảo mật tài liệu hơn là hỗ trợ phiên bản truyền thống. Các cập nhật được áp dụng trực tiếp vào nhánh `main`.

## Các thực hành bảo mật

### Bảo mật mã nguồn

1. **Quản lý phụ thuộc (Dependency Management)**
   - Tất cả các phụ thuộc Python được cố định trong `requirements.txt`
   - Cập nhật thường xuyên qua Dependabot và kiểm tra thủ công
   - Quét bảo mật với Bandit trên mỗi commit
   - Sử dụng pre-commit hooks cho các kiểm tra bảo mật

2. **Chất lượng mã nguồn**
   - Sử dụng Ruff để phát hiện các vấn đề phổ biến
   - Kiểm tra kiểu dữ liệu với mypy để ngăn chặn các lỗ hổng liên quan đến kiểu
   - Pre-commit hooks thực thi các tiêu chuẩn
   - Tất cả các thay đổi đều được xem xét trước khi merge

3. **Kiểm soát truy cập**
   - Bảo vệ nhánh `main`
   - Bắt buộc review trước khi merge
   - Các kiểm tra trạng thái phải vượt qua trước khi merge
   - Giới hạn quyền ghi vào kho lưu trữ

### Bảo mật tài liệu

1. **Không để lộ bí mật trong ví dụ**
   - Tất cả các khóa API trong ví dụ đều là giá trị làm mẫu (placeholders)
   - Thông tin xác thực không bao giờ được ghi cứng
   - Tệp `.env.example` hiển thị các biến bắt buộc
   - Cảnh báo rõ ràng về quản lý bí mật

2. **Thực hành tốt nhất về bảo mật**
   - Các ví dụ minh họa các mẫu (patterns) an toàn
   - Các cảnh báo bảo mật được làm nổi bật trong tài liệu
   - Liên kết đến các hướng dẫn bảo mật chính thức
   - Việc xử lý thông tin xác thực được thảo luận trong các phần liên quan

3. **Đánh giá nội dung**
   - Tất cả tài liệu được xem xét kỹ về các vấn đề bảo mật
   - Các cân nhắc bảo mật có trong hướng dẫn đóng góp
   - Xác minh các liên kết và tham chiếu bên ngoài

### Bảo mật phụ thuộc

1. **Quét lỗi (Scanning)**
   - Bandit quét tất cả mã Python để tìm lỗ hổng
   - Kiểm tra lỗ hổng phụ thuộc qua cảnh báo bảo mật của GitHub
   - Kiểm tra bảo mật thủ công định kỳ

2. **Cập nhật**
   - Các bản vá bảo mật được áp dụng kịp thời
   - Các phiên bản lớn được đánh giá cẩn thận
   - Nhật ký thay đổi (Changelog) bao gồm các cập nhật liên quan đến bảo mật

3. **Tính minh bạch**
   - Các cập nhật bảo mật được ghi lại trong các commit
   - Việc tiết lộ lỗ hổng được xử lý có trách nhiệm
   - Các thông báo bảo mật công khai khi thích hợp

## Báo cáo lỗ hổng

### Các vấn đề bảo mật chúng tôi quan tâm

Chúng tôi đánh giá cao các báo cáo về:
- **Lỗ hổng mã nguồn** trong các script hoặc ví dụ
- **Lỗ hổng phụ thuộc** trong các gói Python
- **Vấn đề về mật mã** trong bất kỳ ví dụ mã nào
- **Lỗi xác thực/phân quyền** trong tài liệu
- **Rủi ro lộ dữ liệu** trong các ví dụ cấu hình
- **Lỗ hổng Injection** (SQL, command, v.v.)
- **Vấn đề SSRF/XXE/Path traversal**

### Các vấn đề bảo mật nằm ngoài phạm vi

Những vấn đề sau nằm ngoài phạm vi của dự án này:
- Lỗ hổng trong chính Claude Code (vui lòng báo cáo cho Anthropic)
- Vấn đề với các dịch vụ hoặc thư viện bên ngoài (báo cáo cho bên cung cấp)
- Tấn công kỹ thuật xã hội (Social engineering) hoặc giáo dục người dùng
- Lỗ hổng lý thuyết mà không có bằng chứng thực tế (Proof of Concept)

## Cách báo cáo

### Báo cáo riêng tư (Khuyến nghị)

**Đối với các vấn đề bảo mật nhạy cảm, vui lòng sử dụng tính năng báo cáo lỗ hổng riêng tư của GitHub:**

1. Truy cập: https://github.com/luongnv89/claude-howto/security/advisories
2. Nhấn "Report a vulnerability"
3. Điền các chi tiết về lỗ hổng
4. Bao gồm:
   - Mô tả rõ ràng về lỗ hổng
   - Thành phần bị ảnh hưởng (tệp, phần, ví dụ)
   - Tác động tiềm tàng
   - Các bước để tái hiện
   - Đề xuất cách sửa (nếu có)

### Báo cáo công khai

Đối với các vấn đề không nhạy cảm hoặc đã công khai:

1. **Mở một GitHub Issue** với nhãn `security`
2. Bao gồm:
   - Tiêu đề: `[SECURITY]` kèm theo mô tả ngắn
   - Mô tả chi tiết
   - Tệp hoặc phần bị ảnh hưởng
   - Tác động tiềm tàng
   - Đề xuất cách sửa

## Quy trình phản hồi lỗ hổng

### Đánh giá (24 giờ)

1. Chúng tôi xác nhận đã nhận được báo cáo
2. Chúng tôi đánh giá mức độ nghiêm trọng bằng [CVSS v3.1](https://www.first.org/cvss/v3.1/specification-document)
3. Chúng tôi xác định xem nó có nằm trong phạm vi không
4. Chúng tôi liên hệ với bạn kèm theo đánh giá ban đầu

### Phát triển (1-7 ngày)

1. Chúng tôi phát triển bản vá
2. Chúng tôi xem xét và kiểm tra bản vá
3. Chúng tôi tạo một thông báo bảo mật
4. Chúng tôi chuẩn bị ghi chú phát hành (release notes)

### Công bố (thay đổi tùy theo mức độ nghiêm trọng)

**Nghiêm trọng (Critical - CVSS 9.0-10.0)**
- Bản vá được phát hành ngay lập tức
- Thông báo công khai được đưa ra
- Thông báo trước 24 giờ cho người báo cáo

**Cao (High - CVSS 7.0-8.9)**
- Bản vá được phát hành trong vòng 48-72 giờ
- Thông báo trước 5 ngày cho người báo cáo
- Thông báo công khai khi phát hành

**Trung bình (Medium - CVSS 4.0-6.9)**
- Bản vá được bao gồm trong cập nhật định kỳ tiếp theo
- Thông báo công khai khi phát hành

**Thấp (Low - CVSS 0.1-3.9)**
- Bản vá được bao gồm trong cập nhật định kỳ tiếp theo

## Thực hành tốt nhất cho người báo cáo

- **Xác minh vấn đề**: Bạn có thể tái hiện nó một cách nhất quán không?
- **Tìm kiếm các issue hiện có**: Nó đã được báo cáo chưa?
- **Kiểm tra tài liệu**: Đã có hướng dẫn về cách sử dụng an toàn chưa?
- **Kiểm tra bản vá**: Đề xuất sửa lỗi của bạn có hoạt động không?

## Nguyên tắc bảo mật cho người đóng góp

### Khi viết ví dụ

1. **Không bao giờ ghi cứng bí mật**
   ```python
   # ❌ Sai
   api_key = "sk-1234567890"

   # ✅ Đúng
   api_key = os.getenv("API_KEY")
   ```

2. **Cảnh báo về các tác động bảo mật**
   ```markdown
   ⚠️ **Lưu ý bảo mật**: Không bao giờ commit các tệp `.env` lên git.
   Thêm vào `.gitignore` ngay lập tức.
   ```

3. **Sử dụng các giá trị mặc định an toàn**
   - Bật xác thực theo mặc định
   - Sử dụng HTTPS khi có thể
   - Xác thực và làm sạch dữ liệu đầu vào
   - Sử dụng các truy vấn có tham số (parameterized queries)

### Khi review đóng góp

1. **Kiểm tra các bí mật bị lộ**
   - Quét các mẫu phổ biến (api_key=, password=)
   - Xem xét các tệp cấu hình
   - Kiểm tra các biến môi trường

2. **Xác minh các thực hành lập trình an toàn**
   - Không có thông tin xác thực ghi cứng
   - Xác thực đầu vào đúng cách
   - Xác thực/phân quyền an toàn

## Tài nguyên bảo mật

- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
- [CWE Top 25](https://cwe.mitre.org/top25/)
- [CVSS Calculator](https://www.first.org/cvss/calculator/3.1)

## Liên hệ

Đối với các câu hỏi liên quan đến bảo mật hoặc thảo luận về các thực hành bảo mật:

1. **Báo cáo bảo mật riêng tư**: Sử dụng tính năng báo cáo lỗ hổng của GitHub
2. **Câu hỏi bảo mật chung**: Mở một thảo luận với thẻ `[SECURITY]`
3. **Phản hồi chính sách bảo mật**: Tạo một issue với nhãn `security`

---

Cảm ơn bạn đã giúp giữ cho Claude How To được an toàn! 🔒
