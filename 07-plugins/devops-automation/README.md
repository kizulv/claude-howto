<picture>
  <source media="(prefers-color-scheme: dark)" srcset="../../resources/logos/claude-howto-logo-dark.svg">
  <img alt="Claude How To" src="../../resources/logos/claude-howto-logo.svg">
</picture>

# Plugin Tự động hóa DevOps (DevOps Automation)

Tự động hóa DevOps hoàn chỉnh cho việc triển khai (deployment), giám sát và phản ứng sự cố (incident response).

## Các tính năng

✅ Tự động hóa triển khai
✅ Quy trình Rollback (Hoàn tác)
✅ Giám sát sức khỏe hệ thống
✅ Quy trình phản ứng sự cố
✅ Tích hợp Kubernetes

## Cài đặt

```bash
/plugin install devops-automation
```

## Thành phần bao gồm

### Lệnh Slash (Slash Commands)
- `/deploy` - Triển khai lên production hoặc staging
- `/rollback` - Hoàn tác về phiên bản trước đó
- `/status` - Kiểm tra sức khỏe hệ thống
- `/incident` - Xử lý các sự cố production

### Subagent
- `deployment-specialist` - Các hoạt động triển khai
- `incident-commander` - Điều phối sự cố
- `alert-analyzer` - Phân tích sức khỏe hệ thống

### MCP Server
- Tích hợp Kubernetes

### Script
- `deploy.sh` - Tự động hóa triển khai
- `rollback.sh` - Tự động hóa hoàn tác
- `health-check.sh` - Các tiện ích kiểm tra sức khỏe

### Hook
- `pre-deploy.js` - Xác thực trước khi triển khai
- `post-deploy.js` - Các tác vụ sau khi triển khai

## Cách dùng

### Triển khai lên Staging
```
/deploy staging
```

### Triển khai lên Production
```
/deploy production
```

### Hoàn tác (Rollback)
```
/rollback production
```

### Kiểm tra trạng thái
```
/status
```

### Xử lý sự cố
```
/incident
```

## Yêu cầu

- Claude Code 1.0+
- Kubernetes CLI (kubectl)
- Đã cấu hình quyền truy cập cụm máy chủ (cluster)

## Cấu hình

Thiết lập cấu hình Kubernetes của bạn:
```bash
export KUBECONFIG=~/.kube/config
```

## Ví dụ quy trình làm việc

```
Người dùng: /deploy production

Claude:
1. Chạy hook pre-deploy (xác thực kubectl, kết nối cluster)
2. Ủy thác cho subagent deployment-specialist
3. Chạy script deploy.sh
4. Giám sát tiến độ triển khai qua Kubernetes MCP
5. Chạy hook post-deploy (đợi các pod sẵn sàng, chạy smoke test)
6. Cung cấp tóm tắt triển khai

Kết quả:
✅ Triển khai hoàn tất
📦 Phiên bản: v2.1.0
🚀 Pods: 3/3 ready
⏱️  Thời gian: 2m 34s
```
