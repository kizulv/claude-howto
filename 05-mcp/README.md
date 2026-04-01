<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../resources/logos/claude-howto-logo.svg">
</picture>

# MCP (Model Context Protocol)

Thư mục này chứa tài liệu hướng dẫn toàn diện và các ví dụ về cấu hình cũng như cách sử dụng máy chủ MCP (MCP server) với Claude Code.

## Tổng quan (Overview)

MCP (Model Context Protocol) là một phương thức tiêu chuẩn hóa để Claude truy cập các công cụ bên ngoài, các API và các nguồn dữ liệu thời gian thực. Khác với Memory, MCP cung cấp quyền truy cập trực tiếp vào dữ liệu thay đổi liên tục.

Các đặc điểm chính:
- Truy cập thời gian thực vào các dịch vụ bên ngoài
- Đồng bộ hóa dữ liệu trực tiếp (Live data synchronization)
- Kiến trúc có khả năng mở rộng
- Xác thực an toàn
- Tương tác dựa trên công cụ (Tool-based interactions)

## Kiến trúc MCP (MCP Architecture)

```mermaid
graph TB
    A["Claude"]
    B["MCP Server"]
    C["External Service"]

    A -->|Request: list_issues| B
    B -->|Query| C
    C -->|Data| B
    B -->|Response| A

    A -->|Request: create_issue| B
    B -->|Action| C
    C -->|Result| B
    B -->|Response| A

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#e8f5e9,stroke:#333,color:#333
```

## Hệ sinh thái MCP (MCP Ecosystem)

```mermaid
graph TB
    A["Claude"] -->|MCP| B["Filesystem<br/>MCP Server"]
    A -->|MCP| C["GitHub<br/>MCP Server"]
    A -->|MCP| D["Database<br/>MCP Server"]
    A -->|MCP| E["Slack<br/>MCP Server"]
    A -->|MCP| F["Google Docs<br/>MCP Server"]

    B -->|File I/O| G["Local Files"]
    C -->|API| H["GitHub Repos"]
    D -->|Query| I["PostgreSQL/MySQL"]
    E -->|Messages| J["Slack Workspace"]
    F -->|Docs| K["Google Drive"]

    style A fill:#e1f5fe,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#f3e5f5,stroke:#333,color:#333
    style F fill:#f3e5f5,stroke:#333,color:#333
    style G fill:#e8f5e9,stroke:#333,color:#333
    style H fill:#e8f5e9,stroke:#333,color:#333
    style I fill:#e8f5e9,stroke:#333,color:#333
    style J fill:#e8f5e9,stroke:#333,color:#333
    style K fill:#e8f5e9,stroke:#333,color:#333
```

## Các phương pháp Cài đặt MCP (MCP Installation Methods)

Claude Code hỗ trợ nhiều giao thức truyền tải (transport protocols) cho các kết nối máy chủ MCP:

### Truyền tải qua HTTP (Khuyên dùng)

```bash
# Kết nối HTTP cơ bản
claude mcp add --transport http notion https://mcp.notion.com/mcp

# HTTP với tiêu đề xác thực (authentication header)
claude mcp add --transport http secure-api https://api.example.com/mcp \
  --header "Authorization: Bearer your-token"
```

### Truyền tải qua Stdio (Cục bộ)

Đối với các máy chủ MCP chạy tại máy cục bộ:

```bash
# Máy chủ Node.js cục bộ
claude mcp add --transport stdio myserver -- npx @myorg/mcp-server

# Với các biến môi trường
claude mcp add --transport stdio myserver --env KEY=value -- npx server
```

### Truyền tải qua SSE (Đã lỗi thời)

Giao thức Server-Sent Events đã bị lỗi thời để nhường chỗ cho `http` nhưng vẫn được hỗ trợ:

```bash
claude mcp add --transport sse legacy-server https://example.com/sse
```

### Truyền tải qua WebSocket

Giao thức WebSocket dùng cho các kết nối hai chiều liên tục:

```bash
claude mcp add --transport ws realtime-server wss://example.com/mcp
```

### Lưu ý riêng cho Windows

Trên hệ điều hành Windows bản địa (không phải WSL), hãy sử dụng `cmd /c` cho các lệnh npx:

```bash
claude mcp add --transport stdio my-server -- cmd /c npx -y @some/package
```

### Xác thực OAuth 2.0

Claude Code hỗ trợ OAuth 2.0 cho các máy chủ MCP yêu cầu nó. Khi kết nối với một máy chủ hỗ trợ OAuth, Claude Code sẽ xử lý toàn bộ luồng xác thực:

```bash
# Kết nối với máy chủ MCP hỗ trợ OAuth (luồng tương tác)
claude mcp add --transport http my-service https://my-service.example.com/mcp

# Cấu hình trước thông tin OAuth cho việc thiết lập không tương tác
claude mcp add --transport http my-service https://my-service.example.com/mcp \
  --client-id "your-client-id" \
  --client-secret "your-client-secret" \
  --callback-port 8080
```

| Tính năng | Mô tả |
|---------|-------------|
| **OAuth Tương tác** | Sử dụng lệnh `/mcp` để kích hoạt luồng OAuth trên trình duyệt |
| **OAuth client đã cấu hình sẵn** | Các OAuth client tích hợp sẵn cho các dịch vụ phổ biến như Notion, Stripe và các dịch vụ khác (v2.1.30+) |
| **Thông tin xác thực cấu hình sẵn** | Sử dụng các cờ `--client-id`, `--client-secret`, `--callback-port` để thiết lập tự động |
| **Lưu trữ Token** | Các token được lưu trữ an toàn trong keychain của hệ thống |
| **Xác thực nâng cao (Step-up auth)** | Hỗ trợ xác thực bổ sung cho các hoạt động yêu cầu đặc quyền cao |
| **Bộ nhớ đệm khám phá (Discovery caching)** | Metadata khám phá OAuth được lưu vào bộ nhớ đệm để kết nối lại nhanh hơn |
| **Ghi đè Metadata** | Sử dụng `oauth.authServerMetadataUrl` trong `.mcp.json` để ghi đè việc khám phá metadata OAuth mặc định |

