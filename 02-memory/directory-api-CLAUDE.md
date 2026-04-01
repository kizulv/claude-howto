# Tiêu chuẩn Module API

Tệp này ghi đè tệp CLAUDE.md gốc cho tất cả các nội dung trong /src/api/

## Các tiêu chuẩn đặc thù cho API

### Xác thực yêu cầu (Request Validation)
- Sử dụng Zod cho xác thực schema
- Luôn xác thực đầu vào
- Trả về mã 400 kèm theo các lỗi xác thực
- Bao gồm chi tiết lỗi ở mức độ trường dữ liệu

### Xác thực người dùng (Authentication)
- Tất cả các endpoint đều yêu cầu mã JWT (JWT token)
- Token nằm trong header Authorization
- Token hết hạn sau 24 giờ
- Triển khai cơ chế refresh token

### Định dạng phản hồi

Tất cả các phản hồi phải tuân theo cấu trúc này:

```json
{
  "success": true,
  "data": { /* dữ liệu thực tế */ },
  "timestamp": "2025-11-06T10:30:00Z",
  "version": "1.0"
}
```

Phản hồi lỗi:
```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Thông báo cho người dung",
    "details": { /* lỗi chi tiết theo từng trường */ }
  },
  "timestamp": "2025-11-06T10:30:00Z"
}
```

### Phân trang (Pagination)
- Sử dụng phân trang dựa trên con trỏ (cursor-based pagination), không dùng offset
- Bao gồm biến boolean `hasMore`
- Giới hạn kích thước trang tối đa là 100
- Kích thước trang mặc định: 20

### Giới hạn tốc độ (Rate Limiting)
- 1000 yêu cầu mỗi giờ cho người dùng đã xác thực
- 100 yêu cầu mỗi giờ cho các endpoint công khai
- Trả về mã 429 khi vượt quá giới hạn
- Bao gồm header retry-after

### Ghi nhớ đệm (Caching)
- Sử dụng Redis để lưu trữ session
- Thời gian lưu trữ mặc định: 5 phút
- Hủy bỏ cache (invalidate) khi có các hoạt động ghi
- Gán thẻ (tag) cho các khóa cache theo loại tài nguyên
