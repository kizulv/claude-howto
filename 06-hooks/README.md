<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# Hooks

Hooks là các đoạn mã tự động (scripts) được thực thi để phản hồi lại các sự kiện cụ thể trong các phiên làm việc với Claude Code. Chúng cho phép tự động hóa, xác thực, quản lý quyền và tạo các quy trình làm việc tùy chỉnh.

## Tổng quan

Hooks là các hành động tự động (lệnh shell, HTTP webhooks, prompt LLM hoặc đánh giá của subagent) tự động thực thi khi các sự kiện cụ thể xảy ra trong Claude Code. Chúng nhận đầu vào JSON và truyền đạt kết quả thông qua mã thoát (exit codes) và đầu ra JSON.

**Các tính năng chính:**
- Tự động hóa dựa trên sự kiện (Event-driven)
- Đầu vào/đầu ra dựa trên JSON
- Hỗ trợ các loại hook: lệnh (command), prompt, HTTP và agent
- So khớp mẫu (Pattern matching) cho các hook dành riêng cho công cụ

## Cấu hình

Hooks được cấu hình trong các tệp cài đặt với cấu trúc cụ thể:

- `~/.claude/settings.json` - Cài đặt người dùng (tất cả dự án)
- `.claude/settings.json` - Cài đặt dự án (có thể chia sẻ, được commit)
- `.claude/settings.local.json` - Cài đặt dự án cục bộ (không commit)
- Managed policy - Cài đặt toàn tổ chức
- Plugin `hooks/hooks.json` - Hooks theo phạm vi plugin
- Skill/Agent frontmatter - Hooks theo vòng đời thành phần

### Cấu trúc Cấu hình Cơ bản

