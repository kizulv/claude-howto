---
name: api-documentation-generator
description: Tạo tài liệu API toàn diện và chính xác từ mã nguồn. Sử dụng khi tạo hoặc cập nhật tài liệu API, tạo đặc tả OpenAPI, hoặc khi người dùng đề cập đến tài liệu API, các endpoint hoặc tài liệu hướng dẫn.
---

# Kỹ năng Tạo Tài liệu API (API Documentation Generator Skill)

## Các thành phần tạo ra (Generates)

- Đặc tả OpenAPI/Swagger
- Tài liệu về các endpoint API
- Các ví dụ sử dụng SDK
- Hướng dẫn tích hợp
- Tham chiếu mã lỗi
- Hướng dẫn xác thực

## Cấu trúc Tài liệu (Documentation Structure)

### Cho mỗi Endpoint

```markdown
## GET /api/v1/users/:id

### Mô tả (Description)
Giải thích ngắn gọn về chức năng của endpoint này.

### Tham số (Parameters)

| Tên | Kiểu | Bắt buộc | Mô tả |
|------|------|----------|-------------|
| id | string | Có | ID của người dùng |

### Phản hồi (Response)

**200 Thành công (Success)**
```json
{
  "id": "usr_123",
  "name": "John Doe",
  "email": "john@example.com",
  "created_at": "2025-01-15T10:30:00Z"
}
```

**404 Không tìm thấy (Not Found)**
```json
{
  "error": "USER_NOT_FOUND",
  "message": "User does not exist"
}
```

### Ví dụ (Examples)

**cURL**
```bash
curl -X GET "https://api.example.com/api/v1/users/usr_123" \
  -H "Authorization: Bearer YOUR_TOKEN"
```

**JavaScript**
```javascript
const user = await fetch('/api/v1/users/usr_123', {
  headers: { 'Authorization': 'Bearer token' }
}).then(r => r.json());
```

**Python**
```python
response = requests.get(
    'https://api.example.com/api/v1/users/usr_123',
    headers={'Authorization': 'Bearer token'}
)
user = response.json()
```
