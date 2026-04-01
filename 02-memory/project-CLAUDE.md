# Cấu hình Dự án (Project Configuration)

## Tổng quan Dự án (Project Overview)
- **Tên**: Nền tảng Thương mại điện tử (E-commerce Platform)
- **Công nghệ**: Node.js, PostgreSQL, React 18, Docker
- **Quy mô đội ngũ**: 5 lập trình viên
- **Thời hạn**: Quý 4 năm 2025

## Kiến trúc (Architecture)
@docs/architecture.md
@docs/api-standards.md
@docs/database-schema.md

## Tiêu chuẩn Phát triển (Development Standards)

### Phong cách lập trình (Code Style)
- Sử dụng Prettier để định dạng
- Sử dụng ESLint với cấu hình airbnb
- Độ dài dòng tối đa: 100 ký tự
- Sử dụng thụt lề 2 khoảng trắng

### Quy ước đặt tên (Naming Conventions)
- **Tệp (Files)**: kebab-case (user-controller.js)
- **Lớp (Classes)**: PascalCase (UserService)
- **Hàm/Biến (Functions/Variables)**: camelCase (getUserById)
- **Hằng số (Constants)**: UPPER_SNAKE_CASE (API_BASE_URL)
- **Bảng cơ sở dữ liệu (Database Tables)**: snake_case (user_accounts)

### Quy trình Git (Git Workflow)
- Tên nhánh: `feature/description` hoặc `fix/description`
- Thông điệp commit: Tuân theo conventional commits
- Yêu cầu PR trước khi merge
- Tất cả các kiểm tra CI/CD phải vượt qua
- Yêu cầu tối thiểu 1 phê duyệt

### Yêu cầu kiểm thử (Testing Requirements)
- Độ bao phủ code tối thiểu 80%
- Tất cả các đường dẫn quan trọng phải có bài kiểm thử
- Sử dụng Jest cho unit tests
- Sử dụng Cypress cho E2E tests
- Tên tệp kiểm thử: `*.test.ts` hoặc `*.spec.ts`

### Tiêu chuẩn API (API Standards)
- Chỉ sử dụng các endpoint RESTful
- Yêu cầu/Phản hồi dạng JSON
- Sử dụng mã trạng thái HTTP đúng cách
- Gán phiên bản cho API endpoint: `/api/v1/`
- Tài liệu hóa tất cả các endpoint kèm theo ví dụ

### Cơ sở dữ liệu (Database)
- Sử dụng migration cho các thay đổi schema
- Không bao giờ để lộ thông tin xác thực (credentials)
- Sử dụng kết nối theo cụm (connection pooling)
- Bật nhật ký truy vấn (query logging) trong môi trường phát triển
- Yêu cầu sao lưu định kỳ

### Triển khai (Deployment)
- Triển khai dựa trên Docker
- Điều phối bằng Kubernetes
- Chiến lược triển khai Blue-green
- Tự động hoàn tác (rollback) khi thất bại
- Chạy migrations cơ sở dữ liệu trước khi triển khai

## Các lệnh thông dụng (Common Commands)

| Lệnh | Mục đích |
|---------|---------|
| `npm run dev` | Bắt đầu server phát triển |
| `npm test` | Chạy bộ kiểm thử |
| `npm run lint` | Kiểm tra phong cách lập trình |
| `npm run build` | Build cho production |
| `npm run migrate` | Chạy các bản di chuyển cơ sở dữ liệu |

## Liên hệ đội ngũ (Team Contacts)
- Trưởng nhóm kỹ thuật (Tech Lead): Sarah Chen (@sarah.chen)
- Quản lý sản phẩm (Product Manager): Mike Johnson (@mike.j)
- DevOps: Alex Kim (@alex.k)

## Các vấn đề đã biết & Cách khắc phục (Known Issues & Workarounds)
- Kết nối PostgreSQL bị giới hạn ở mức 20 trong giờ cao điểm
- Cách khắc phục: Triển khai hàng đợi truy vấn (query queuing)
- Vấn đề tương thích Safari 14 với async generators
- Cách khắc phục: Sử dụng trình chuyển đổi Babel

## Các dự án liên quan (Related Projects)
- Dashboard Phân tích: `/projects/analytics`
- Ứng dụng Di động: `/projects/mobile`
- Bảng Quản trị: `/projects/admin`
