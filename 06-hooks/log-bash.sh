#!/bin/bash
# Ghi nhật ký tất cả các lệnh bash
# Hook: PostToolUse:Bash

COMMAND="$1"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="$HOME/.claude/bash-commands.log"

# Tạo thư mục nhật ký nếu nó chưa tồn tại
mkdir -p "$(dirname "$LOGFILE")"

# Ghi nhật ký lệnh
echo "[$TIMESTAMP] $COMMAND" >> "$LOGFILE"

# Tùy chọn: Ghi vào nhật ký hệ thống (system log)
# logger -t "claude-bash" "$COMMAND"

exit 0