```json
{
  "hooks": {
    "EventName": [
      {
        "matcher": "ToolPattern",
        "hooks": [
          {
            "type": "command",
            "command": "your-command-here",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

**Các trường chính:**

| Trường | Mô tả | Ví dụ |
|-------|-------------|---------|
| `matcher` | Mẫu để khớp với tên công cụ (phân biệt hoa thường) | `"Write"`, `"Edit\|Write"`, `"*"` |
| `hooks` | Mảng các định nghĩa hook | `[{ "type": "command", ... }]` |
| `type` | Loại hook: `"command"` (bash), `"prompt"` (LLM), `"http"` (webhook), hoặc `"agent"` (subagent) | `"command"` |
| `command` | Lệnh shell để thực thi | `"$CLAUDE_PROJECT_DIR/.claude/hooks/format.sh"` |
| `timeout` | Thời gian chờ tùy chọn tính bằng giây (mặc định 60) | `30` |
| `once` | Nếu `true`, chỉ chạy hook một lần mỗi phiên | `true` |

### Các mẫu Matcher (Matcher Patterns)

| Mẫu | Mô tả | Ví dụ |
|---------|-------------|---------|
| Chuỗi chính xác | Khớp với công cụ cụ thể | `"Write"` |
| Mẫu Regex | Khớp với nhiều công cụ | `"Edit\|Write"` |
| Ký tự đại diện | Khớp với tất cả các công cụ | `"*"` hoặc `""` |
| Các công cụ MCP | Mẫu server và công cụ | `"mcp__memory__.*"` |

## Các loại Hook

Claude Code hỗ trợ bốn loại hook:

### Command Hooks (Hook lệnh)

Loại hook mặc định. Thực thi một lệnh shell và giao tiếp qua JSON stdin/stdout và mã thoát.

```json
{
  "type": "command",
  "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate.py\"",
  "timeout": 60
}
```

### HTTP Hooks

> Được thêm vào từ v2.1.63.

Các endpoint webhook từ xa nhận cùng đầu vào JSON như các hook lệnh. HTTP hooks gửi (POST) dữ liệu JSON đến URL và nhận lại phản hồi JSON. HTTP hooks được định tuyến qua sandbox khi chế độ sandboxing được bật. Việc nội suy biến môi trường trong URL yêu cầu một danh sách `allowedEnvVars` rõ ràng để đảm bảo bảo mật.

```json
{
  "hooks": {
    "PostToolUse": [{
      "type": "http",
      "url": "https://my-webhook.example.com/hook",
      "matcher": "Write"
    }]
  }
}
```

**Các thuộc tính chính:**
- `"type": "http"` -- xác định đây là một HTTP hook
- `"url"` -- URL của endpoint webhook
- Được định tuyến qua sandbox khi sandbox được bật
- Yêu cầu danh sách `allowedEnvVars` rõ ràng cho bất kỳ sự nội suy biến môi trường nào trong URL

### Prompt Hooks

Các prompt được LLM đánh giá, trong đó nội dung hook là một yêu cầu mà Claude sẽ đánh giá. Chủ yếu được sử dụng với các sự kiện `Stop` và `SubagentStop` để kiểm tra việc hoàn thành nhiệm vụ một cách thông minh.

```json
{
  "type": "prompt",
  "prompt": "Evaluate if Claude completed all requested tasks.",
  "timeout": 30
}
```

LLM sẽ đánh giá prompt và trả về một quyết định có cấu trúc (xem [Hooks dựa trên Prompt](#prompt-based-hooks) để biết chi tiết).

### Agent Hooks

Các hook xác thực dựa trên subagent, khởi tạo một agent riêng biệt để đánh giá các điều kiện hoặc thực hiện các kiểm tra phức tạp. Không giống như prompt hooks (đánh giá LLM một lượt), agent hooks có thể sử dụng các công cụ và thực hiện suy luận đa bước.

```json
{
  "type": "agent",
  "prompt": "Verify the code changes follow our architecture guidelines. Check the relevant design docs and compare.",
  "timeout": 120
}
```

**Các thuộc tính chính:**
- `"type": "agent"` -- xác định đây là một agent hook
- `"prompt"` -- mô tả nhiệm vụ cho subagent
- Agent có thể sử dụng các công cụ (Read, Grep, Bash, v.v.) để thực hiện đánh giá
- Trả về một quyết định có cấu trúc tương tự như prompt hooks

## Các sự kiện Hook (Hook Events)

Claude Code hỗ trợ **25 sự kiện hook**:

| Sự kiện | Khi nào được kích hoạt | Đầu vào Matcher | Có thể chặn? | Cách dùng thông dụng |
|-------|---------------|---------------|-----------|------------|
| **SessionStart** | Phiên bắt đầu/tiếp tục/xóa/nén | startup/resume/clear/compact | Không | Thiết lập môi trường |
| **InstructionsLoaded** | Sau khi tải file CLAUDE.md hoặc file quy tắc | (không có) | Không | Sửa đổi/lọc chỉ dẫn |
| **UserPromptSubmit** | Người dùng gửi prompt | (không có) | Có | Xác thực prompt |
| **PreToolUse** | Trước khi thực thi công cụ | Tên công cụ | Có (allow/deny/ask) | Xác thực, sửa đầu vào |
| **PermissionRequest** | Khi hộp thoại xin quyền hiển thị | Tên công cụ | Có | Tự động phê duyệt/từ chối |
| **PostToolUse** | Sau khi công cụ thành công | Tên công cụ | Không | Thêm ngữ cảnh, phản hồi |
| **PostToolUseFailure** | Khi thực thi công cụ thất bại | Tên công cụ | Không | Xử lý lỗi, ghi nhật ký |
| **Notification** | Khi thông báo được gửi | Loại thông báo | Không | Thông báo tùy chỉnh |
| **SubagentStart** | Khi một subagent được tạo | Tên loại agent | Không | Thiết lập subagent |
| **SubagentStop** | Khi subagent kết thúc | Tên loại agent | Có | Xác thực subagent |
| **Stop** | Khi Claude kết thúc phản hồi | (không có) | Có | Kiểm tra hoàn thành nhiệm vụ |
| **StopFailure** | Lỗi API kết thúc lượt | (không có) | Không | Khôi phục lỗi, ghi nhật ký |
| **TeammateIdle** | Đồng đội trong nhóm agent rảnh rỗi | (không có) | Có | Điều phối đồng đội |
| **TaskCompleted** | Nhiệm vụ được đánh dấu hoàn thành | (không có) | Có | Các hành động sau nhiệm vụ |
| **TaskCreated** | Nhiệm vụ được tạo qua TaskCreate | (không có) | Không | Theo dõi, ghi nhật ký nhiệm vụ |
| **ConfigChange** | File cấu hình thay đổi | (không có) | Có (trừ policy) | Phản ứng với cập nhật cấu hình |
| **CwdChanged** | Thư mục làm việc thay đổi | (không có) | Không | Thiết lập riêng cho thư mục |
| **FileChanged** | File đang theo dõi thay đổi | (không có) | Không | Giám sát file, build lại |
| **PreCompact** | Trước khi nén ngữ cảnh | manual/auto | Không | Các hành động trước khi nén |
| **PostCompact** | Sau khi hoàn tất nén ngữ cảnh | (không có) | Không | Các hành động sau khi nén |
| **WorktreeCreate** | Worktree đang được tạo | (không có) | Có (trả về đường dẫn) | Khởi tạo worktree |
| **WorktreeRemove** | Worktree đang bị xóa | (không có) | Không | Dọn dẹp worktree |
| **Elicitation** | Server MCP yêu cầu người dùng nhập liệu | (không có) | Có | Xác thực đầu vào |
| **ElicitationResult** | Người dùng phản hồi yêu cầu nhập liệu | (không có) | Có | Xử lý phản hồi |
| **SessionEnd** | Phiên kết thúc | (không có) | Không | Dọn dẹp, ghi nhật ký cuối cùng |

### PreToolUse

Chạy sau khi Claude tạo các tham số công cụ và trước khi xử lý. Sử dụng sự kiện này để xác thực hoặc sửa đổi đầu vào của công cụ.

**Cấu hình:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py"
          }
        ]
      }
    ]
  }
}
```

