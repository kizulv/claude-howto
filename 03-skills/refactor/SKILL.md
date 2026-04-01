---
name: code-refactor
description: Tái cấu trúc mã nguồn một cách hệ thống dựa trên phương pháp luận của Martin Fowler. Sử dụng khi người dùng yêu cầu tái cấu trúc mã nguồn, cải thiện cấu trúc mã, giảm nợ kỹ thuật, dọn dẹp mã nguồn cũ, loại bỏ các "mùi" mã nguồn (code smells), hoặc cải thiện khả năng bảo trì. Kỹ năng này hướng dẫn thực hiện qua cách tiếp cận theo từng giai đoạn gồm nghiên cứu, lập kế hoạch và triển khai tăng dần an toàn.
---

# Kỹ năng Tái cấu trúc Mã nguồn (Code Refactoring Skill)

Một cách tiếp cận hệ thống để tái cấu trúc mã nguồn dựa trên cuốn sách *Refactoring: Improving the Design of Existing Code* (Ấn bản lần 2) của Martin Fowler. Kỹ năng này nhấn mạnh vào các thay đổi nhỏ, tăng dần và an toàn được hỗ trợ bởi kiểm thử (tests).

> "Tái cấu trúc là quá trình thay đổi một hệ thống phần mềm theo cách không làm thay đổi hành vi bên ngoài của mã nguồn nhưng lại cải thiện cấu trúc bên trong của nó." — Martin Fowler

## Các nguyên tắc cốt lõi (Core Principles)

1. **Bảo toàn hành vi (Behavior Preservation)**: Hành vi bên ngoài phải không đổi.
2. **Các bước nhỏ (Small Steps)**: Thực hiện những thay đổi cực nhỏ, có thể kiểm thử được.
3. **Hướng kiểm thử (Test-Driven)**: Kiểm thử là tấm lưới an toàn.
4. **Liên tục (Continuous)**: Tái cấu trúc là việc đang diễn ra, không phải sự kiện một lần.
5. **Cộng tác (Collaborative)**: Yêu cầu sự phê duyệt của người dùng tại mỗi giai đoạn.

## Tổng quan quy trình (Workflow Overview)

```
Giai đoạn 1: Nghiên cứu & Phân tích
    ↓
Giai đoạn 2: Đánh giá độ bao phủ kiểm thử
    ↓
Giai đoạn 3: Nhận diện "Mùi" mã nguồn (Code Smell)
    ↓
Giai đoạn 4: Tạo kế hoạch tái cấu trúc
    ↓
Giai đoạn 5: Triển khai tăng dần
    ↓
Giai đoạn 6: Review & Lặp lại
```

---

## Giai đoạn 1: Nghiên cứu & Phân tích (Research & Analysis)

### Mục tiêu
- Hiểu cấu trúc và mục đích của mã nguồn.
- Xác định phạm vi tái cấu trúc.
- Thu thập ngữ cảnh về các yêu cầu nghiệp vụ.

### Các câu hỏi cần đặt cho Người dùng
Trước khi bắt đầu, hãy làm rõ:

1. **Phạm vi**: Những tệp/module/hàm nào cần tái cấu trúc?
2. **Mục tiêu**: Bạn đang cố gắng giải quyết vấn đề gì? (khả năng đọc, hiệu năng, khả năng bảo trì)
3. **Ràng buộc**: Có khu vực nào KHÔNG được phép thay đổi không?
4. **Áp lực thời gian**: Việc này có đang chặn công việc khác không?
5. **Trạng thái kiểm thử**: Đã có các bản kiểm thử chưa? Chúng có đang chạy thành công (pass) không?

### Hành động (Actions)
- [ ] Đọc và hiểu mã nguồn mục tiêu.
- [ ] Xác định các phụ thuộc (dependencies) và tích hợp.
- [ ] Ghi lại kiến trúc hiện tại.
- [ ] Ghi chú bất kỳ dấu hiệu nợ kỹ thuật hiện có nào (TODO, FIXME).

### Đầu ra (Output)
Trình bày các phát hiện cho người dùng:
- Tóm tắt cấu trúc mã nguồn.
- Các khu vực có vấn đề đã xác định.
- Các khuyến nghị ban đầu.
- **Yêu cầu phê duyệt để tiếp tục**.

