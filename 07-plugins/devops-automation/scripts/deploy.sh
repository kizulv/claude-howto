#!/bin/bash
set -e

echo "🚀 Bắt đầu triển khai..."

# Tải cấu hình môi trường
ENV=${1:-staging}
echo "📦 Môi trường đích: $ENV"

# Các kiểm tra trước khi triển khai
echo "✓ Đang chạy các kiểm tra trước triển khai..."
npm run lint
npm test

# Build
echo "🔨 Đang build ứng dụng..."
npm run build

# Triển khai
echo "🚢 Đang triển khai lên $ENV..."
kubectl apply -f k8s/$ENV/

# Kiểm tra sức khỏe
echo "🏥 Đang chạy các bài kiểm tra sức khỏe..."
sleep 10
curl -f http://api.$ENV.example.com/health

echo "✅ Triển khai hoàn tất!"
