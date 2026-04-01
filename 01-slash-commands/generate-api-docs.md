---
description: Tạo tài liệu API toàn diện từ mã nguồn
---

# Trình tạo tài liệu API

Tạo tài liệu API bằng cách:

1. Quét tất cả các file trong `/src/api/`
2. Trích xuất các chữ ký hàm (function signatures) và các bình luận JSDoc
3. Tổ chức theo endpoint/module
4. Tạo file markdown với các ví dụ thực tế
5. Bao gồm các schema yêu cầu/phản hồi (request/response schemas)
6. Thêm tài liệu về các lỗi (error documentation)

Định dạng đầu ra:
- File Markdown tại `/docs/api.md`
- Bao gồm các ví dụ lệnh curl cho tất cả các endpoint
- Thêm các kiểu dữ liệu TypeScript (TypeScript types)
