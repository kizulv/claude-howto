---
name: code-review-specialist
description: Review mã nguồn toàn diện với phân tích bảo mật, hiệu năng và chất lượng. Sử dụng khi người dùng yêu cầu review code, phân tích chất lượng mã nguồn, đánh giá pull request, hoặc đề cập đến code review, phân tích bảo mật, hoặc tối ưu hóa hiệu năng.
---

# Kỹ năng Chuyên gia Review Mã nguồn (Code Review Skill)

Kỹ năng này cung cấp các khả năng review mã nguồn toàn diện tập trung vào:

1. **Phân tích Bảo mật (Security Analysis)**
   - Các vấn đề xác thực (authentication) và phân quyền (authorization)
   - Rủi ro lộ dữ liệu (data exposure)
   - Các lỗ hổng tiêm mã (injection)
   - Điểm yếu về mã hóa (cryptographic)
   - Ghi nhật ký (logging) dữ liệu nhạy cảm

2. **Review Hiệu năng (Performance Review)**
   - Hiệu quả thuật toán (phân tích Big O)
   - Tối ưu hóa bộ nhớ
   - Tối ưu hóa truy vấn cơ sở dữ liệu
   - Các cơ hội ghi nhớ đệm (caching)
   - Các vấn đề về đồng thời (concurrency)

3. **Chất lượng Mã nguồn (Code Quality)**
   - Các nguyên tắc SOLID
   - Các mẫu thiết kế (design patterns)
   - Quy ước đặt tên
   - Tài liệu hướng dẫn
   - Độ bao phủ kiểm thử (test coverage)

4. **Khả năng bảo trì (Maintainability)**
   - Khả năng đọc của mã nguồn
   - Kích thước hàm (nên < 50 dòng)
   - Độ phức tạp vòng đời (cyclomatic complexity)
   - Quản lý phụ thuộc (dependencies)
   - Tính an toàn của kiểu dữ liệu (type safety)

## Mẫu Review (Review Template)

Đối với mỗi đoạn mã được review, hãy cung cấp:

### Tóm tắt (Summary)
- Đánh giá chất lượng tổng thể (1-5)
- Số lượng các phát hiện chính
- Các khu vực ưu tiên được khuyến nghị

### Các vấn đề nghiêm trọng (Critical Issues - nếu có)
- **Vấn đề**: Mô tả rõ ràng
- **Vị trí**: Tên tệp và số dòng
- **Tác động**: Tại sao điều này lại quan trọng
- **Mức độ nghiêm trọng**: Nghiêm trọng/Cao/Trung bình (Critical/High/Medium)
- **Bản sửa lỗi**: Ví dụ mã nguồn

### Các phát hiện theo Danh mục (Findings by Category)

#### Bảo mật (Security - nếu tìm thấy vấn đề)
Liệt kê các lỗ hổng bảo mật kèm theo ví dụ.

#### Hiệu năng (Performance - nếu tìm thấy vấn đề)
Liệt kê các vấn đề hiệu năng kèm theo phân tích độ phức tạp.

#### Chất lượng (Quality - nếu tìm thấy vấn đề)
Liệt kê các vấn đề về chất lượng mã nguồn kèm theo các gợi ý tái cấu trúc.

#### Khả năng bảo trì (Maintainability - nếu tìm thấy vấn đề)
Liệt kê các vấn đề về khả năng bảo trì kèm theo các cải tiến.

## Lịch sử Phiên bản (Version History)

- v1.0.0 (2024-12-10): Phiên bản đầu tiên với phân tích bảo mật, hiệu năng, chất lượng và khả năng bảo trì.
