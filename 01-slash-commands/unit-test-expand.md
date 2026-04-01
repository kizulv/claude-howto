---
name: Mở rộng Unit Tests
description: Tăng độ bao phủ kiểm thử bằng cách nhắm vào các nhánh chưa được kiểm thử và các trường hợp biên
tags: testing, coverage, unit-tests
---

# Mở rộng Unit Tests

Mở rộng các bài kiểm thử đơn vị (unit tests) hiện có phù hợp với framework kiểm thử của dự án:

1. **Phân tích độ bao phủ (Coverage)**: Chạy báo cáo độ bao phủ để xác định các nhánh chưa được kiểm thử, các trường hợp biên và các khu vực có độ bao phủ thấp
2. **Xác định lỗ hổng**: Rà soát mã nguồn để tìm các nhánh logic, các đường dẫn lỗi (error paths), điều kiện biên, đầu vào null/rỗng
3. **Viết các bài kiểm thử** sử dụng framework của dự án:
   - Jest/Vitest/Mocha (JavaScript/TypeScript)
   - pytest/unittest (Python)
   - Go testing/testify (Go)
   - Rust test framework (Rust)
4. **Nhắm mục tiêu vào các kịch bản cụ thể**:
   - Xử lý lỗi và các ngoại lệ (exceptions)
   - Các giá trị biên (min/max, rỗng, null)
   - Các trường hợp biên (edge cases) và các trường hợp góc (corner cases)
   - Chuyển đổi trạng thái và các tác dụng phụ (side effects)
5. **Xác minh sự cải thiện**: Chạy lại báo cáo độ bao phủ, xác nhận sự gia tăng có thể đo lường được

Chỉ trình bày các khối mã kiểm thử mới. Tuân theo các mẫu kiểm thử và quy ước đặt tên hiện có.
