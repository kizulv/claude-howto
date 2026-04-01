---
name: Tái cấu trúc tài liệu
description: Tái cấu trúc tài liệu dự án để đảm bảo sự rõ ràng và dễ tiếp cận
tags: documentation, refactoring, organization
---

# Tái cấu trúc tài liệu

Tái cấu trúc cấu trúc tài liệu dự án phù hợp với loại hình dự án:

1. **Phân tích dự án**: Xác định loại hình (thư viện/API/web app/CLI/microservices), kiến trúc và đối tượng người dùng
2. **Tập trung hóa tài liệu**: Di chuyển tài liệu kỹ thuật vào thư mục `docs/` với các tham chiếu chéo phù hợp
3. **README.md ở gốc**: Tinh chỉnh làm điểm nhập cảnh với tổng quan, bắt đầu nhanh, tóm tắt các module/component, giấy phép, thông tin liên hệ
4. **Tài liệu cho các thành phần**: Thêm các file README ở cấp độ module/package/service với hướng dẫn thiết lập và kiểm thử
5. **Tổ chức thư mục `docs/`** theo các danh mục liên quan:
   - Kiến trúc (Architecture), Tham chiếu API (API Reference), Cơ sở dữ liệu (Database), Thiết kế (Design), Xử lý sự cố (Troubleshooting), Triển khai (Deployment), Đóng góp (Contributing) (điều chỉnh theo nhu cầu dự án)
6. **Tạo các hướng dẫn** (chọn các loại áp dụng):
   - Hướng dẫn người dùng (User Guide): Tài liệu dành cho người dùng cuối của ứng dụng
   - Tài liệu API (API Documentation): Các endpoint, xác thực, ví dụ cho API
   - Hướng dẫn phát triển (Development Guide): Thiết lập, kiểm thử, luồng công việc đóng góp
   - Hướng dẫn triển khai (Deployment Guide): Triển khai production cho các dịch vụ/ứng dụng
7. **Sử dụng Mermaid** cho tất cả các sơ đồ (kiến trúc, luồng công việc, schema)

Giữ cho tài liệu ngắn gọn, dễ quét và phù hợp với ngữ cảnh của loại hình dự án.