**Các matcher phổ biến:** `Task`, `Bash`, `Glob`, `Grep`, `Read`, `Edit`, `Write`, `WebFetch`, `WebSearch`

**Kiểm soát đầu ra:**
- `permissionDecision`: `"allow"`, `"deny"`, hoặc `"ask"`
- `permissionDecisionReason`: Giải thích cho quyết định
- `updatedInput`: Các tham số đầu vào công cụ đã được sửa đổi

### PostToolUse

Chạy ngay sau khi công cụ hoàn thành. Sử dụng để xác minh, ghi nhật ký hoặc cung cấp ngữ cảnh ngược lại cho Claude.

**Cấu hình:**
```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py"
          }
        ]
      }
    ]
  }
}
```

**Kiểm soát đầu ra:**
- Quyết định `"block"` sẽ yêu cầu Claude với thông tin phản hồi
- `additionalContext`: Ngữ cảnh được thêm vào cho Claude

### UserPromptSubmit

Chạy khi người dùng gửi một prompt, trước khi Claude xử lý nó.

**Cấu hình:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py"
          }
        ]
      }
    ]
  }
}
```

**Kiểm soát đầu ra:**
- `decision`: `"block"` để ngăn chặn việc xử lý
- `reason`: Giải thích nếu bị chặn
- `additionalContext`: Ngữ cảnh được thêm vào prompt

### Stop và SubagentStop

Chạy khi Claude kết thúc phản hồi (Stop) hoặc một subagent hoàn thành (SubagentStop). Hỗ trợ đánh giá dựa trên prompt để kiểm tra việc hoàn thành nhiệm vụ một cách thông minh.

**Trường đầu vào bổ sung:** Cả hook `Stop` và `SubagentStop` đều nhận một trường `last_assistant_message` trong đầu vào JSON, chứa tin nhắn cuối cùng từ Claude hoặc subagent trước khi dừng. Điều này hữu ích cho việc đánh giá mức độ hoàn thành nhiệm vụ.

**Cấu hình:**
```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Evaluate if Claude completed all requested tasks.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### SubagentStart

Chạy khi một subagent bắt đầu thực thi. Đầu vào matcher là tên loại agent, cho phép các hook nhắm mục tiêu vào các loại subagent cụ thể.

**Cấu hình:**
```json
{
  "hooks": {
    "SubagentStart": [
      {
        "matcher": "code-review",
        "hooks": [
          {
            "type": "command",
            "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/subagent-init.sh"
          }
        ]
      }
    ]
  }
}
```

### SessionStart

Chạy khi phiên bắt đầu hoặc tiếp tục. Có thể duy trì các biến môi trường.

**Matchers:** `startup`, `resume`, `clear`, `compact`

**Tính năng đặc biệt:** Sử dụng `CLAUDE_ENV_FILE` để duy trì các biến môi trường (cũng có sẵn trong các hook `CwdChanged` và `FileChanged`):

```bash
#!/bin/bash
if [ -n "$CLAUDE_ENV_FILE" ]; then
  echo 'export NODE_ENV=development' >> "$CLAUDE_ENV_FILE"
fi
exit 0
```

### SessionEnd

Chạy khi phiên kết thúc để thực hiện dọn dẹp hoặc ghi nhật ký cuối cùng. Không thể chặn việc kết thúc.

**Các giá trị của trường Reason:**
- `clear` - Người dùng đã xóa phiên
- `logout` - Người dùng đã đăng xuất
- `prompt_input_exit` - Người dùng thoát qua đầu vào prompt
- `other` - Lý do khác

**Cấu hình:**
```json
{
  "hooks": {
    "SessionEnd": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-cleanup.sh\""
          }
        ]
      }
    ]
  }
}
```

### Sự kiện Notification (Thông báo)

Các matcher đã cập nhật cho các sự kiện thông báo:
- `permission_prompt` - Thông báo yêu cầu cấp quyền
- `idle_prompt` - Thông báo trạng thái rảnh rỗi
- `auth_success` - Xác thực thành công
- `elicitation_dialog` - Hộp thoại hiển thị cho người dùng

## Hooks theo phạm vi thành phần (Component-Scoped Hooks)

Hooks có thể được đính kèm vào các thành phần cụ thể (skills, agents, commands) trong phần frontmatter của chúng:

**Trong SKILL.md, agent.md, hoặc command.md:**

```yaml
---
name: secure-operations
description: Perform operations with security checks
hooks:
  PreToolUse:
    - matcher: "Bash"
      hooks:
        - type: command
          command: "./scripts/check.sh"
          once: true  # Only run once per session
---
```

**Các sự kiện được hỗ trợ cho component hooks:** `PreToolUse`, `PostToolUse`, `Stop`

Điều này cho phép định nghĩa các hook ngay trong thành phần sử dụng chúng, giữ cho mã liên quan ở gần nhau.

### Hooks trong Subagent Frontmatter

Khi một hook `Stop` được định nghĩa trong frontmatter của subagent, nó sẽ tự động được chuyển đổi thành hook `SubagentStop` có phạm vi dành riêng cho subagent đó. Điều này đảm bảo rằng hook dừng chỉ được kích hoạt khi subagent cụ thể đó hoàn thành, thay vì kích hoạt khi phiên chính dừng.