#### Ghi đè việc Khám phá Metadata OAuth

Nếu máy chủ MCP của bạn trả về lỗi tại endpoint metadata OAuth tiêu chuẩn (`/.well-known/oauth-authorization-server`) nhưng có một endpoint OIDC đang hoạt động, bạn có thể yêu cầu Claude Code lấy metadata OAuth từ một URL cụ thể. Thiết lập `authServerMetadataUrl` trong đối tượng `oauth` của cấu hình máy chủ:

```json
{
  "mcpServers": {
    "my-server": {
      "type": "http",
      "url": "https://mcp.example.com/mcp",
      "oauth": {
        "authServerMetadataUrl": "https://auth.example.com/.well-known/openid-configuration"
      }
    }
  }
}
```

URL phải sử dụng `https://`. Tùy chọn này yêu cầu Claude Code phiên bản v2.1.64 trở lên.

### Các MCP Connector trên Claude.ai

Các máy chủ MCP được cấu hình trong tài khoản Claude.ai của bạn sẽ tự động khả dụng trong Claude Code. Điều này có nghĩa là bất kỳ kết nối MCP nào bạn thiết lập qua giao diện web Claude.ai đều có thể truy cập được mà không cần cấu hình thêm.

Các MCP connector của Claude.ai cũng khả dụng trong chế độ `--print` (v2.1.83+), cho phép sử dụng trong các tập lệnh và không tương tác.

Để tắt các máy chủ MCP của Claude.ai trong Claude Code, hãy đặt biến môi trường `ENABLE_CLAUDEAI_MCP_SERVERS` thành `false`:

```bash
ENABLE_CLAUDEAI_MCP_SERVERS=false claude
```

> **Lưu ý:** Tính năng này chỉ dành cho người dùng đã đăng nhập bằng tài khoản Claude.ai.

## Quy trình Thiết lập MCP (MCP Setup Process)

```mermaid
sequenceDiagram
    participant User
    participant Claude as Claude Code
    participant Config as Config File
    participant Service as External Service

    User->>Claude: Gõ /mcp
    Claude->>Claude: Liệt kê các máy chủ MCP có sẵn
    Claude->>User: Hiển thị các tùy chọn
    User->>Claude: Chọn GitHub MCP
    Claude->>Config: Cập nhật cấu hình
    Config->>Claude: Kích hoạt kết nối
    Claude->>Service: Kiểm tra kết nối
    Service-->>Claude: Xác thực thành công
    Claude->>User: ✅ Đã kết nối MCP!
```

## Tìm kiếm Công cụ MCP (MCP Tool Search)

Khi mô tả của các công cụ MCP vượt quá 10% cửa sổ ngữ cảnh (context window), Claude Code tự động bật tính năng tìm kiếm công cụ để chọn đúng công cụ một cách hiệu quả mà không làm quá tải ngữ cảnh của mô hình.

| Thiết lập | Giá trị | Mô tả |
|---------|-------|-------------|
| `ENABLE_TOOL_SEARCH` | `auto` (mặc định) | Tự động bật khi mô tả công cụ vượt quá 10% ngữ cảnh |
| `ENABLE_TOOL_SEARCH` | `auto:<N>` | Tự động bật tại ngưỡng tùy chỉnh là `N` công cụ |
| `ENABLE_TOOL_SEARCH` | `true` | Luôn bật bất kể số lượng công cụ |
| `ENABLE_TOOL_SEARCH` | `false` | Tắt; tất cả các mô tả công cụ được gửi đầy đủ |

> **Lưu ý:** Tính năng tìm kiếm công cụ yêu cầu Sonnet 4 trở lên, hoặc Opus 4 trở lên. Các mô hình Haiku không hỗ trợ tìm kiếm công cụ.

## Cập nhật Công cụ Động (Dynamic Tool Updates)

Claude Code hỗ trợ các thông báo `list_changed` của MCP. Khi một máy chủ MCP thêm, xóa hoặc sửa đổi các công cụ có sẵn một cách động, Claude Code sẽ nhận được cập nhật và tự động điều chỉnh danh sách công cụ -- không cần kết nối lại hoặc khởi động lại.

## Gợi ý thông tin MCP (MCP Elicitation)

Các máy chủ MCP có thể yêu cầu đầu vào theo cấu trúc từ người dùng thông qua các hộp thoại tương tác (v2.1.49+). Điều này cho phép máy chủ MCP hỏi thêm thông tin ngay giữa quy trình làm việc -- ví dụ: yêu cầu xác nhận, chọn từ danh sách các tùy chọn hoặc điền vào các trường bắt buộc -- tăng tính tương tác cho các trao đổi với máy chủ MCP.

## Giới hạn Mô tả và Hướng dẫn Công cụ (Tool Description and Instruction Cap)

Kể từ phiên bản v2.1.84, Claude Code áp dụng **giới hạn 2 KB** cho các mô tả và hướng dẫn công cụ trên mỗi máy chủ MCP. Điều này ngăn chặn từng máy chủ riêng lẻ tiêu thụ quá nhiều ngữ cảnh với các định nghĩa công cụ quá dài dòng, giúp giảm bớt sự phình to ngữ cảnh và giữ cho các tương tác hiệu quả.

