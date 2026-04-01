#!/bin/bash
# Tự động định dạng mã trước khi ghi
# Hook: PreToolUse:Write

FILE=$1

if [ -z "$FILE" ]; then
  echo "Cách dùng: $0 <file_path>"
  exit 1
fi

# Phát hiện loại tệp và định dạng tương ứng
case "$FILE" in
  *.js|*.jsx|*.ts|*.tsx)
    if command -v prettier &> /dev/null; then
      echo "Đang định dạng tệp JavaScript/TypeScript: $FILE"
      prettier --write "$FILE"
    fi
    ;;
  *.py)
    if command -v black &> /dev/null; then
      echo "Đang định dạng tệp Python: $FILE"
      black "$FILE"
    fi
    ;;
  *.go)
    if command -v gofmt &> /dev/null; then
      echo "Đang định dạng tệp Go: $FILE"
      gofmt -w "$FILE"
    fi
    ;;
  *.rs)
    if command -v rustfmt &> /dev/null; then
      echo "Đang định dạng tệp Rust: $FILE"
      rustfmt "$FILE"
    fi
    ;;
  *.java)
    if command -v google-java-format &> /dev/null; then
      echo "Đang định dạng tệp Java: $FILE"
      google-java-format -i "$FILE"
    fi
    ;;
esac

exit 0
