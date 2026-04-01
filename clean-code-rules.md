# Quy tắc Clean Code cho việc tạo mã nguồn bằng AI

Các quy tắc này hướng dẫn việc tạo mã nguồn để tạo ra mã có khả năng bảo trì, đạt chất lượng chuyên nghiệp.

## Tên có ý nghĩa
- Sử dụng tên tiết lộ mục đích (intention-revealing names) giải thích tại sao một thứ gì đó tồn tại
- Tránh thông tin sai lệch và các phân biệt vô nghĩa (ví dụ: `data`, `info`, `manager`)
- Sử dụng tên có thể phát âm được, có thể tìm kiếm được
- Tên lớp (Class names): danh từ (ví dụ: `UserAccount`, `PaymentProcessor`)
- Tên phương thức (Method names): động từ (ví dụ: `calculateTotal`, `sendEmail`)
- Tránh bản đồ tư duy (mental mapping) và các ký hiệu mã hóa (Hungarian notation, tiền tố)

## Hàm (Functions)
- Giữ các hàm nhỏ (lý tưởng nhất là < 20 dòng)
- Chỉ làm một việc duy nhất - Nguyên tắc đơn nhiệm (Single Responsibility Principle)
- Một cấp độ trừu tượng cho mỗi hàm
- Giới hạn tham số: lý tưởng từ 0-2, tối đa là 3, tránh các tham số dạng cờ (flag arguments)
- Không có tác dụng phụ (No side effects) - hàm nên làm đúng những gì tên nó mô tả
- Tách biệt các lệnh (thay đổi trạng thái) khỏi các truy vấn (trả về thông tin) - Command Query Separation
- Ưu tiên sử dụng ngoại lệ (exceptions) hơn các mã lỗi (error codes)

## Chú thích (Comments)
- Mã nguồn nên tự giải thích được - tránh chú thích khi có thể
- Chú thích tốt: thông tin pháp lý, cảnh báo, TODO, tài liệu API công khai
- Chú thích xấu: dư thừa, gây hiểu lầm, hoặc giải thích mã nguồn tồi
- Không bao giờ chú thích mã nguồn (comment out) - hãy xóa nó đi (hệ thống quản lý phiên bản sẽ lưu giữ lịch sử)
- Nếu bạn cần một chú thích, hãy cân nhắc việc tái cấu trúc (refactoring) mã nguồn trước

## Định dạng (Formatting)
- Giữ các file nhỏ và tập trung
- Định dạng theo chiều dọc: các khái niệm liên quan nên đặt gần nhau, các dòng trống phân tách các khái niệm
- Định dạng theo chiều ngang: giới hạn độ dài dòng (80-120 ký tự)
- Sử dụng thụt đầu dòng nhất quán và theo phong cách của nhóm
- Nhóm các hàm liên quan lại với nhau

## Đối tượng và Cấu trúc dữ liệu
- Đối tượng (Objects): ẩn dữ liệu đằng sau các lớp trừu tượng, để lộ hành vi thông qua các phương thức
- Cấu trúc dữ liệu (Data structures): để lộ dữ liệu, có rất ít hành vi
- Định luật Demeter (Law of Demeter): chỉ nói chuyện với những "người bạn" trực tiếp, tránh `a.getB().getC().doSomething()`
- Đừng để lộ cấu trúc nội bộ thông qua getters/setters một cách mù quáng

## Xử lý lỗi (Error Handling)
- Sử dụng ngoại lệ, không dùng mã trả về hoặc cờ lỗi
- Viết `try-catch-finally` trước khi mã nguồn có thể thất bại
- Cung cấp ngữ cảnh trong các thông báo ngoại lệ
- Không trả về `null` - trả về tập hợp rỗng hoặc dùng Optional/Maybe
- Không truyền `null` làm tham số

