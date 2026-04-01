---
description: Stage tất cả thay đổi, tạo commit và push lên remote (sử dụng cẩn thận)
allowed-tools: Bash(git add:*), Bash(git status:*), Bash(git commit:*), Bash(git push:*), Bash(git diff:*), Bash(git log:*), Bash(git pull:*)
---

# Commit và Push tất cả mọi thứ

⚠️ **CẨN TRỌNG**: Stage TẤT CẢ các thay đổi, commit và push lên remote. Chỉ sử dụng khi bạn tự tin rằng tất cả các thay đổi đều thuộc về nhau.

## Quy trình công việc (Workflow)

### 1. Phân tích các thay đổi
Chạy song song:
- `git status` - Hiển thị các file đã sửa/thêm/xóa/chưa được theo dõi (untracked)
- `git diff --stat` - Hiển thị thống kê thay đổi
- `git log -1 --oneline` - Hiển thị commit gần đây để xem phong cách viết thông điệp

### 2. Kiểm tra an toàn

**❌ DỪNG LẠI và CẢNH BÁO nếu phát hiện:**
- Bí mật (Secrets): `.env*`, `*.key`, `*.pem`, `credentials.json`, `secrets.yaml`, `id_rsa`, `*.p12`, `*.pfx`, `*.cer`
- API Keys: Bất kỳ biến `*_API_KEY`, `*_SECRET`, `*_TOKEN` nào có giá trị thật (không phải placeholder như `your-api-key`, `xxx`, `placeholder`)
- File lớn: `>10MB` mà không dùng Git LFS
- Sản phẩm build: `node_modules/`, `dist/`, `build/`, `__pycache__/`, `*.pyc`, `.venv/`
- File tạm: `.DS_Store`, `thumbs.db`, `*.swp`, `*.tmp`

**Xác thực API Key:**
Kiểm tra các file đã sửa đổi để tìm các mẫu như:
```bash
OPENAI_API_KEY=sk-proj-xxxxx  # ❌ Phát hiện key thật!
AWS_SECRET_KEY=AKIA...         # ❌ Phát hiện key thật!
STRIPE_API_KEY=sk_live_...    # ❌ Phát hiện key thật!

# ✅ Các placeholder có thể chấp nhận:
API_KEY=your-api-key-here
SECRET_KEY=placeholder
TOKEN=xxx
API_KEY=<your-key>
SECRET=${YOUR_SECRET}
```

**✅ Xác minh:**
- `.gitignore` được cấu hình đúng
- Không có xung đột merge (merge conflicts)
- Đúng nhánh (cảnh báo nếu là main/master)
- Các API key chỉ là placeholder

### 3. Yêu cầu xác nhận

Trình bày bản tóm tắt:
```
📊 Tóm tắt thay đổi:
- X file đã sửa, Y file thêm mới, Z file đã xóa
- Tổng cộng: +AAA dòng thêm, -BBB dòng xóa

🔒 An toàn: ✅ Không có bí mật | ✅ Không có file lớn | ⚠️ [cảnh báo]
🌿 Nhánh: [tên-nhánh] → origin/[tên-nhánh]

Tôi sẽ thực hiện: git add . → commit → push

Nhập 'yes' để tiếp tục hoặc 'no' để hủy.
```

**CHỜ xác nhận "yes" rõ ràng trước khi tiếp tục.**

### 4. Thực thi (Sau khi xác nhận)

Chạy tuần tự:
```bash
git add .
git status  # Xác minh việc staging
```

### 5. Tạo thông điệp Commit

Phân tích các thay đổi và tạo conventional commit:

**Định dạng:**
```
[loại]: Tóm tắt ngắn gọn (tối đa 72 ký tự)

- Thay đổi chính 1
- Thay đổi chính 2
- Thay đổi chính 3
```

**Các loại (Types):** `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`, `build`, `ci`

**Ví dụ:**
```
docs: Cập nhật các file README khái niệm với tài liệu toàn diện

- Thêm sơ đồ kiến trúc và các bảng
- Bao gồm các ví dụ thực tế
- Mở rộng các phần thực hành tốt nhất
```

### 6. Commit và Push

```bash
git commit -m "$(cat <<'EOF'
[Thông điệp commit đã tạo]
EOF
)"
git push  # Nếu thất bại: git pull --rebase && git push
git log -1 --oneline --decorate  # Xác minh
```

### 7. Xác nhận thành công

```
✅ Đã push lên remote thành công!

Commit: [hash] [thông điệp]
Nhánh: [nhánh] → origin/[nhánh]
Số file thay đổi: X (+thêm, -xóa)
```

## Xử lý lỗi (Error Handling)

- **git add thất bại**: Kiểm tra quyền hạn, các file bị khóa, xác minh repo đã được khởi tạo
- **git commit thất bại**: Sửa các pre-commit hooks, kiểm tra cấu hình git (user.name/email)
- **git push thất bại**:
  - Non-fast-forward: `git pull --rebase && git push`
  - Không có nhánh remote: `git push -u origin [nhánh]`
  - Nhánh bị bảo vệ (protected branch): Sử dụng quy trình PR để thay thế

## Khi nào nên sử dụng

✅ **Nên dùng:**
- Cập nhật tài liệu trên nhiều file
- Tính năng đi kèm với kiểm thử và tài liệu
- Sửa lỗi trên nhiều file
- Định dạng/Tái cấu trúc trên toàn dự án
- Thay đổi cấu hình

❌ **Nên tránh:**
- Không chắc chắn về những gì đang được commit
- Chứa các bí mật/dữ liệu nhạy cảm
- Các nhánh bị bảo vệ mà không có sự rà soát (review)
- Có xung đột merge
- Muốn lịch sử commit chi tiết, rời rạc
- Các pre-commit hooks bị lỗi

## Các lựa chọn thay thế

Nếu người dùng muốn kiểm soát nhiều hơn, hãy đề xuất:
1. **Staging có chọn lọc**: Rà soát/stage các file cụ thể
2. **Staging tương tác**: `git add -p` để chọn từng phần (patch)
3. **Quy trình PR**: Tạo nhánh → push → PR (sử dụng lệnh `/pr`)

**⚠️ Ghi nhớ**: Luôn rà soát các thay đổi trước khi push. Khi còn nghi ngờ, hãy sử dụng các lệnh git riêng lẻ để kiểm soát tốt hơn.