---

## Giai đoạn 2: Đánh giá độ bao phủ kiểm thử (Test Coverage Assessment)

### Tại sao kiểm thử lại quan trọng
> "Tái cấu trúc mà không có kiểm thử giống như lái xe mà không thắt dây an toàn." — Martin Fowler

Kiểm thử là **yếu tố then chốt** để tái cấu trúc an toàn. Không có chúng, bạn có nguy cơ tạo ra lỗi (bugs).

### Các bước đánh giá

1. **Kiểm tra các bản kiểm thử hiện có**
   ```bash
   # Tìm các tệp kiểm thử
   find . -name "*test*" -o -name "*spec*" | head -20
   ```

2. **Chạy các bản kiểm thử hiện có**
   ```bash
   # JavaScript/TypeScript
   npm test

   # Python
   pytest -v

   # Java
   mvn test
   ```

3. **Kiểm tra độ bao phủ (nếu có)**
   ```bash
   # JavaScript
   npm run test:coverage

   # Python
   pytest --cov=.
   ```

### Điểm quyết định: Hỏi Người dùng

**Nếu kiểm thử đã tồn tại và chạy thành công:**
- Chuyển sang Giai đoạn 3.

**Nếu thiếu kiểm thử hoặc kiểm thử không đầy đủ:**
Trình bày các lựa chọn:
1. Viết kiểm thử trước (khuyến nghị).
2. Thêm kiểm thử dần dần trong quá trình tái cấu trúc.
3. Tiếp tục mà không có kiểm thử (rủi ro - yêu cầu người dùng xác nhận).

**Nếu kiểm thử đang thất bại (fail):**
- DỪNG LẠI. Sửa các bản kiểm thử bị thất bại trước khi tái cấu trúc.
- Hỏi người dùng: Chúng ta có nên sửa kiểm thử trước không?

### Hướng dẫn viết kiểm thử (nếu cần)

Đối với mỗi hàm đang được tái cấu trúc, hãy đảm bảo các bản kiểm thử bao phủ:
- Luồng thông thường (Happy path - hoạt động bình thường)
- Các trường hợp biên (Edge cases - đầu vào trống, null, ranh giới)
- Các kịch bản lỗi (đầu vào không hợp lệ, ngoại lệ)

Sử dụng chu trình "red-green-refactor":
1. Viết bản kiểm thử thất bại (red)
2. Làm cho nó vượt qua (green)
3. Tái cấu trúc (refactor)

---

## Giai đoạn 3: Nhận diện "Mùi" mã nguồn (Code Smell Identification)

### "Mùi" mã nguồn là gì?
Là các triệu chứng của những vấn đề sâu hơn trong mã nguồn. Chúng không phải là lỗi (bugs), mà là các dấu hiệu cho thấy mã nguồn có thể được cải thiện.

### Các loại Mùi mã nguồn phổ biến cần kiểm tra

Xem tệp [references/code-smells.md](references/code-smells.md) để biết danh mục đầy đủ.

#### Tham khảo nhanh

| Mùi (Smell) | Dấu hiệu | Tác động |
|-------|-------|--------|
| **Hàm quá dài (Long Method)** | Hàm > 30-50 dòng | Khó hiểu, khó kiểm thử, khó bảo trì |
| **Mã bị lặp (Duplicated Code)** | Cùng một logic ở nhiều nơi | Cần sửa lỗi ở nhiều vị trí |
| **Lớp quá lớn (Large Class)** | Lớp có quá nhiều trách nhiệm | Vi phạm nguyên tắc Đơn trách nhiệm (Single Responsibility) |
| **Ganh tỵ tính năng (Feature Envy)** | Một hàm sử dụng dữ liệu của lớp khác quá nhiều | Đóng gói kém |
| **Ám ảnh kiểu nguyên thủy (Primitive Obsession)** | Quá lạm dụng các kiểu dữ liệu nguyên thủy thay vì các đối tượng | Thiếu các khái niệm miền (domain concepts) |
| **Danh sách tham số dài** | Các hàm có từ 4 tham số trở lên | Khó gọi chính xác |
| **Nhóm dữ liệu (Data Clumps)** | Các mục dữ liệu luôn xuất hiện cùng nhau | Thiếu sự trừu tượng hóa |
| **Câu lệnh Switch** | Các chuỗi switch/if-else phức tạp | Khó mở rộng |
| **Tính khái quát giả tạo** | Mã nguồn được viết "để phòng hờ" | Phức tạp không cần thiết |
| **Mã chết (Dead Code)** | Mã không bao giờ được sử dụng | Gây nhầm lẫn, gánh nặng bảo trì |