## Lớp (Classes)
- Các lớp nhỏ: được đo bằng trách nhiệm, không phải bằng số dòng
- Nguyên tắc đơn nhiệm (Single Responsibility Principle): chỉ có một lý do để thay đổi
- Độ gắn kết cao (High cohesion): các biến của lớp được sử dụng bởi nhiều phương thức
- Độ phụ thuộc thấp (Low coupling): sự phụ thuộc tối thiểu giữa các lớp
- Nguyên tắc Đóng/Mở (Open/Closed Principle): mở để mở rộng, đóng để sửa đổi

## Thử nghiệm đơn vị (Unit Tests)
- Fast (Nhanh), Independent (Độc lập), Repeatable (Có thể lặp lại), Self-validating (Tự xác thực), Timely (Kịp thời) (F.I.R.S.T.)
- Một assert cho mỗi test (hoặc một khái niệm)
- Chất lượng mã thử nghiệm bằng với chất lượng mã sản phẩm
- Tên test dễ đọc, mô tả những gì đang được thử nghiệm
- Mô hình Arrange-Act-Assert (Chuẩn bị - Hành động - Xác nhận)

## Các nguyên tắc chất lượng mã nguồn
- **DRY (Don't Repeat Yourself)**: Không trùng lặp
- **YAGNI (You Aren't Gonna Need It)**: Đừng xây dựng cho những tương lai giả định
- **KISS (Keep It Simple)**: Tránh sự phức tạp không cần thiết
- **Quy tắc hướng đạo sinh (Boy Scout Rule)**: Để lại mã nguồn sạch hơn lúc bạn tìm thấy nó

## Các "mùi" mã nguồn (Code Smells) cần tránh
- Hàm hoặc lớp quá dài
- Mã nguồn bị trùng lặp
- Mã nguồn "chết" (biến, hàm, tham số không được sử dụng)
- Feature envy (phương thức quan tâm đến lớp khác nhiều hơn lớp hiện tại)
- Inappropriate intimacy (các lớp biết quá nhiều về nhau)
- Danh sách tham số quá dài
- Primitive obsession (lạm dụng các kiểu dữ liệu cơ bản thay vì các đối tượng nhỏ)
- Các câu lệnh Switch/case (cân nhắc đa hình - polymorphism)
- Các trường tạm thời (biến của lớp chỉ thỉnh thoảng được sử dụng)

## Đa luồng (Concurrency)
- Giữ mã nguồn đa luồng tách biệt với mã nguồn khác
- Giới hạn phạm vi của dữ liệu được đồng bộ/khóa (synchronized/locked)
- Sử dụng các tập hợp an toàn đa luồng (thread-safe collections)
- Giữ các phần đồng bộ nhỏ
- Hiểu rõ các mô hình và nguyên tắc thực thi của bạn

## Thiết kế hệ thống (System Design)
- Tách biệt việc xây dựng (construction) khỏi việc sử dụng (use) - dùng dependency injection
- Sử dụng các factory, builder cho việc tạo đối tượng phức tạp
- Lập trình cho các interface, không phải cho các implementation cụ thể
- Ưu tiên sự kết hợp (composition) hơn là kế thừa (inheritance)
- Áp dụng các mẫu thiết kế (design patterns) khi chúng làm đơn giản hóa vấn đề, không phải để thể hiện

## Tái cấu trúc (Refactoring)
- Tái cấu trúc liên tục, không làm theo các đợt lớn
- Luôn có các bài test vượt qua trước và sau khi thực hiện
- Các bước nhỏ: một thay đổi tại một thời điểm
- Các kỹ thuật tái cấu trúc phổ biến: Extract Method (Tách hàm), Rename (Đổi tên), Move (Di chuyển), Inline (Gộp dòng)

## Tài liệu (Documentation)
- Mã nguồn tự giải thích > chú thích > tài liệu bên ngoài
- Các API công khai cần tài liệu rõ ràng
- Bao gồm các ví dụ trong tài liệu
- Giữ tài liệu gần với mã nguồn (lý tưởng nhất là trong mã nguồn)

---

**Triết lý cốt lõi**: Mã nguồn được đọc nhiều gấp 10 lần so với lúc được viết. Hãy tối ưu hóa cho khả năng đọc và khả năng bảo trì, không phải cho sự thông minh.
