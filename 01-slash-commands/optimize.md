---
description: Phân tích mã nguồn để tìm các vấn đề về hiệu năng và đề xuất tối ưu hóa
---

# Tối ưu hóa mã nguồn (Code Optimization)

Rà soát mã nguồn được cung cấp để tìm các vấn đề sau theo thứ tự ưu tiên:

1. **Nghẽn hiệu năng (Performance bottlenecks)** - xác định các hoạt động O(n²), các vòng lặp thiếu hiệu quả
2. **Rò rỉ bộ nhớ (Memory leaks)** - tìm các tài nguyên chưa được giải phóng, các tham chiếu vòng
3. **Cải tiến thuật toán (Algorithm improvements)** - đề xuất các thuật toán hoặc cấu trúc dữ liệu tốt hơn
4. **Cơ hội ghi nhớ đệm (Caching opportunities)** - xác định các phép tính lặp lại
5. **Vấn đề đồng thời (Concurrency issues)** - tìm các tình trạng tranh chấp (race conditions) hoặc các vấn đề về luồng (threading)

Định dạng câu trả lời của bạn với:
- Mức độ nghiêm trọng của vấn đề (Nghiêm trọng/Cao/Trung bình/Thấp)
- Vị trí trong mã nguồn
- Giải thích
- Cách khắc phục được khuyến nghị kèm theo ví dụ mã nguồn