### Các bước phân tích

1. **Phân tích Tự động** (nếu có các script):
   ```bash
   python scripts/detect-smells.py <tên_tệp>
   ```

2. **Review Thủ công**
   - Đi qua mã nguồn một cách hệ thống.
   - Ghi lại từng "mùi" kèm theo vị trí và mức độ nghiêm trọng.
   - Phân loại theo tác động (Nghiêm trọng/Cao/Trung bình/Thấp).

3. **Ưu tiên hóa**
   Tập trung vào các "mùi" mà:
   - Đang chặn việc phát triển hiện tại.
   - Gây ra lỗi hoặc sự nhầm lẫn.
   - Ảnh hưởng đến các luồng mã nguồn hay bị thay đổi nhất.

### Đầu ra: Báo cáo "Mùi" mã nguồn (Smell Report)

Trình bày cho người dùng:
- Danh sách các "mùi" đã xác định kèm theo vị trí.
- Đánh giá mức độ nghiêm trọng cho từng loại.
- Thứ tự ưu tiên khuyến nghị.
- **Yêu cầu phê duyệt về thứ tự ưu tiên**.

---

## Giai đoạn 4: Tạo kế hoạch tái cấu trúc (Refactoring Plan Creation)

### Lựa chọn kỹ thuật tái cấu trúc

Với mỗi "mùi", hãy chọn một kỹ thuật tái cấu trúc thích hợp từ danh mục.

Xem tệp [references/refactoring-catalog.md](references/refactoring-catalog.md) để biết danh sách đầy đủ.

#### Ánh xạ giữa Mùi và Kỹ thuật tái cấu trúc

| Mùi mã nguồn | Kỹ thuật tái cấu trúc khuyến nghị |
|------------|---------------------------|
| Hàm quá dài | Trích xuất Hàm (Extract Method), Thay thế biến tạm bằng Truy vấn (Replace Temp with Query) |
| Mã bị lặp | Trích xuất Hàm, Đẩy hàm lên lớp cha (Pull Up Method), Tạo khuôn mẫu hàm (Form Template Method) |
| Lớp quá lớn | Trích xuất Lớp (Extract Class), Trích xuất Lớp con (Extract Subclass) |
| Ganh tỵ tính năng | Di chuyển Hàm (Move Method), Di chuyển Trường (Move Field) |
| Ám ảnh kiểu nguyên thủy | Thay thế kiểu nguyên thủy bằng Đối tượng, Thay thế mã loại bằng Lớp |
| Danh sách tham số dài | Giới thiệu Đối tượng tham số (Introduce Parameter Object), Bảo toàn toàn bộ đối tượng |
| Nhóm dữ liệu | Trích xuất Lớp, Giới thiệu Đối tượng tham số |
| Câu lệnh Switch | Thay thế điều kiện bằng Đa hình (Polymorphism) |
| Tính khái quát giả tạo | Thu gọn phân cấp (Collapse Hierarchy), Nội dòng hóa lớp (Inline Class), Xóa mã chết |
| Mã chết | Xóa mã chết |

### Cấu trúc Kế hoạch

Sử dụng mẫu tại [templates/refactoring-plan.md](templates/refactoring-plan.md).

Với mỗi kỹ thuật tái cấu trúc:
1. **Mục tiêu**: Mã nguồn nào sẽ thay đổi.
2. **Mùi**: Vấn đề nào đang được giải quyết.
3. **Kỹ thuật**: Kỹ thuật nào sẽ được áp dụng.
4. **Các bước**: Các bước thực hiện cực nhỏ (micro-steps).
5. **Rủi ro**: Những gì có thể sai sót.
6. **Rollback**: Cách khôi phục nếu cần.

### Tiếp cận theo từng giai đoạn

**QUAN TRỌNG**: Thực hiện tái cấu trúc dần dần theo các giai đoạn.

