# Sở thích phát triển của tôi (My Development Preferences)

## Về tôi
- **Kinh nghiệm**: 8 năm phát triển full-stack
- **Ngôn ngữ yêu thích**: TypeScript, Python
- **Phong cách giao tiếp**: Trực tiếp, kèm theo ví dụ
- **Phong cách học tập**: Sơ đồ trực quan kèm theo mã nguồn

## Sở thích về mã nguồn (Code Preferences)

### Xử lý lỗi (Error Handling)
Tôi thích xử lý lỗi một cách rõ ràng bằng các khối try-catch và các thông báo lỗi có nghĩa.
Tránh các lỗi chung chung. Luôn ghi nhật ký (log) lỗi để phục vụ việc gỡ lỗi.

### Chú thích (Comments)
Sử dụng chú thích để giải thích TẠI SAO (WHY), không phải CÁI GÌ (WHAT). Mã nguồn nên có khả năng tự giải thích (self-documenting).
Các chú thích nên giải thích logic nghiệp vụ hoặc các quyết định không hiển nhiên.

### Kiểm thử (Testing)
Tôi thích phương pháp TDD (phát triển dựa trên kiểm thử).
Viết kiểm thử trước, sau đó mới triển khai mã nguồn.
Tập trung vào hành vi (behavior), không phải chi tiết triển khai.

### Kiến trúc (Architecture)
Tôi thích thiết kế theo mô-đun (modular), ít phụ thuộc (loosely-coupled).
Sử dụng tiêm phụ thuộc (dependency injection) để dễ dàng kiểm thử.
Tách biệt các mối quan tâm (Controllers, Services, Repositories).

## Sở thích gỡ lỗi (Debugging Preferences)
- Sử dụng console.log với tiền tố: `[DEBUG]`
- Bao gồm ngữ cảnh: tên hàm, các biến liên quan
- Sử dụng stack traces khi có sẵn
- Luôn bao gồm dấu thời gian (timestamps) trong nhật ký

## Giao tiếp
- Giải thích các khái niệm phức tạp bằng sơ đồ
- Hiển thị các ví dụ cụ thể trước khi giải thích lý thuyết
- Bao gồm các đoạn mã trước/sau khi thay đổi
- Tóm tắt các điểm chính ở cuối

## Tổ chức Dự án
Tôi tổ chức các dự án của mình như sau:
```
project/
  ├── src/
  │   ├── api/
  │   ├── services/
  │   ├── models/
  │   └── utils/
  ├── tests/
  ├── docs/
  └── docker/
```

## Công cụ (Tooling)
- **IDE**: VS Code với phím tắt vim
- **Terminal**: Zsh với Oh-My-Zsh
- **Định dạng**: Prettier (Độ dài dòng 100 ký tự)
- **Linter**: ESLint với cấu hình airbnb
- **Framework kiểm thử**: Jest với React Testing Library