## Prompts của MCP dưới dạng các lệnh Slash

Các máy chủ MCP có thể hiển thị các prompt xuất hiện dưới dạng các lệnh slash trong Claude Code. Các prompt này có thể truy cập được bằng quy ước đặt tên:

```
/mcp__<server>__<prompt>
```

Ví dụ, nếu một máy chủ có tên `github` hiển thị một prompt tên là `review`, bạn có thể gọi nó bằng lệnh `/mcp__github__review`.

## Loại bỏ Máy chủ Trùng lặp (Server Deduplication)

Khi cùng một máy chủ MCP được định nghĩa ở nhiều phạm vi (cục bộ, dự án, người dùng), cấu hình cục bộ sẽ được ưu tiên. Điều này cho phép bạn ghi đè các thiết lập MCP ở cấp độ dự án hoặc cấp độ người dùng bằng các tùy chỉnh cục bộ mà không gặp xung đột.

## Tài nguyên MCP qua lượt nhắc bằng ký hiệu @

Bạn có thể tham chiếu trực tiếp các tài nguyên MCP trong prompt của mình bằng cú pháp `@`:

```
@server-name:protocol://resource/path
```

Ví dụ, để tham chiếu một tài nguyên cơ sở dữ liệu cụ thể:

```
@database:postgres://mydb/users
```

Điều này cho phép Claude lấy và đưa nội dung tài nguyên MCP vào trực tiếp như một phần của ngữ cảnh cuộc hội thoại.

## Phạm vi MCP (MCP Scopes)

Các cấu hình MCP có thể được lưu trữ ở các phạm vi khác nhau với mức độ chia sẻ khác nhau:

| Phạm vi | Vị trí | Mô tả | Chia sẻ với | Yêu cầu Phê duyệt |
|-------|----------|-------------|-------------|------------------|
| **Cục bộ (Local)** (mặc định) | `~/.claude.json` (dưới đường dẫn dự án) | Riêng tư cho người dùng hiện tại, chỉ trong dự án hiện tại (được gọi là `project` trong các phiên bản cũ) | Chỉ mình bạn | Không |
| **Dự án (Project)** | `.mcp.json` | Được commit vào kho lưu trữ git | Các thành viên trong nhóm | Có (lần sử dụng đầu tiên) |
| **Người dùng (User)** | `~/.claude.json` | Khả dụng trên tất cả các dự án (được gọi là `global` trong các phiên bản cũ) | Chỉ mình bạn | Không |

### Sử dụng Phạm vi Dự án (Project Scope)

Lưu trữ các cấu hình MCP cụ thể cho dự án trong `.mcp.json`:

```json
{
  "mcpServers": {
    "github": {
      "type": "http",
      "url": "https://api.github.com/mcp"
    }
  }
}
```

Các thành viên trong nhóm sẽ thấy một lời nhắc phê duyệt trong lần đầu tiên sử dụng các MCP cấp độ dự án.

## Quản lý Cấu hình MCP (MCP Configuration Management)

### Thêm máy chủ MCP

```bash
# Thêm máy chủ dựa trên HTTP
claude mcp add --transport http github https://api.github.com/mcp

# Thêm máy chủ stdio cục bộ
claude mcp add --transport stdio database -- npx @company/db-server

# Liệt kê tất cả các máy chủ MCP
claude mcp list

# Tải thông tin chi tiết về một máy chủ cụ thể
claude mcp get github

# Xóa một máy chủ MCP
claude mcp remove github

# Đặt lại các lựa chọn phê duyệt cụ thể cho dự án
claude mcp reset-project-choices

# Nhập từ Claude Desktop
claude mcp add-from-claude-desktop
```

## Bảng các máy chủ MCP có sẵn (Available MCP Servers Table)

| Máy chủ MCP | Mục đích | Các công cụ phổ biến | Xác thực | Thời gian thực |
|------------|---------|--------------|------|-----------|
| **Filesystem** | Các thao tác với tệp | read, write, delete | Quyền của HĐH | ✅ Có |
| **GitHub** | Quản lý kho lưu trữ | list_prs, create_issue, push | OAuth | ✅ Có |
| **Slack** | Giao tiếp trong nhóm | send_message, list_channels | Token | ✅ Có |
| **Database** | Truy vấn SQL | query, insert, update | Thông tin đăng nhập | ✅ Có |
| **Google Docs** | Truy cập tài liệu | read, write, share | OAuth | ✅ Có |
| **Asana** | Quản lý dự án | create_task, update_status | API Key | ✅ Có |
| **Stripe** | Dữ liệu thanh toán | list_charges, create_invoice | API Key | ✅ Có |
| **Memory** | Bộ nhớ dài hạn | store, retrieve, delete | Cục bộ | ❌ Không |

## Practical Examples

## Các ví dụ Thực tế (Practical Examples)

### Ví dụ 1: Cấu hình GitHub MCP

**Tệp:** `.mcp.json` (thư mục gốc dự án)

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

**Các công cụ GitHub MCP có sẵn:**

#### Quản lý Pull Request (Pull Request Management)
- `list_prs` - Liệt kê tất cả các PR trong kho lưu trữ
- `get_pr` - Lấy thông tin chi tiết về PR bao gồm cả phần khác biệt (diff)
- `create_pr` - Tạo PR mới
- `update_pr` - Cập nhật mô tả/tiêu đề của PR
- `merge_pr` - Hợp nhất PR vào nhánh chính (main branch)
- `review_pr` - Thêm các nhận xét review

