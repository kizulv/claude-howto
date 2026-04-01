#!/bin/bash
# Gửi thông báo khi có sự kiện xảy ra
# Hook: PostPush

REPO_NAME=$(basename $(git rev-parse --show-toplevel 2>/dev/null) 2>/dev/null)
COMMIT_MSG=$(git log -1 --pretty=%B 2>/dev/null)
AUTHOR=$(git log -1 --pretty=%an 2>/dev/null)
BRANCH=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

echo "📢 Đang gửi thông báo cho đội ngũ..."

# Ví dụ Slack webhook (thay thế bằng URL webhook của bạn)
SLACK_WEBHOOK="${SLACK_WEBHOOK_URL:-}"

if [ -n "$SLACK_WEBHOOK" ]; then
  curl -X POST "$SLACK_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"text\": \"Push mới lên *$REPO_NAME*\",
      \"attachments\": [{
        \"color\": \"good\",
        \"fields\": [
          {\"title\": \"Nhánh (Branch)\", \"value\": \"$BRANCH\", \"short\": true},
          {\"title\": \"Tác giả (Author)\", \"value\": \"$AUTHOR\", \"short\": true},
          {\"title\": \"Thông điệp (Commit)\", \"value\": \"$COMMIT_MSG\"}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Đã gửi thông báo Slack"
fi

# Ví dụ Discord webhook (thay thế bằng URL webhook của bạn)
DISCORD_WEBHOOK="${DISCORD_WEBHOOK_URL:-}"

if [ -n "$DISCORD_WEBHOOK" ]; then
  curl -X POST "$DISCORD_WEBHOOK" \
    -H 'Content-Type: application/json' \
    -d "{
      \"content\": \"**Push mới lên $REPO_NAME**\",
      \"embeds\": [{
        \"title\": \"$COMMIT_MSG\",
        \"color\": 3066993,
        \"fields\": [
          {\"name\": \"Nhánh (Branch)\", \"value\": \"$BRANCH\", \"inline\": true},
          {\"name\": \"Tác giả (Author)\", \"value\": \"$AUTHOR\", \"inline\": true}
        ]
      }]
    }" \
    --silent --output /dev/null

  echo "✅ Đã gửi thông báo Discord"
fi

# Ví dụ thông báo qua Email
EMAIL_TO="${TEAM_EMAIL:-}"

if [ -n "$EMAIL_TO" ]; then
  echo "Push mới lên $REPO_NAME bởi $AUTHOR" | \
    mail -s "Git Push: $BRANCH" "$EMAIL_TO"

  echo "✅ Đã gửi thông báo Email"
fi

exit 0
