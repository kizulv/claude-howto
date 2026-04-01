---
description: Dọn dẹp mã nguồn, stage các thay đổi và chuẩn bị một pull request
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git diff:*), Bash(npm test:*), Bash(npm run lint:*)
---

# Danh sách kiểm tra chuẩn bị Pull Request

Trước khi tạo một PR, hãy thực hiện các bước sau:

1. Chạy linting: `prettier --write .`
2. Chạy các bài kiểm thử: `npm test`
3. Rà soát git diff: `git diff HEAD`
4. Stage các thay đổi: `git add .`
5. Tạo thông điệp commit tuân theo conventional commits:
   - `fix:` cho các bản sửa lỗi
   - `feat:` cho các tính năng mới
   - `docs:` cho tài liệu
   - `refactor:` cho việc tái cấu trúc mã nguồn
   - `test:` cho việc thêm kiểm thử
   - `chore:` cho việc bảo trì

6. Tạo bản tóm tắt PR bao gồm:
   - Những gì đã thay đổi
   - Tại sao nó thay đổi
   - Các bài kiểm thử đã thực hiện
   - Các tác động tiềm tàng