**Ví dụ yêu cầu:**
```
/mcp__github__get_pr 456

# Trả về:
Tiêu đề: Thêm hỗ trợ chế độ tối (dark mode)
Tác giả: @alice
Mô tả: Triển khai giao diện tối bằng các biến CSS
Trạng thái: ĐANG MỞ (OPEN)
Người review: @bob, @charlie
```

#### Quản lý Issue (Issue Management)
- `list_issues` - Liệt kê tất cả các issue
- `get_issue` - Lấy thông tin chi tiết về issue
- `create_issue` - Tạo issue mới
- `close_issue` - Đóng issue
- `add_comment` - Thêm nhận xét vào issue

#### Thông tin Kho lưu trữ (Repository Information)
- `get_repo_info` - Thông tin chi tiết về kho lưu trữ
- `list_files` - Cấu trúc cây thư mục tệp
- `get_file_content` - Đọc nội dung tệp
- `search_code` - Tìm kiếm trong toàn bộ mã nguồn

#### Các thao tác Commit (Commit Operations)
- `list_commits` - Lịch sử commit
- `get_commit` - Thông tin chi tiết về một commit cụ thể
- `create_commit` - Tạo commit mới

**Thiết lập**:
```bash
export GITHUB_TOKEN="token_github_cua_ban"
# Hoặc sử dụng CLI để thêm trực tiếp:
claude mcp add --transport stdio github -- npx @modelcontextprotocol/server-github
```

### Triển khai Biến môi trường trong Cấu hình

Cấu hình MCP hỗ trợ triển khai biến môi trường với các giá trị mặc định dự phòng. Cú pháp `${VAR}` và `${VAR:-default}` hoạt động trong các trường sau: `command`, `args`, `env`, `url`, và `headers`.

```json
{
  "mcpServers": {
    "api-server": {
      "type": "http",
      "url": "${API_BASE_URL:-https://api.example.com}/mcp",
      "headers": {
        "Authorization": "Bearer ${API_KEY}",
        "X-Custom-Header": "${CUSTOM_HEADER:-default-value}"
      }
    },
    "local-server": {
      "command": "${MCP_BIN_PATH:-npx}",
      "args": ["${MCP_PACKAGE:-@company/mcp-server}"],
      "env": {
        "DB_URL": "${DATABASE_URL:-postgresql://localhost/dev}"
      }
    }
  }
}
```

Các biến được triển khai tại thời điểm thực thi (runtime):
- `${VAR}` - Sử dụng biến môi trường, báo lỗi nếu không được thiết lập
- `${VAR:-default}` - Sử dụng biến môi trường, quay lại giá trị mặc định nếu không được thiết lập

### Ví dụ 2: Thiết lập Database MCP

**Cấu hình:**

```json
{
  "mcpServers": {
    "database": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-database"],
      "env": {
        "DATABASE_URL": "postgresql://user:pass@localhost/mydb"
      }
    }
  }
}
```

**Ví dụ Sử dụng:**

```markdown
Người dùng: Lấy tất cả người dùng có hơn 10 đơn hàng

Claude: Tôi sẽ truy vấn cơ sở dữ liệu của bạn để tìm thông tin đó.

# Sử dụng công cụ database của MCP:
SELECT u.*, COUNT(o.id) as order_count
FROM users u
LEFT JOIN orders o ON u.id = o.user_id
GROUP BY u.id
HAVING COUNT(o.id) > 10
ORDER BY order_count DESC;

# Kết quả:
- Alice: 15 đơn hàng
- Bob: 12 đơn hàng
- Charlie: 11 đơn hàng
```

**Thiết lập**:
```bash
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
# Hoặc sử dụng CLI để thêm trực tiếp:
claude mcp add --transport stdio database -- npx @modelcontextprotocol/server-database
```

### Ví dụ 3: Quy trình làm việc Multi-MCP (Multi-MCP Workflow)

**Kịch bản: Tạo Báo cáo Hàng ngày**

```markdown
# Quy trình tạo báo cáo hàng ngày sử dụng nhiều MCP

## Thiết lập
1. GitHub MCP - lấy các chỉ số PR
2. Database MCP - truy vấn dữ liệu bán hàng
3. Slack MCP - đăng báo cáo
4. Filesystem MCP - lưu báo cáo

## Quy trình làm việc

### Bước 1: Lấy dữ liệu GitHub
/mcp__github__list_prs completed:true last:7days

Đầu ra:
- Tổng số PR: 42
- Thời gian hợp nhất trung bình: 2.3 giờ
- Thời gian phản hồi review: 1.1 giờ

### Bước 2: Truy vấn Cơ sở dữ liệu
SELECT COUNT(*) as sales, SUM(amount) as revenue
FROM orders
WHERE created_at > NOW() - INTERVAL '1 day'

Đầu ra:
- Số đơn hàng: 247
- Doanh thu: $12,450

### Bước 3: Tạo báo cáo
Kết hợp dữ liệu thành báo cáo HTML

### Bước 4: Lưu vào hệ thống tệp (Filesystem)
Ghi tệp report.html vào thư mục /reports/

### Bước 5: Đăng lên Slack
Gửi bản tóm tắt vào kênh #daily-reports

Kết quả cuối cùng:
✅ Báo cáo đã được tạo và đăng tải
📊 47 PR đã được hợp nhất trong tuần này
💰 $12,450 doanh thu hàng ngày
```

**Thiết lập**:
```bash
export GITHUB_TOKEN="token_github_cua_ban"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="token_slack_cua_ban"
# Thêm từng máy chủ MCP qua CLI hoặc cấu hình chúng trong .mcp.json
```

