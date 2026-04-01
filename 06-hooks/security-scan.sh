#!/bin/bash
# Quét bảo mật khi ghi tệp (file write)
# Hook: PostToolUse:Write

FILE=$1

if [ -z "$FILE" ]; then
  echo "Cách dùng: $0 <file_path>"
  exit 0
fi

echo "🔒 Đang chạy quét bảo mật trên: $FILE"

ISSUES_FOUND=0

# Kiểm tra các mật khẩu ghi cứng (hardcoded passwords)
if grep -qE "(password|passwd|pwd)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  CẢNH BÁO: Phát hiện mật khẩu có khả năng được ghi cứng trong $FILE"
  ISSUES_FOUND=1
fi

# Kiểm tra các API key ghi cứng
if grep -qE "(api[_-]?key|apikey|access[_-]?token)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  CẢNH BÁO: Phát hiện API key có khả năng được ghi cứng trong $FILE"
  ISSUES_FOUND=1
fi

# Kiểm tra các bí mật ghi cứng (hardcoded secrets)
if grep -qE "(secret|token)\s*=\s*['\"][^'\"]+['\"]" "$FILE"; then
  echo "⚠️  CẢNH BÁO: Phát hiện bí mật có khả năng được ghi cứng trong $FILE"
  ISSUES_FOUND=1
fi

# Kiểm tra các khóa riêng tư (private keys)
if grep -q "BEGIN.*PRIVATE KEY" "$FILE"; then
  echo "⚠️  CẢNH BÁO: Phát hiện khóa riêng tư (private key) trong $FILE"
  ISSUES_FOUND=1
fi

# Kiểm tra các khóa AWS (AWS keys)
if grep -qE "AKIA[0-9A-Z]{16}" "$FILE"; then
  echo "⚠️  CẢNH BÁO: Phát hiện AWS access key trong $FILE"
  ISSUES_FOUND=1
fi

# Quét bằng semgrep nếu có sẵn
if command -v semgrep &> /dev/null; then
  semgrep --config=auto "$FILE" --quiet 2>/dev/null
fi

# Quét bằng trufflehog nếu có sẵn
if command -v trufflehog &> /dev/null; then
  trufflehog filesystem "$FILE" --only-verified --quiet 2>/dev/null
fi

if [ $ISSUES_FOUND -eq 0 ]; then
  echo "✅ Không tìm thấy vấn đề bảo mật nào"
fi

# Không chặn thao tác, chỉ cảnh báo
exit 0