```yaml
---
name: code-review-agent
description: Automated code review subagent
hooks:
  Stop:
    - hooks:
        - type: prompt
          prompt: "Verify the code review is thorough and complete."
  # Hook Stop ở trên sẽ tự động chuyển đổi thành SubagentStop cho subagent này
---
```

## Sự kiện PermissionRequest

Xử lý các yêu cầu cấp quyền với định dạng đầu ra tùy chỉnh:

```json
{
  "hookSpecificOutput": {
    "hookEventName": "PermissionRequest",
    "decision": {
      "behavior": "allow|deny",
      "updatedInput": {},
      "message": "Custom message",
      "interrupt": false
    }
  }
}
```

## Đầu vào và Đầu ra của Hook

### Đầu vào JSON (qua stdin)

Tất cả các hook đều nhận đầu vào JSON qua stdin:

```json
{
  "session_id": "abc123",
  "transcript_path": "/path/to/transcript.jsonl",
  "cwd": "/current/working/directory",
  "permission_mode": "default",
  "hook_event_name": "PreToolUse",
  "tool_name": "Write",
  "tool_input": {
    "file_path": "/path/to/file.js",
    "content": "..."
  },
  "tool_use_id": "toolu_01ABC123...",
  "agent_id": "agent-abc123",
  "agent_type": "main",
  "worktree": "/path/to/worktree"
}
```

**Các trường phổ biến:**

| Trường | Mô tả |
|-------|-------------|
| `session_id` | Mã định danh duy nhất của phiên |
| `transcript_path` | Đường dẫn đến tệp bản ghi (transcript) của cuộc hội thoại |
| `cwd` | Thư mục làm việc hiện tại |
| `hook_event_name` | Tên của sự kiện đã kích hoạt hook |
| `agent_id` | Mã định danh của agent đang chạy hook này |
| `agent_type` | Loại agent (`"main"`, tên loại subagent, v.v.) |
| `worktree` | Đường dẫn đến git worktree, nếu agent đang chạy trong đó |

### Mã thoát (Exit Codes)

| Mã thoát | Ý nghĩa | Hành vi |
|-----------|---------|----------|
| **0** | Thành công | Tiếp tục, phân tích JSON từ stdout |
| **2** | Lỗi chặn (Blocking error) | Chặn thao tác, stderr được hiển thị dưới dạng lỗi |
| **Khác** | Lỗi không chặn | Tiếp tục, stderr được hiển thị trong chế độ verbose |

### Đầu ra JSON (stdout, mã thoát 0)

```json
{
  "continue": true,
  "stopReason": "Optional message if stopping",
  "suppressOutput": false,
  "systemMessage": "Optional warning message",
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "allow",
    "permissionDecisionReason": "File is in allowed directory",
    "updatedInput": {
      "file_path": "/modified/path.js"
    }
  }
}
```

## Biến môi trường

| Biến | Khả dụng | Mô tả |
|----------|-------------|-------------|
| `CLAUDE_PROJECT_DIR` | Tất cả các hook | Đường dẫn tuyệt đối đến thư mục gốc của dự án |
| `CLAUDE_ENV_FILE` | SessionStart, CwdChanged, FileChanged | Đường dẫn tệp để duy trì các biến môi trường |
| `CLAUDE_CODE_REMOTE` | Tất cả các hook | `"true"` nếu đang chạy trong môi trường từ xa |
| `${CLAUDE_PLUGIN_ROOT}` | Các hook của Plugin | Đường dẫn đến thư mục plugin |
| `${CLAUDE_PLUGIN_DATA}` | Các hook của Plugin | Đường dẫn đến thư mục dữ liệu của plugin |
| `CLAUDE_CODE_SESSIONEND_HOOKS_TIMEOUT_MS` | Các hook SessionEnd | Thời gian chờ có thể cấu hình (ms) cho các hook SessionEnd (ghi đè mặc định) |

## Hooks dựa trên Prompt

Đối với các sự kiện `Stop` và `SubagentStop`, bạn có thể sử dụng đánh giá dựa trên LLM:

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review if all tasks are complete. Return your decision.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

**Schema Phản hồi của LLM:**
```json
{
  "decision": "approve",
  "reason": "All tasks completed successfully",
  "continue": false,
  "stopReason": "Task complete"
}
```

## Các ví dụ

### Ví dụ 1: Trình xác thực lệnh Bash (PreToolUse)

**Tệp:** `.claude/hooks/validate-bash.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"\brm\s+-rf\s+/", "Chặn lệnh rm -rf / nguy hiểm"),
    (r"\bsudo\s+rm", "Chặn lệnh sudo rm"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name != "Bash":
        sys.exit(0)

    command = input_data.get("tool_input", {}).get("command", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, command):
            print(message, file=sys.stderr)
            sys.exit(2)  # Mã thoát 2 = lỗi chặn

    sys.exit(0)

if __name__ == "__main__":
    main()
```