### Ví dụ 4: Các thao tác Filesystem MCP

**Cấu hình:**

```json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-filesystem", "/home/user/projects"]
    }
  }
}
```

**Các thao tác có sẵn:**

| Thao tác | Lệnh | Mục đích |
|-----------|---------|---------|
| Liệt kê tệp | `ls ~/projects` | Hiển thị nội dung thư mục |
| Đọc tệp | `cat src/main.ts` | Đọc nội dung tệp |
| Ghi tệp | `create docs/api.md` | Tạo tệp mới |
| Sửa tệp | `edit src/app.ts` | Chỉnh sửa tệp |
| Tìm kiếm | `grep "async function"` | Tìm kiếm trong các tệp |
| Xóa | `rm old-file.js` | Xóa tệp |

**Thiết lập**:
```bash
# Sử dụng CLI để thêm trực tiếp:
claude mcp add --transport stdio filesystem -- npx @modelcontextprotocol/server-filesystem /home/user/projects
```

## MCP so với Memory: Ma trận Quyết định (Decision Matrix)

```mermaid
graph TD
    A["Cần dữ liệu bên ngoài?"]
    A -->|Không| B["Sử dụng Memory"]
    A -->|Có| C["Nó có thay đổi thường xuyên không?"]
    C -->|Không/Hiếm khi| B
    C -->|Có/Thường xuyên| D["Sử dụng MCP"]

    B -->|Lưu trữ| E["Sở thích<br/>Ngữ cảnh<br/>Lịch sử"]
    D -->|Truy cập| F["Live APIs<br/>Cơ sở dữ liệu<br/>Dịch vụ"]

    style A fill:#fff3e0,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#fff3e0,stroke:#333,color:#333
    style D fill:#f3e5f5,stroke:#333,color:#333
    style E fill:#e8f5e9,stroke:#333,color:#333
    style F fill:#e8f5e9,stroke:#333,color:#333
```

## Mô hình Yêu cầu/Phản hồi (Request/Response Pattern)

```mermaid
sequenceDiagram
    participant App as Claude
    participant MCP as MCP Server
    participant DB as Database

    App->>MCP: Yêu cầu: "SELECT * FROM users WHERE id=1"
    MCP->>DB: Thực thi truy vấn
    DB-->>MCP: Tập kết quả (Result set)
    MCP-->>App: Trả về dữ liệu đã xử lý
    App->>App: Xử lý kết quả
    App->>App: Tiếp tục nhiệm vụ

    Note over MCP,DB: Truy cập thời gian thực<br/>Không dùng bộ nhớ đệm (caching)
```

## Biến môi trường (Environment Variables)

Lưu trữ các thông tin xác thực nhạy cảm trong các biến môi trường:

```bash
# ~/.bashrc hoặc ~/.zshrc
export GITHUB_TOKEN="ghp_xxxxxxxxxxxxx"
export DATABASE_URL="postgresql://user:pass@localhost/mydb"
export SLACK_TOKEN="xoxb-xxxxxxxxxxxxx"
```

Sau đó tham chiếu chúng trong cấu hình MCP:

```json
{
  "env": {
    "GITHUB_TOKEN": "${GITHUB_TOKEN}"
  }
}
```

## Claude đóng vai trò Máy chủ MCP (`claude mcp serve`)

Bản thân Claude Code có thể hoạt động như một máy chủ MCP cho các ứng dụng khác. Điều này cho phép các công cụ bên ngoài, các trình soạn thảo và hệ thống tự động hóa tận dụng khả năng của Claude thông qua giao thức MCP tiêu chuẩn.

```bash
# Khởi động Claude Code như một máy chủ MCP trên stdio
claude mcp serve
```

Các ứng dụng khác sau đó có thể kết nối với máy chủ này giống như bất kỳ máy chủ MCP dựa trên stdio nào khác. Ví dụ, để thêm Claude Code làm máy chủ MCP trong một phiên bản Claude Code khác:

```bash
claude mcp add --transport stdio claude-agent -- claude mcp serve
```

Điều này hữu ích cho việc xây dựng các quy trình làm việc đa tác vụ (multi-agent workflows), nơi một phiên bản Claude điều phối một phiên bản khác.

## Cấu hình MCP được Quản lý (Dành cho Doanh nghiệp)

Đối với các triển khai trong doanh nghiệp, quản trị viên IT có thể thực thi chính sách máy chủ MCP thông qua tệp cấu hình `managed-mcp.json`. Tệp này cung cấp quyền kiểm soát độc quyền đối với máy chủ MCP nào được phép hoặc bị chặn trong toàn bộ tổ chức.

**Vị trí:**
- macOS: `/Library/Application Support/ClaudeCode/managed-mcp.json`
- Linux: `~/.config/ClaudeCode/managed-mcp.json`
- Windows: `%APPDATA%\ClaudeCode\managed-mcp.json`

**Tính năng:**
- `allowedMcpServers` -- danh sách trắng (whitelist) các máy chủ được phép
- `deniedMcpServers` -- danh sách đen (blocklist) các máy chủ bị cấm
- Hỗ trợ so khớp theo tên máy chủ, lệnh và các mẫu URL
- Các chính sách MCP toàn tổ chức được thực thi trước cấu hình của người dùng
- Ngăn chặn các kết nối máy chủ không được phép

**Ví dụ cấu hình:**

```json
{
  "allowedMcpServers": [
    {
      "serverName": "github",
      "serverUrl": "https://api.github.com/mcp"
    },
    {
      "serverName": "company-internal",
      "serverCommand": "company-mcp-server"
    }
  ],
  "deniedMcpServers": [
    {
      "serverName": "untrusted-*"
    },
    {
      "serverUrl": "http://*"
    }
  ]
}
```