**Giai đoạn A: Thắng nhanh (Quick Wins)** (Rủi ro thấp, giá trị cao)
- Đổi tên biến cho rõ ràng.
- Trích xuất mã bị lặp hiển nhiên.
- Xóa mã chết.

**Giai đoạn B: Cải thiện cấu trúc** (Rủi ro trung bình)
- Trích xuất hàm từ các hàm dài.
- Giới thiệu các đối tượng tham số.
- Di chuyển hàm vào các lớp thích hợp.

**Giai đoạn C: Thay đổi kiến trúc** (Rủi ro cao hơn)
- Thay thế các câu lệnh điều kiện bằng đa hình.
- Trích xuất các lớp mới.
- Áp dụng các mẫu thiết kế (design patterns).

### Điểm quyết định: Trình bày kế hoạch cho Người dùng

Trước khi triển khai:
- Hiển thị kế hoạch tái cấu trúc đầy đủ.
- Giải thích từng giai đoạn và rủi ro của nó.
- Nhận sự phê duyệt rõ ràng cho từng giai đoạn.
- **Hỏi**: "Tôi có nên tiếp tục với Giai đoạn A không?"

---

## Giai đoạn 5: Triển khai tăng dần (Incremental Implementation)

### Quy tắc Vàng
> "Thay đổi → Kiểm thử → Thành công (Green)? → Commit → Bước tiếp theo"

### Nhịp độ Triển khai

Với mỗi bước tái cấu trúc:

1. **Kiểm tra trước (Pre-check)**
   - Các bản kiểm thử đang vượt qua (green).
   - Mã nguồn có thể biên dịch được.

2. **Thực hiện MỘT thay đổi nhỏ**
   - Tuân theo các bước kỹ thuật từ danh mục.
   - Giữ các thay đổi ở mức tối thiểu.

3. **Xác minh (Verify)**
   - Chạy các bản kiểm thử ngay lập tức.
   - Kiểm tra các lỗi biên dịch.

4. **Nếu kiểm thử vượt qua (green)**
   - Commit với thông điệp mô tả rõ ràng.
   - Chuyển sang bước tiếp theo.

5. **Nếu kiểm thử thất bại (red)**
   - DỪNG LẠI ngay lập tức.
   - Hoàn tác (Undo) thay đổi.
   - Phân tích điều gì đã sai.
   - Hỏi người dùng nếu không rõ ràng.

### Chiến lược Commit

Mỗi lần commit nên là:
- **Nguyên tử (Atomic)**: Một thay đổi logic duy nhất.
- **Có thể đảo ngược (Reversible)**: Dễ dàng quay lại phiên bản trước.
- **Mô tả rõ ràng**: Thông điệp commit dễ hiểu.

Ví dụ thông điệp commit:
```
refactor: Trích xuất calculateTotal() từ processOrder()
refactor: Đổi tên 'x' thành 'customerCount' cho rõ ràng
refactor: Xóa hàm validateOldFormat() không còn sử dụng
```

### Báo cáo Tiến độ

Sau mỗi giai đoạn nhỏ, báo cáo cho người dùng:
- Các thay đổi đã thực hiện.
- Kiểm thử vẫn vượt qua chứ?
- Bất kỳ vấn đề nào gặp phải.
- **Hỏi**: "Tiếp tục với nhóm công việc tiếp theo chứ?"

---

## Giai đoạn 6: Review & Lặp lại (Review & Iteration)

### Danh sách kiểm tra sau khi Tái cấu trúc

- [ ] Tất cả các bản kiểm thử đều vượt qua.
- [ ] Không có các cảnh báo/lỗi mới.
- [ ] Mã nguồn biên dịch thành công.
- [ ] Hành vi không đổi (xác minh thủ công).
- [ ] Tài liệu hướng dẫn đã được cập nhật nếu cần.
- [ ] Lịch sử commit sạch sẽ.

### So sánh các chỉ số (Metrics Comparison)

Chạy phân tích độ phức tạp trước và sau khi thực hiện:
```bash
python scripts/analyze-complexity.py <tên_tệp>
```

Trình bày các cải tiến:
- Thay đổi số dòng mã nguồn (LOC).
- Thay đổi độ phức tạp vòng đời (Cyclomatic complexity).
- Thay đổi chỉ số khả năng bảo trì.

### Review từ Người dùng