**Cấu hình:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\""
          }
        ]
      }
    ]
  }
}
```

### Ví dụ 2: Trình quét bảo mật (PostToolUse)

**Tệp:** `.claude/hooks/security-scan.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

SECRET_PATTERNS = [
    (r"password\s*=\s*['\"][^'\"]+['\"]", "Có khả năng ghi cứng mật khẩu"),
    (r"api[_-]?key\s*=\s*['\"][^'\"]+['\"]", "Có khả năng ghi cứng API key"),
]

def main():
    input_data = json.load(sys.stdin)

    tool_name = input_data.get("tool_name", "")
    if tool_name not in ["Write", "Edit"]:
        sys.exit(0)

    tool_input = input_data.get("tool_input", {})
    content = tool_input.get("content", "") or tool_input.get("new_string", "")
    file_path = tool_input.get("file_path", "")

    warnings = []
    for pattern, message in SECRET_PATTERNS:
        if re.search(pattern, content, re.IGNORECASE):
            warnings.append(message)

    if warnings:
        output = {
            "hookSpecificOutput": {
                "hookEventName": "PostToolUse",
                "additionalContext": f"Cảnh báo bảo mật cho {file_path}: " + "; ".join(warnings)
            }
        }
        print(json.dumps(output))

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Ví dụ 3: Tự động định dạng mã (PostToolUse)

**Tệp:** `.claude/hooks/format-code.sh`

```bash
#!/bin/bash

# Đọc JSON từ stdin
INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_name', ''))")
FILE_PATH=$(echo "$INPUT" | python3 -c "import sys, json; print(json.load(sys.stdin).get('tool_input', {}).get('file_path', ''))")

if [ "$TOOL_NAME" != "Write" ] && [ "$TOOL_NAME" != "Edit" ]; then
    exit 0
fi

# Định dạng dựa trên phần mở rộng của tệp
case "$FILE_PATH" in
    *.js|*.jsx|*.ts|*.tsx|*.json)
        command -v prettier &>/dev/null && prettier --write "$FILE_PATH" 2>/dev/null
        ;;
    *.py)
        command -v black &>/dev/null && black "$FILE_PATH" 2>/dev/null
        ;;
    *.go)
        command -v gofmt &>/dev/null && gofmt -w "$FILE_PATH" 2>/dev/null
        ;;
esac

exit 0
```

### Ví dụ 4: Trình xác thực Prompt (UserPromptSubmit)

**Tệp:** `.claude/hooks/validate-prompt.py`

```python
#!/usr/bin/env python3
import json
import sys
import re

BLOCKED_PATTERNS = [
    (r"delete\s+(all\s+)?database", "Nguy hiểm: xóa cơ sở dữ liệu"),
    (r"rm\s+-rf\s+/", "Nguy hiểm: xóa thư mục gốc"),
]

def main():
    input_data = json.load(sys.stdin)
    prompt = input_data.get("user_prompt", "") or input_data.get("prompt", "")

    for pattern, message in BLOCKED_PATTERNS:
        if re.search(pattern, prompt, re.IGNORECASE):
            output = {
                "decision": "block",
                "reason": f"Bị chặn: {message}"
            }
            print(json.dumps(output))
            sys.exit(0)

    sys.exit(0)

if __name__ == "__main__":
    main()
```

### Ví dụ 5: Hook dừng thông minh (Dựa trên Prompt)

```json
{
  "hooks": {
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Review if Claude completed all requested tasks. Check: 1) Were all files created/modified? 2) Were there unresolved errors? If incomplete, explain what's missing.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

### Ví dụ 6: Trình theo dõi sử dụng ngữ cảnh (Cặp Hook)

Theo dõi lượng tiêu thụ token cho mỗi yêu cầu bằng cách sử dụng kết hợp hook `UserPromptSubmit` (trước tin nhắn) và `Stop` (sau phản hồi).

**Tệp:** `.claude/hooks/context-tracker.py`

```python
#!/usr/bin/env python3
"""
Trình theo dõi sử dụng ngữ cảnh - Theo dõi lượng tiêu thụ token theo từng yêu cầu.

Sử dụng UserPromptSubmit làm hook "pre-message" và Stop làm hook "post-response"
để tính toán sự thay đổi (delta) trong việc sử dụng token cho mỗi yêu cầu.

Các phương pháp đếm Token:
1. Ước tính theo ký tự (mặc định): ~4 ký tự mỗi token, không phụ thuộc thư viện
2. tiktoken (tùy chọn): Chính xác hơn (~90-95%), yêu cầu: pip install tiktoken
"""
import json
import os
import sys
import tempfile

# Cấu hình
CONTEXT_LIMIT = 128000  # Cửa sổ ngữ cảnh của Claude (điều chỉnh cho mô hình của bạn)
USE_TIKTOKEN = False    # Đặt thành True nếu tiktoken đã được cài đặt để có độ chính xác tốt hơn