> **Lưu ý:** Khi cả `allowedMcpServers` và `deniedMcpServers` đều khớp với một máy chủ, quy tắc chặn (deny) sẽ được ưu tiên.

## Các máy chủ MCP do Plugin cung cấp

Các plugin có thể đi kèm với máy chủ MCP của riêng chúng, giúp chúng tự động có sẵn khi plugin được cài đặt. Các máy chủ MCP do plugin cung cấp có thể được định nghĩa theo hai cách:

1. **Tệp `.mcp.json` độc lập** -- Đặt tệp `.mcp.json` trong thư mục gốc của plugin.
2. **Trực tiếp trong `plugin.json`** -- Định nghĩa các máy chủ MCP trực tiếp bên trong tệp manifest của plugin.

Sử dụng biến `${CLAUDE_PLUGIN_ROOT}` để tham chiếu các đường dẫn tương đối đến thư mục cài đặt của plugin:

```json
{
  "mcpServers": {
    "plugin-tools": {
      "command": "node",
      "args": ["${CLAUDE_PLUGIN_ROOT}/dist/mcp-server.js"],
      "env": {
        "CONFIG_PATH": "${CLAUDE_PLUGIN_ROOT}/config.json"
      }
    }
  }
}
```

## MCP trong Phạm vi Subagent (Subagent-Scoped MCP)

Các máy chủ MCP có thể được định nghĩa trực tiếp bên trong phần frontmatter của agent bằng khóa `mcpServers:`, giới hạn phạm vi của chúng cho một subagent cụ thể thay vì toàn bộ dự án. Điều này hữu ích khi một agent cần truy cập vào một máy chủ MCP cụ thể mà các agent khác trong quy trình làm việc không cần đến.

```yaml
---
mcpServers:
  my-tool:
    type: http
    url: https://my-tool.example.com/mcp
---

Bạn là một agent có quyền truy cập vào my-tool cho các hoạt động chuyên biệt.
```

Các máy chủ MCP trong phạm vi subagent chỉ khả dụng trong ngữ cảnh thực thi của agent đó và không được chia sẻ với các agent cha hoặc agent anh em.

## Giới hạn Đầu ra MCP (MCP Output Limits)

Claude Code thực thi các giới hạn đối với đầu ra của công cụ MCP để ngăn chặn tràn ngữ cảnh (context overflow):

| Giới hạn | Ngưỡng | Hành vi |
|-------|-----------|----------|
| **Cảnh báo (Warning)** | 10.000 token | Hiển thị cảnh báo rằng đầu ra quá lớn |
| **Tối đa mặc định** | 25.000 token | Đầu ra bị cắt bỏ vượt quá giới hạn này |
| **Lưu trữ trên đĩa** | 50.000 ký tự | Kết quả công cụ vượt quá 50K ký tự sẽ được lưu vào đĩa |

Giới hạn đầu ra tối đa có thể được cấu hình thông qua biến môi trường `MAX_MCP_OUTPUT_TOKENS`:

```bash
# Tăng mức đầu ra tối đa lên 50.000 token
export MAX_MCP_OUTPUT_TOKENS=50000
```

## Giải quyết Phình to Ngữ cảnh bằng Thực thi Mã (Code Execution)

Khi việc áp dụng MCP mở rộng, việc kết nối với hàng chục máy chủ với hàng trăm hoặc hàng nghìn công cụ tạo ra một thách thức lớn: **phình to ngữ cảnh (context bloat)**. Đây được cho là vấn đề lớn nhất đối với MCP ở quy mô lớn, và nhóm kỹ thuật của Anthropic đã đề xuất một giải pháp tinh tế — sử dụng thực thi mã thay vì gọi công cụ trực tiếp.

