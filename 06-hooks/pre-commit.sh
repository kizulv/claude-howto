#!/bin/bash
# Chạy các bài kiểm tra (tests) trước khi commit
# Hook: PreToolUse (matcher: Bash) - kiểm tra xem lệnh có phải là git commit không
# Lưu ý: Không có sự kiện hook "PreCommit". Hãy sử dụng PreToolUse với một matcher Bash
# và kiểm tra lệnh để phát hiện các thao tác git commit.

echo "🧪 Đang chạy các bài kiểm tra trước khi commit..."

# Kiểm tra xem package.json có tồn tại không (dự án Node.js)
if [ -f "package.json" ]; then
  if grep -q "\"test\":" package.json; then
    npm test
    if [ $? -ne 0 ]; then
      echo "❌ Kiểm tra thất bại! Commit đã bị chặn."
      exit 1
    fi
  fi
fi

# Kiểm tra xem pytest có sẵn không (dự án Python)
if [ -f "pytest.ini" ] || [ -f "setup.py" ]; then
  if command -v pytest &> /dev/null; then
    pytest
    if [ $? -ne 0 ]; then
      echo "❌ Kiểm tra thất bại! Commit đã bị chặn."
      exit 1
    fi
  fi
fi

# Kiểm tra xem go.mod có tồn tại không (dự án Go)
if [ -f "go.mod" ]; then
  go test ./...
  if [ $? -ne 0 ]; then
    echo "❌ Kiểm tra thất bại! Commit đã bị chặn."
    exit 1
  fi
fi

# Kiểm tra xem Cargo.toml có tồn tại không (dự án Rust)
if [ -f "Cargo.toml" ]; then
  cargo test
  if [ $? -ne 0 ]; then
    echo "❌ Kiểm tra thất bại! Commit đã bị chặn."
    exit 1
  fi
fi

echo "✅ Tất cả các bài kiểm tra đã vượt qua! Đang tiến hành commit."
exit 0
