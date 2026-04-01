---
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git diff:*)
argument-hint: [thông điệp]
description: Tạo một git commit với ngữ cảnh
---

## Ngữ cảnh (Context)

- Trạng thái git hiện tại: !`git status`
- Diff git hiện tại: !`git diff HEAD`
- Nhánh hiện tại: !`git branch --show-current`
- Các commit gần đây: !`git log --oneline -10`

## Nhiệm vụ của bạn

Dựa trên các thay đổi ở trên, hãy tạo một git commit duy nhất.

Nếu một thông điệp được cung cấp qua các tham số, hãy sử dụng nó: $ARGUMENTS

Nếu không, hãy phân tích các thay đổi và tạo một thông điệp commit phù hợp tuân theo định dạng conventional commits:
- `feat:` cho các tính năng mới
- `fix:` cho các bản sửa lỗi
- `docs:` cho các thay đổi về tài liệu
- `refactor:` cho việc tái cấu trúc mã nguồn
- `test:` cho việc thêm các bài kiểm thử
- `chore:` cho các tác vụ bảo trì