> **Nguồn**: [Code Execution with MCP: Building More Efficient Agents](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic Engineering Blog

### Vấn đề: Hai Nguồn lãng phí Token

**1. Định nghĩa công cụ làm quá tải cửa sổ ngữ cảnh**

Hầu hết các MCP client tải tất cả các định nghĩa công cụ ngay từ đầu. Khi kết nối với hàng nghìn công cụ, mô hình phải xử lý hàng trăm nghìn token trước khi nó đọc được yêu cầu của người dùng.

**2. Kết quả trung gian tiêu tốn thêm token**

Mọi kết quả công cụ trung gian đều đi qua ngữ cảnh của mô hình. Hãy xem xét việc chuyển một văn bản cuộc họp từ Google Drive sang Salesforce — toàn bộ văn bản sẽ đi qua ngữ cảnh **hai lần**: một lần khi đọc nó, và một lần nữa khi ghi nó vào đích đến. Một văn bản cuộc họp kéo dài 2 giờ có thể tiêu tốn thêm hơn 50.000 token.

```mermaid
graph LR
    A["Model"] -->|"Gọi công cụ: getDocument"| B["MCP Server"]
    B -->|"Toàn bộ văn bản (50K token)"| A
    A -->|"Gọi công cụ: updateRecord<br/>(gửi lại toàn bộ văn bản)"| B
    B -->|"Xác nhận"| A

    style A fill:#ffcdd2,stroke:#333,color:#333
    style B fill:#f3e5f5,stroke:#333,color:#333
```

### Giải pháp: Các công cụ MCP dưới dạng các API Mã nguồn (Code APIs)

Thay vì chuyển các định nghĩa công cụ và kết quả qua cửa sổ ngữ cảnh, agent sẽ **viết mã** để gọi các công cụ MCP như các API. Mã chạy trong một môi trường thực thi được sandbox, và chỉ kết quả cuối cùng mới được trả về cho mô hình.

```mermaid
graph LR
    A["Model"] -->|"Viết mã"| B["Môi trường Thực thi mã"]
    B -->|"Gọi các công cụ trực tiếp"| C["MCP Servers"]
    C -->|"Dữ liệu ở lại trong<br/>môi trường thực thi"| B
    B -->|"Chỉ trả về kết quả cuối cùng<br/>(số lượng token tối thiểu)"| A

    style A fill:#c8e6c9,stroke:#333,color:#333
    style B fill:#e1f5fe,stroke:#333,color:#333
    style C fill:#f3e5f5,stroke:#333,color:#333
```

#### Cách thức Hoạt động

Các công cụ MCP được trình bày dưới dạng một cây tệp gồm các hàm được định kiểu (typed functions):

```
servers/
├── google-drive/
│   ├── getDocument.ts
│   └── index.ts
├── salesforce/
│   ├── updateRecord.ts
│   └── index.ts
└── ...
```

Mỗi tệp công cụ chứa một trình bao bọc được định kiểu (typed wrapper):

```typescript
// ./servers/google-drive/getDocument.ts
import { callMCPTool } from "../../../client.js";

interface GetDocumentInput {
  documentId: string;
}

interface GetDocumentResponse {
  content: string;
}

export async function getDocument(
  input: GetDocumentInput
): Promise<GetDocumentResponse> {
  return callMCPTool<GetDocumentResponse>(
    'google_drive__get_document', input
  );
}
```

Sau đó, agent viết mã để điều phối các công cụ:

```typescript
import * as gdrive from './servers/google-drive';
import * as salesforce from './servers/salesforce';

// Dữ liệu chảy trực tiếp giữa các công cụ — không bao giờ đi qua mô hình
const transcript = (
  await gdrive.getDocument({ documentId: 'abc123' })
).content;

await salesforce.updateRecord({
  objectType: 'SalesMeeting',
  recordId: '00Q5f000001abcXYZ',
  data: { Notes: transcript }
});
```

**Kết quả: Lượng token sử dụng giảm từ ~150.000 xuống còn ~2.000 — giảm 98,7%.**

### Các Lợi ích Chính

| Lợi ích | Mô tả |
|---------|-------------|
| **Tiết lộ Dần dần (Progressive Disclosure)** | Agent duyệt qua hệ thống tệp để chỉ tải các định nghĩa công cụ mà nó cần, thay vì tất cả các công cụ ngay từ đầu |
| **Kết quả Ngữ cảnh Hiệu quả** | Dữ liệu được lọc/biến đổi trong môi trường thực thi trước khi trả về cho mô hình |
| **Luồng Kiểm soát Mạnh mẽ** | Các vòng lặp, câu lệnh điều kiện và xử lý lỗi chạy trong mã mà không cần quay vòng qua mô hình |
| **Bảo vệ Quyền riêng tư** | Dữ liệu trung gian (PII, các hồ sơ nhạy cảm) ở lại trong môi trường thực thi; không bao giờ đi vào ngữ cảnh của mô hình |
| **Duy trì Trạng thái** | Các agent có thể lưu kết quả trung gian vào tệp và xây dựng các hàm kỹ năng có thể tái sử dụng |

#### Ví dụ: Lọc các tập dữ liệu lớn

```typescript
// Không thực thi mã — tất cả 10.000 hàng đều đi qua ngữ cảnh
// GỌI CÔNG CỤ: gdrive.getSheet(sheetId: 'abc123')
//   -> trả về 10.000 hàng trong ngữ cảnh

// Với thực thi mã — lọc trong môi trường thực thi
const allRows = await gdrive.getSheet({ sheetId: 'abc123' });
const pendingOrders = allRows.filter(
  row => row["Status"] === 'pending'
);
console.log(`Tìm thấy ${pendingOrders.length} đơn hàng đang chờ xử lý`);
console.log(pendingOrders.slice(0, 5)); // Chỉ 5 hàng được gửi tới mô hình
```

#### Ví dụ: Vòng lặp mà không cần quay vòng qua mô hình

```typescript
// Thăm dò thông báo triển khai — chạy hoàn toàn trong mã
let found = false;
while (!found) {
  const messages = await slack.getChannelHistory({
    channel: 'C123456'
  });
  found = messages.some(
    m => m.text.includes('triển khai hoàn tất')
  );
  if (!found) await new Promise(r => setTimeout(r, 5000));
}
console.log('Đã nhận được thông báo triển khai');
```

### Các Đánh đổi cần Cân nhắc

Thực thi mã cũng mang lại những sự phức tạp riêng. Chạy mã do agent tạo ra yêu cầu:

- Một **môi trường thực thi được sandbox an toàn** với các giới hạn tài nguyên thích hợp.
- **Giám sát và ghi nhật ký** mã đã thực thi.
- Thêm **chi phí hạ tầng** so với việc gọi công cụ trực tiếp.

Các lợi ích — giảm chi phí token, độ trễ thấp hơn, cải thiện việc kết hợp các công cụ — nên được cân nhắc so với các chi phí triển khai này. Đối với các agent chỉ có một vài máy chủ MCP, gọi công cụ trực tiếp có thể đơn giản hơn. Đối với các agent ở quy mô lớn (hàng chục máy chủ, hàng trăm công cụ), thực thi mã là một cải tiến đáng kể.

### MCPorter: Một Runtime cho việc Kết hợp Công cụ MCP

[MCPorter](https://github.com/steipete/mcporter) là một TypeScript runtime và bộ công cụ CLI giúp việc gọi các máy chủ MCP trở nên thiết thực mà không cần mã rập khuôn (boilerplate) — và giúp giảm phình to ngữ cảnh thông qua việc lộ công cụ có chọn lọc và các trình bao bọc được định kiểu.

**Vấn đề nó giải quyết:** Thay vì tải tất cả các định nghĩa công cụ từ tất cả các máy chủ MCP ngay từ đầu, MCPorter cho phép bạn khám phá, kiểm tra và gọi các công cụ cụ thể khi cần — giữ cho ngữ cảnh của bạn luôn tinh gọn.

**Các tính năng chính:**

| Tính năng | Mô tả |
|---------|-------------|
| **Khám phá không cần cấu hình** | Tự động khám phá các máy chủ MCP từ Cursor, Claude, Codex hoặc các cấu hình cục bộ |
| **Client công cụ được định kiểu** | `mcporter emit-ts` tạo ra các interface `.d.ts` và các trình bao bọc sẵn sàng chạy |
| **API có khả năng kết hợp** | `createServerProxy()` hiển thị các công cụ dưới dạng các phương thức camelCase với các trình hỗ trợ `.text()`, `.json()`, `.markdown()` |
| **Tạo CLI** | `mcporter generate-cli` chuyển đổi bất kỳ máy chủ MCP nào thành một CLI độc lập với bộ lọc `--include-tools` / `--exclude-tools` |
| **Ẩn tham số** | Các tham số tùy chọn được ẩn theo mặc định, giúp giảm bớt sự dài dòng của schema |

**Cài đặt:**

```bash
npx mcporter list          # Không cần cài đặt — khám phá máy chủ ngay lập tức
pnpm add mcporter          # Thêm vào một dự án
brew install steipete/tap/mcporter  # macOS thông qua Homebrew
```

**Ví dụ — kết hợp các công cụ trong TypeScript:**

```typescript
import { createRuntime, createServerProxy } from "mcporter";

const runtime = await createRuntime();
const gdrive = createServerProxy(runtime, "google-drive");
const salesforce = createServerProxy(runtime, "salesforce");

// Dữ liệu chảy giữa các công cụ mà không đi qua ngữ cảnh của mô hình
const doc = await gdrive.getDocument({ documentId: "abc123" });
await salesforce.updateRecord({
  objectType: "SalesMeeting",
  recordId: "00Q5f000001abcXYZ",
  data: { Notes: doc.text() }
});
```

**Ví dụ — gọi công cụ qua CLI:**

```bash
# Gọi trực tiếp một công cụ cụ thể
npx mcporter call linear.create_comment issueId:ENG-123 body:'Trông ổn đó!'

# Liệt kê các máy chủ và công cụ có sẵn
npx mcporter list
```

    "github": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    }
  }
}
```

2. **Set environment variables:**
```bash
export GITHUB_TOKEN="your_github_personal_access_token"
```

3. **Test the connection:**
```bash
claude /mcp
```

4. **Use MCP tools:**
```bash
/mcp__github__list_prs
/mcp__github__create_issue "Title" "Description"
```

### Installation for Specific Services

**GitHub MCP:**
```bash
npm install -g @modelcontextprotocol/server-github
```

**Database MCP:**
```bash
npm install -g @modelcontextprotocol/server-database
```

**Filesystem MCP:**
```bash
npm install -g @modelcontextprotocol/server-filesystem
```

**Slack MCP:**
```bash
npm install -g @modelcontextprotocol/server-slack
```

## Troubleshooting

### MCP Server Not Found
```bash
# Verify MCP server is installed
npm list -g @modelcontextprotocol/server-github