def get_state_file(session_id: str) -> str:
    """Lấy đường dẫn tệp tạm để lưu trữ số lượng token trước tin nhắn, tách biệt theo phiên."""
    return os.path.join(tempfile.gettempdir(), f"claude-context-{session_id}.json")


def count_tokens(text: str) -> int:
    """
    Đếm số token trong văn bản.

    Sử dụng tiktoken với bảng mã p50k_base nếu có sẵn (~90-95% chính xác),
    nếu không sẽ quay lại ước tính theo ký tự (~80-90% chính xác).
    """
    if USE_TIKTOKEN:
        try:
            import tiktoken
            enc = tiktoken.get_encoding("p50k_base")
            return len(enc.encode(text))
        except ImportError:
            pass  # Quay lại ước tính

    # Ước tính dựa trên ký tự: ~4 ký tự mỗi token cho tiếng Anh
    return len(text) // 4


def read_transcript(transcript_path: str) -> str:
    """Đọc và nối tất cả nội dung từ tệp bản ghi (transcript)."""
    if not transcript_path or not os.path.exists(transcript_path):
        return ""

    content = []
    with open(transcript_path, "r") as f:
        for line in f:
            try:
                entry = json.loads(line.strip())
                # Trích xuất nội dung văn bản từ các định dạng tin nhắn khác nhau
                if "message" in entry:
                    msg = entry["message"]
                    if isinstance(msg.get("content"), str):
                        content.append(msg["content"])
                    elif isinstance(msg.get("content"), list):
                        for block in msg["content"]:
                            if isinstance(block, dict) and block.get("type") == "text":
                                content.append(block.get("text", ""))
            except json.JSONDecodeError:
                continue

    return "\n".join(content)


def handle_user_prompt_submit(data: dict) -> None:
    """Hook trước tin nhắn: Lưu số lượng token hiện tại trước khi thực hiện yêu cầu."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # Lưu vào tệp tạm để so sánh sau
    state_file = get_state_file(session_id)
    with open(state_file, "w") as f:
        json.dump({"pre_tokens": current_tokens}, f)


def handle_stop(data: dict) -> None:
    """Hook sau phản hồi: Tính toán và báo cáo sự thay đổi token."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens(transcript_content)

    # Tải lại số lượng token trước tin nhắn
    state_file = get_state_file(session_id)
    pre_tokens = 0
    if os.path.exists(state_file):
        try:
            with open(state_file, "r") as f:
                state = json.load(f)
                pre_tokens = state.get("pre_tokens", 0)
        except (json.JSONDecodeError, IOError):
            pass

    # Tính toán delta
    delta_tokens = current_tokens - pre_tokens
    remaining = CONTEXT_LIMIT - current_tokens
    percentage = (current_tokens / CONTEXT_LIMIT) * 100

    # Báo cáo việc sử dụng
    method = "tiktoken" if USE_TIKTOKEN else "ước tính"
    print(f"Ngữ cảnh ({method}): ~{current_tokens:,} token ({percentage:.1f}% đã dùng, còn ~{remaining:,})", file=sys.stderr)
    if delta_tokens > 0:
        print(f"Yêu cầu này: ~{delta_tokens:,} token", file=sys.stderr)


def main():
    data = json.load(sys.stdin)
    event = data.get("hook_event_name", "")

    if event == "UserPromptSubmit":
        handle_user_prompt_submit(data)
    elif event == "Stop":
        handle_stop(data)

    sys.exit(0)


if __name__ == "__main__":
    main()
```

**Cấu hình:**
```json
{
  "hooks": {
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/context-tracker.py\""
          }
        ]
      }
    ]
  }
}
```

**Cách thức hoạt động:**
1. `UserPromptSubmit` kích hoạt trước khi prompt của bạn được xử lý - lưu số lượng token hiện tại.
2. `Stop` kích hoạt sau khi Claude phản hồi - tính toán delta và báo cáo mức sử dụng.
3. Mỗi phiên được tách biệt thông qua `session_id` trong tên tệp tạm.

**Các phương pháp đếm Token:**

| Phương pháp | Độ chính xác | Các phụ thuộc | Tốc độ |
|--------|----------|--------------|-------|
| Ước tính theo ký tự | ~80-90% | Không | <1ms |
| tiktoken (p50k_base) | ~90-95% | `pip install tiktoken` | <10ms |

> **Lưu ý:** Anthropic chưa phát hành một tokenizer ngoại tuyến (offline) chính thức. Cả hai phương pháp đều là ước tính. Bản ghi (transcript) bao gồm các prompt của người dùng, phản hồi của Claude và đầu ra của công cụ, nhưng KHÔNG bao gồm các prompt hệ thống hoặc ngữ cảnh nội bộ.

### Ví dụ 7: Cấp quyền Auto-Mode (Script thiết lập một lần)

Một script thiết lập một lần để nạp vào `~/.claude/settings.json` khoảng 67 quy tắc cấp quyền an toàn tương đương với cấu hình cơ sở auto-mode của Claude Code — mà không cần bất kỳ hook nào, và không cần ghi nhớ các lựa chọn trong tương lai. Chạy một lần; an toàn để chạy lại (bỏ qua các quy tắc đã tồn tại).

**Tệp:** `09-advanced-features/setup-auto-mode-permissions.py`

```bash
# Xem trước những gì sẽ được thêm vào
python3 09-advanced-features/setup-auto-mode-permissions.py --dry-run

