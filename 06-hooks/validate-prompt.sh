#!/bin/bash
# Xác thực các prompt của người dùng
# Hook: UserPromptSubmit

# Đọc prompt từ stdin
PROMPT=$(cat)

echo "🔍 Đang xác thực prompt..."

# Kiểm tra các thao tác nguy hiểm
DANGEROUS_PATTERNS=(
  "rm -rf /"
  "delete database"
  "drop database"
  "format disk"
  "dd if="
)

for pattern in "${DANGEROUS_PATTERNS[@]}"; do
  if echo "$PROMPT" | grep -qi "$pattern"; then
    echo "❌ Bị chặn: Phát hiện thao tác nguy hiểm: $pattern"
    exit 1
  fi
done

# Kiểm tra việc triển khai lên production (production deployments)
if echo "$PROMPT" | grep -qiE "(deploy|push).*production"; then
  if [ ! -f ".deployment-approved" ]; then
    echo "❌ Bị chặn: Triển khai lên production yêu cầu sự phê duyệt"
    echo "Hãy tạo tệp .deployment-approved để tiếp tục"
    exit 1
  fi
fi

# Kiểm tra ngữ cảnh bắt buộc trong một số thao tác nhất định
if echo "$PROMPT" | grep -qi "refactor"; then
  if [ ! -f "tests/" ] && [ ! -f "test/" ]; then
    echo "⚠️  Cảnh báo: Việc tái cấu trúc (refactor) mà không có bài kiểm tra (tests) có thể gây rủi ro"
  fi
fi

echo "✅ Xác thực prompt thành công"
exit 0