# Install if missing
npm install -g @modelcontextprotocol/server-github
```

### Authentication Failed
```bash
# Verify environment variable is set
echo $GITHUB_TOKEN

# Re-export if needed
export GITHUB_TOKEN="your_token"

# Verify token has correct permissions
# Check GitHub token scopes at: https://github.com/settings/tokens
```

### Connection Timeout
- Check network connectivity: `ping api.github.com`
- Verify API endpoint is accessible
- Check rate limits on API
- Try increasing timeout in config
- Check for firewall or proxy issues

### MCP Server Crashes
- Check MCP server logs: `~/.claude/logs/`
- Verify all environment variables are set
- Ensure proper file permissions
- Try reinstalling the MCP server package
- Check for conflicting processes on the same port

## Related Concepts

### Memory vs MCP
- **Memory**: Stores persistent, unchanging data (preferences, context, history)
- **MCP**: Accesses live, changing data (APIs, databases, real-time services)

### When to Use Each
- **Use Memory** for: User preferences, conversation history, learned context
- **Use MCP** for: Current GitHub issues, live database queries, real-time data

### Integration with Other Claude Features
- Combine MCP with Memory for rich context
- Use MCP tools in prompts for better reasoning
- Leverage multiple MCPs for complex workflows

## Additional Resources

- [Official MCP Documentation](https://code.claude.com/docs/en/mcp)
- [MCP Protocol Specification](https://modelcontextprotocol.io/specification)
- [MCP GitHub Repository](https://github.com/modelcontextprotocol/servers)
- [Available MCP Servers](https://github.com/modelcontextprotocol/servers)
- [MCPorter](https://github.com/steipete/mcporter) — TypeScript runtime & CLI for calling MCP servers without boilerplate
- [Code Execution with MCP](https://www.anthropic.com/engineering/code-execution-with-mcp) — Anthropic's engineering blog on solving context bloat
- [Claude Code CLI Reference](https://code.claude.com/docs/en/cli-reference)
- [Claude API Documentation](https://docs.anthropic.com)
