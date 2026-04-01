---
name: Thiết lập Pipeline CI/CD
description: Triển khai các pre-commit hooks và GitHub Actions để đảm bảo chất lượng
tags: ci-cd, devops, automation
---

# Thiết lập Pipeline CI/CD

Triển khai các cổng kiểm soát chất lượng DevOps toàn diện phù hợp với loại hình dự án:

1. **Phân tích dự án**: Phát hiện (các) ngôn ngữ, framework, hệ thống build và các công cụ hiện có
2. **Cấu hình các pre-commit hooks** với các công cụ đặc thù cho ngôn ngữ:
   - Định dạng (Formatting): Prettier/Black/gofmt/rustfmt/v.v.
   - Kiểm lỗi (Linting): ESLint/Ruff/golangci-lint/Clippy/v.v.
   - Bảo mật (Security): Bandit/gosec/cargo-audit/npm audit/v.v.
   - Kiểm tra kiểu dữ liệu (Type checking): TypeScript/mypy/flow (nếu áp dụng)
   - Kiểm thử (Tests): Chạy các bộ kiểm thử liên quan
3. **Tạo các workflow GitHub Actions** (.github/workflows/):
   - Phản chiếu các kiểm tra pre-commit khi push/PR
   - Ma trận đa phiên bản/nền tảng (nếu áp dụng)
   - Xác minh việc build và kiểm thử
   - Các bước triển khai (nếu cần)
4. **Xác minh pipeline**: Kiểm tra cục bộ, tạo PR thử nghiệm, xác nhận tất cả các kiểm tra đều vượt qua

Sử dụng các công cụ miễn phí/nguồn mở. Tôn trọng các cấu hình hiện có. Giữ cho việc thực thi nhanh chóng.