Trình bày kết quả cuối cùng:
- Tóm tắt tất cả các thay đổi.
- So sánh mã nguồn trước/sau.
- Cải thiện về các chỉ số.
- Các khoản nợ kỹ thuật còn lại.
- **Hỏi**: "Bạn có hài lòng với những thay đổi này không?"

### Các bước tiếp theo

Thảo luận với người dùng:
- Còn "mùi" nào cần xử lý nữa không?
- Lập lịch cho các đợt tái cấu trúc tiếp theo?
- Áp dụng các thay đổi tương tự ở những nơi khác?

---

## Các hướng dẫn quan trọng

### Khi nào nên DỪNG LẠI và Hỏi

Luôn tạm dừng và tham khảo ý kiến người dùng khi:
- Không chắc chắn về logic nghiệp vụ.
- Thay đổi có thể ảnh hưởng đến các API bên ngoài.
- Độ bao phủ kiểm thử không đầy đủ.
- Cần đưa ra quyết định kiến trúc quan trọng.
- Mức độ rủi ro tăng lên.
- Bạn gặp phải sự phức tạp không ngờ tới.

### Các Quy tắc An toàn

1. **Không bao giờ tái cấu trúc mà không có kiểm thử** (trừ khi người dùng chấp nhận rủi ro một cách rõ ràng).
2. **Không bao giờ thực hiện các thay đổi lớn** - hãy chia chúng thành các bước cực nhỏ.
3. **Không bao giờ bỏ qua bước chạy kiểm thử** sau mỗi thay đổi.
4. **Không bao giờ tiếp tục nếu kiểm thử thất bại** - hãy sửa lỗi hoặc rollback trước.
5. **Không bao giờ giả định** - khi nghi ngờ, hãy hỏi.

### Những việc KHÔNG được làm

- Đừng kết hợp tái cấu trúc với việc thêm tính năng mới.
- Đừng tái cấu trúc khi đang có sự cố khẩn cấp trên môi trường production.
- Đừng tái cấu trúc đoạn mã mà bạn không hiểu.
- Đừng thiết kế quá mức (over-engineer) - hãy giữ nó đơn giản.
- Đừng tái cấu trúc mọi thứ cùng một lúc.

---

## Ví dụ Bắt đầu Nhanh (Quick Start Example)

### Kịch bản: Hàm quá dài với việc lặp lại mã nguồn

**Trước:**
```javascript
function processOrder(order) {
  // 150 dòng mã nguồn với:
  // - Logic xác thực bị lặp lại
  // - Các tính toán nội dòng (inline)
  // - Nhiều trách nhiệm hỗn hợp
}
```

**Các bước tái cấu trúc:**

1. **Đảm bảo đã có các bản kiểm thử** cho `processOrder()`.
2. **Trích xuất** logic xác thực vào hàm `validateOrder()`.
3. **Kiểm thử** - kết quả phải vượt qua (pass).
4. **Trích xuất** tính toán vào hàm `calculateOrderTotal()`.
5. **Kiểm thử** - kết quả phải vượt qua.
6. **Trích xuất** thông báo vào hàm `notifyCustomer()`.
7. **Kiểm thử** - kết quả phải vượt qua.
8. **Review** - `processOrder()` bây giờ chỉ điều phối 3 hàm con rõ ràng.

**Sau:**
```javascript
function processOrder(order) {
  validateOrder(order);
  const total = calculateOrderTotal(order);
  notifyCustomer(order, total);
  return { order, total };
}
```

---

## Tham chiếu

- [Danh mục "Mùi" mã nguồn](references/code-smells.md) - Danh sách đầy đủ.
- [Danh mục Kỹ thuật tái cấu trúc](references/refactoring-catalog.md) - Các kỹ thuật chi tiết.
- [Mẫu Kế hoạch tái cấu trúc](templates/refactoring-plan.md) - Mẫu lập kế hoạch.

## Các script hỗ trợ

- `scripts/analyze-complexity.py` - Phân tích các chỉ số độ phức tạp.
- `scripts/detect-smells.py` - Tự động nhận diện "mùi" mã nguồn.

## Lịch sử Phiên bản

- v1.0.0 (2025-01-15): Phiên bản đầu tiên với phương pháp luận của Fowler, tiếp cận theo giai đoạn và các điểm tham vấn người dùng.