# Áp dụng
python3 09-advanced-features/setup-auto-mode-permissions.py
```

**Những gì được thêm vào:**

| Danh mục | Ví dụ |
|----------|---------|
| Các công cụ tích hợp | `Read(*)`, `Edit(*)`, `Write(*)`, `Glob(*)`, `Grep(*)`, `Agent(*)`, `WebSearch(*)` |
| Đọc Git | `Bash(git status:*)`, `Bash(git log:*)`, `Bash(git diff:*)` |
| Ghi Git (cục bộ) | `Bash(git add:*)`, `Bash(git commit:*)`, `Bash(git checkout:*)` |
| Các trình quản lý gói | `Bash(npm install:*)`, `Bash(pip install:*)`, `Bash(cargo build:*)` |
| Build & Test | `Bash(make:*)`, `Bash(pytest:*)`, `Bash(go test:*)` |
| Shell thông dụng | `Bash(ls:*)`, `Bash(cat:*)`, `Bash(find:*)`, `Bash(cp:*)`, `Bash(mv:*)` |
| GitHub CLI | `Bash(gh pr view:*)`, `Bash(gh pr create:*)`, `Bash(gh issue list:*)` |

**Những gì được cố ý loại trừ** (không bao giờ được thêm bởi script này):
- `rm -rf`, `sudo`, push cưỡng ép (force push), `git reset --hard`
- `DROP TABLE`, `kubectl delete`, `terraform destroy`
- `npm publish`, `curl | bash`, triển khai lên production

## Plugin Hooks

Các plugin có thể bao gồm các hook trong tệp `hooks/hooks.json` của chúng:

**Tệp:** `plugins/hooks/hooks.json`

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PLUGIN_ROOT}/scripts/validate.sh"
          }
        ]
      }
    ]
  }
}
```

**Biến môi trường trong Plugin Hooks:**
- `${CLAUDE_PLUGIN_ROOT}` - Đường dẫn đến thư mục plugin
- `${CLAUDE_PLUGIN_DATA}` - Đường dẫn đến thư mục dữ liệu của plugin

Điều này cho phép các plugin bao gồm các hook xác thực và tự động hóa tùy chỉnh.

## MCP Tool Hooks

Các công cụ MCP tuân theo mẫu `mcp__<server>__<tool>`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "mcp__memory__.*",
        "hooks": [
          {
            "type": "command",
            "command": "echo '{\"systemMessage\": \"Thao tác bộ nhớ đã được ghi nhật ký\"}'"
          }
        ]
      }
    ]
  }
}
```

## Cân nhắc về Bảo mật

### Tuyên bố miễn trừ trách nhiệm

**TỰ CHỊU RỦI RO KHI SỬ DỤNG**: Hooks thực thi các lệnh shell tùy ý. Bạn hoàn toàn chịu trách nhiệm về:
- Các lệnh bạn cấu hình
- Các quyền truy cập/sửa đổi tệp
- Khả năng mất dữ liệu hoặc hỏng hóc hệ thống
- Kiểm tra các hook trong môi trường an toàn trước khi sử dụng chính thức

### Lưu ý Bảo mật

- **Yêu cầu sự tin cậy của không gian làm việc (Workspace trust):** Các lệnh đầu ra của hook `statusLine` và `fileSuggestion` giờ đây yêu cầu sự chấp nhận tin cậy của không gian làm việc trước khi chúng có hiệu lực.
- **HTTP hooks và biến môi trường:** HTTP hooks yêu cầu một danh sách `allowedEnvVars` rõ ràng để sử dụng nội suy biến môi trường trong URL. Điều này ngăn chặn việc rò rỉ vô tình các biến môi trường nhạy cảm đến các endpoint từ xa.
- **Phân cấp cấu hình quản lý (Managed settings hierarchy):** Cài đặt `disableAllHooks` hiện tuân thủ phân cấp cấu hình quản lý, nghĩa là các cài đặt cấp tổ chức có thể thực thi việc vô hiệu hóa hook mà người dùng cá nhân không thể ghi đè.

### Các phương pháp hay nhất (Best Practices)

| Nên | Không nên |
|-----|-------|
| Xác thực và làm sạch tất cả đầu vào | Tin tưởng mù quáng vào dữ liệu đầu vào |
| Đặt các biến shell trong dấu ngoặc kép: `"$VAR"` | Sử dụng biến không có ngoặc kép: `$VAR` |
| Chặn việc duyệt thư mục con (`..`) | Cho phép các đường dẫn tùy ý |
| Sử dụng đường dẫn tuyệt đối với `$CLAUDE_PROJECT_DIR` | Ghi cứng (Hardcode) các đường dẫn |
| Bỏ qua các tệp nhạy cảm (`.env`, `.git/`, chìa khóa) | Xử lý tất cả mọi tệp |
| Kiểm tra các hook một cách cô lập trước | Triển khai các hook chưa qua kiểm thử |
| Sử dụng `allowedEnvVars` rõ ràng cho HTTP hooks | Để lộ tất cả các biến môi trường cho webhooks |

## Gỡ lỗi (Debugging)

### Bật chế độ Gỡ lỗi

Chạy Claude với cờ debug để xem nhật ký hook chi tiết:

```bash
claude --debug
```

### Chế độ Verbose

Sử dụng `Ctrl+O` trong Claude Code để bật chế độ verbose và xem tiến trình thực thi hook.

### Kiểm tra các Hook một cách độc lập

```bash
# Kiểm tra với đầu vào JSON mẫu
echo '{"tool_name": "Bash", "tool_input": {"command": "ls -la"}}' | python3 .claude/hooks/validate-bash.py

# Kiểm tra mã thoát
echo $?
```

## Ví dụ Cấu hình Hoàn chỉnh

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-bash.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/format-code.sh\"",
            "timeout": 30
          },
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/security-scan.py\"",
            "timeout": 10
          }
        ]
      }
    ],
    "UserPromptSubmit": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 \"$CLAUDE_PROJECT_DIR/.claude/hooks/validate-prompt.py\""
          }
        ]
      }
    ],
    "SessionStart": [
      {
        "matcher": "startup",
        "hooks": [
          {
            "type": "command",
            "command": "\"$CLAUDE_PROJECT_DIR/.claude/hooks/session-init.sh\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "prompt",
            "prompt": "Verify all tasks are complete before stopping.",
            "timeout": 30
          }
        ]
      }
    ]
  }
}
```

## Chi tiết Thực thi Hook

| Khía cạnh | Hành vi |
|--------|----------|
| **Thời gian chờ (Timeout)** | Mặc định 60 giây, có thể cấu hình cho từng lệnh |
| **Song song hóa** | Tất cả các hook phù hợp sẽ chạy song song |
| **Loại bỏ trùng lặp** | Các lệnh hook giống hệt nhau sẽ được loại bỏ trùng |
| **Môi trường** | Chạy trong thư mục hiện tại với môi trường của Claude Code |

## Xử lý sự cố (Troubleshooting)

### Hook không thực thi
- Kiểm tra lại cú pháp cấu hình JSON xem có chính xác không.
- Kiểm tra xem mẫu matcher có khớp với tên công cụ không.
- Đảm bảo script tồn tại và có quyền thực thi: `chmod +x script.sh`
- Chạy `claude --debug` để xem nhật ký thực thi hook.
- Kiểm tra xem hook có đọc JSON từ stdin không (chứ không phải từ đối số lệnh).

### Hook chặn không như mong đợi
- Kiểm tra hook với JSON mẫu: `echo '{"tool_name": "Write", ...}' | ./hook.py`
- Kiểm tra mã thoát: phải là 0 để cho phép, 2 để chặn.
- Kiểm tra đầu ra stderr (được hiển thị khi có mã thoát 2).

### Lỗi Phân tích JSON
- Luôn đọc từ stdin, không phải đối số lệnh.
- Sử dụng phân tích JSON thích hợp (không phải thao tác chuỗi).
- Xử lý các trường bị thiếu một cách khéo léo.

## Cài đặt

### Bước 1: Tạo thư mục Hooks
```bash
mkdir -p ~/.claude/hooks
```

### Bước 2: Sao chép các Hook Ví dụ
```bash
cp 06-hooks/*.sh ~/.claude/hooks/
chmod +x ~/.claude/hooks/*.sh
```

### Bước 3: Cấu hình trong Cài đặt
Chỉnh sửa tệp `~/.claude/settings.json` hoặc `.claude/settings.json` với cấu hình hook như ví dụ ở trên.

## Các khái niệm liên quan

- **[Checkpoints và Rewind](../08-checkpoints/)** - Lưu và khôi phục trạng thái hội thoại.
- **[Slash Commands](../01-slash-commands/)** - Tạo các lệnh slash tùy chỉnh.
- **[Skills](../03-skills/)** - Các khả năng tự trị có thể tái sử dụng.
- **[Subagents](../04-subagents/)** - Ủy thác thực thi nhiệm vụ.
- **[Plugins](../07-plugins/)** - Các gói mở rộng đi kèm.
- **[Tính năng Nâng cao](../09-advanced-features/)** - Khám phá các khả năng nâng cao của Claude Code.

## Tài nguyên bổ sung

- **[Tài liệu chính thức về Hooks](https://code.claude.com/docs/en/hooks)** - Tham chiếu đầy đủ về hooks.
- **[Tham chiếu CLI](https://code.claude.com/docs/en/cli-reference)** - Tài liệu về giao diện dòng lệnh.
- **[Hướng dẫn về Bộ nhớ (Memory)](../02-memory/)** - Cấu hình ngữ cảnh lâu dài.
