---
name: blog-draft
description: Soạn thảo một bài viết blog từ ý tưởng và tài nguyên. Sử dụng khi người dùng muốn viết bài blog, tạo nội dung từ nghiên cứu hoặc soạn thảo bài báo. Hướng dẫn thông qua các bước nghiên cứu, brainstorm, lập dàn ý và soạn thảo lặp lại với kiểm soát phiên bản.
---

## Nhập liệu từ Người dùng (User Input)

```text
$ARGUMENTS
```

Bạn **PHẢI** xem xét nội dung nhập liệu của người dùng trước khi tiếp tục. Người dùng nên cung cấp:
- **Ý tưởng/Chủ đề**: Khái niệm hoặc chủ đề chính cho bài viết blog
- **Tài nguyên**: URL, tệp hoặc tham chiếu để nghiên cứu (tùy chọn nhưng được khuyến nghị)
- **Đối tượng mục tiêu**: Bài viết dành cho ai (tùy chọn)
- **Tông điệu/Phong cách**: Trang trọng, thân mật, kỹ thuật, v.v. (tùy chọn)

**QUAN TRỌNG**: Nếu người dùng yêu cầu cập nhật cho một **bài viết blog đã có**, hãy bỏ qua các bước 0-8 và bắt đầu trực tiếp tại **Bước 9**. Đọc các tệp bản thảo hiện có trước, sau đó tiếp tục quá trình lặp lại.

## Luồng thực thi (Execution Flow)

Thực hiện các bước này theo thứ tự. **Không bỏ qua các bước hoặc tiếp tục mà không có sự phê duyệt của người dùng tại các vị trị được chỉ định.**

### Bước 0: Tạo Thư mục Dự án

1. Tạo tên thư mục theo định dạng: `YYYY-MM-DD-ten-chu-de-ngan`
   - Sử dụng ngày hôm nay
   - Tạo một slug ngắn, thân thiện với URL từ chủ đề (chữ thường, dấu gạch ngang, tối đa 5 từ)

2. Tạo cấu trúc thư mục:
   ```
   blog-posts/
   └── YYYY-MM-DD-ten-chu-de-ngan/
       └── resources/
   ```

3. Xác nhận việc tạo thư mục với người dùng trước khi tiếp tục.

### Bước 1: Nghiên cứu & Thu thập Tài nguyên

1. Tạo thư mục con `resources/` trong thư mục bài viết blog

2. Với mỗi tài nguyên được cung cấp:
   - **URL**: Truy cập và lưu thông tin chính vào `resources/` dưới dạng các tệp markdown
   - **Tệp**: Đọc và tóm tắt trong `resources/`
   - **Chủ đề**: Sử dụng tìm kiếm web để thu thập thông tin mới nhất

3. Với mỗi tài nguyên, tạo một tệp tóm tắt trong `resources/`:
   - `resources/source-1-[ten-ngan].md`
   - `resources/source-2-[ten-ngan].md`
   - v.v.

4. Mỗi bản tóm tắt nên bao gồm:
   ```markdown
   # Nguồn: [Tiêu đề/URL]

   ## Các điểm chính
   - Điểm 1
   - Điểm 2

   ## Trích dẫn/Dữ liệu liên quan
   - Trích dẫn hoặc số liệu thống kê 1
   - Trích dẫn hoặc số liệu thống kê 2

   ## Mối liên hệ với Chủ đề
   Giải thích ngắn gọn về mức độ liên quan
   ```

5. Trình bày tóm tắt nghiên cứu cho người dùng.

### Bước 2: Brainstorm & Làm rõ

1. Dựa trên ý tưởng và các tài nguyên đã nghiên cứu, hãy trình bày:
   - **Các chủ đề chính** được xác định từ nghiên cứu
   - **Các góc tiếp cận tiềm năng** cho bài viết blog
   - **Các điểm chính** cần được đề cập
   - **Các lỗ hổng** thông tin cần làm rõ

2. Đặt các câu hỏi làm rõ:
   - Thông điệp chính bạn muốn người đọc nhận được là gì?
   - Có điểm cụ thể nào từ nghiên cứu mà bạn muốn nhấn mạnh không?
   - Độ dài mục tiêu là bao nhiêu? (ngắn: 500-800 từ, trung bình: 1000-1500, dài: 2000+)
   - Có điểm nào bạn muốn loại trừ không?

3. **Chờ phản hồi của người dùng trước khi tiếp tục.**

### Bước 3: Đề xuất Dàn ý

1. Tạo một dàn ý có cấu trúc bao gồm:

   ```markdown
   # Dàn ý bài viết Blog: [Tiêu đề]

   ## Thông tin Meta
   - **Đối tượng mục tiêu**: [ai]
   - **Tông điệu**: [phong cách]
   - **Độ dài mục tiêu**: [số lượng từ]
   - **Thông điệp chính**: [thông điệp cốt lõi]

   ## Cấu trúc đề xuất

   ### Mở đầu/Hook
   - Ý tưởng câu dẫn (hook)
   - Thiết lập ngữ cảnh
   - Tuyên bố chủ đề (thesis statement)

   ### Phần 1: [Tiêu đề]
   - Điểm chính A
   - Điểm chính B
   - Bằng chứng hỗ trợ từ [nguồn]

   ### Phần 2: [Tiêu đề]
   - Điểm chính A
   - Điểm chính B

   [Tiếp tục cho tất cả các phần...]

   ### Kết luận
   - Tóm tắt các điểm chính
   - Lời kêu gọi hành động (Call to action) hoặc suy nghĩ cuối cùng

   ## Các nguồn cần trích dẫn
   - Nguồn 1
   - Nguồn 2
   ```

2. Trình bày dàn ý cho người dùng và **yêu cầu phê duyệt hoặc sửa đổi**.

### Bước 4: Lưu Dàn ý đã phê duyệt

1. Sau khi người dùng phê duyệt dàn ý, hãy lưu nó vào tệp `OUTLINE.md` trong thư mục bài viết blog.

2. Xác nhận rằng dàn ý đã được lưu.

### Bước 5: Commit Dàn ý (nếu đang ở trong repo git)

1. Kiểm tra xem thư mục hiện tại có phải là một kho lưu trữ git không.

2. Nếu có:
   - Stage các tệp mới: thư mục bài viết blog, tài nguyên và OUTLINE.md
   - Tạo commit với thông điệp: `docs: Add outline for blog post - [topic-name]`
   - Push lên remote

3. Nếu không phải repo git, bỏ qua bước này và thông báo cho người dùng.

### Bước 6: Viết Bản thảo

1. Dựa trên dàn ý đã phê duyệt, viết toàn bộ bản thảo bài viết blog.

2. Tuân thủ chính xác cấu trúc từ `OUTLINE.md`.

3. Bao gồm:
   - Phần giới thiệu hấp dẫn với câu dẫn (hook)
   - Các tiêu đề phần rõ ràng
   - Bằng chứng và ví dụ hỗ trợ từ nghiên cứu
   - Sự chuyển tiếp mượt mà giữa các phần
   - Kết luận mạnh mẽ với thông điệp cốt lõi
   - **Trích dẫn**: Tất cả các so sánh, số liệu thống kê, điểm dữ liệu và các tuyên bố thực tế PHẢI trích dẫn nguồn gốc

4. Lưu bản thảo dưới tên `draft-v0.1.md` trong thư mục bài viết blog.

5. Định dạng:
   ```markdown
   # [Tiêu đề Bài viết Blog]

   *[Tùy chọn: tiêu đề phụ hoặc tagline]*

   [Nội dung đầy đủ với các trích dẫn nội dòng...]

   ---

   ## Tài liệu tham khảo
   - [1] Tiêu đề Nguồn 1 - URL hoặc Trích dẫn
   - [2] Tiêu đề Nguồn 2 - URL hoặc Trích dẫn
   - [3] Tiêu đề Nguồn 3 - URL hoặc Trích dẫn
   ```

6. **Yêu cầu về Trích dẫn**:
   - Mọi điểm dữ liệu, số liệu thống kê hoặc so sánh PHẢI có trích dẫn nội dòng
   - Sử dụng tham chiếu đánh số [1], [2], v.v., hoặc trích dẫn theo tên [Tên Nguồn]
   - Liên kết các trích dẫn với phần Tài liệu tham khảo ở cuối bài
   - Ví dụ: "Các nghiên cứu cho thấy 65% lập trình viên thích TypeScript [1]"
   - Ví dụ: "React vượt trội hơn Vue về tốc độ render 20% [React Benchmarks 2024]"

### Bước 7: Commit Bản thảo (nếu ở trong repo git)

1. Kiểm tra xem có đang ở trong kho lưu trữ git không.

2. Nếu có:
   - Stage tệp bản thảo
   - Tạo commit với thông điệp: `docs: Add draft v0.1 for blog post - [topic-name]`
   - Push lên remote

3. Nếu không phải repo git, bỏ qua và thông báo cho người dùng.

### Bước 8: Trình bày Bản thảo để Review

1. Trình bày nội dung bản thảo cho người dùng.

2. Yêu cầu phản hồi:
   - Ấn tượng tổng thể?
   - Các phần cần mở rộng hoặc thu gọn?
   - Cần điều chỉnh tông điệu không?
   - Thông tin còn thiếu?
   - Các chỉnh sửa hoặc viết lại cụ thể?

3. **Chờ phản hồi của người dùng.**

### Bước 9: Lặp lại hoặc Hoàn tất

**Nếu người dùng yêu cầu thay đổi:**
1. Ghi lại tất cả các sửa đổi được yêu cầu
2. Quay lại Bước 6 với các điều chỉnh sau:
   - Tăng số phiên bản (v0.2, v0.3, v.v.)
   - Kết hợp tất cả phản hồi
   - Lưu dưới tên `draft-v[X.Y].md`
   - Lặp lại Bước 7-8

**Nếu người dùng phê duyệt:**
1. Xác nhận phiên bản bản thảo cuối cùng
2. Tùy chọn đổi tên thành `final.md` nếu người dùng yêu cầu
3. Tóm tắt quá trình tạo bài viết blog:
   - Tổng số phiên bản đã tạo
   - Các thay đổi chính giữa các phiên bản
   - Tổng số từ cuối cùng
   - Các tệp đã tạo

## Theo dõi Phiên bản (Version Tracking)

Tất cả các bản thảo được lưu trữ với số phiên bản tăng dần:
- `draft-v0.1.md` - Bản thảo đầu tiên
- `draft-v0.2.md` - Sau vòng phản hồi thứ nhất
- `draft-v0.3.md` - Sau vòng phản hồi thứ hai
- v.v.

Điều này cho phép theo dõi sự tiến hóa của bài viết blog và quay lại phiên bản cũ nếu cần.

## Cấu trúc Tệp Đầu ra

```
blog-posts/
└── YYYY-MM-DD-ten-chu-de/
    ├── resources/
    │   ├── source-1-ten.md
    │   ├── source-2-ten.md
    │   └── ...
    ├── OUTLINE.md
    ├── draft-v0.1.md
    ├── draft-v0.2.md (nếu có các lần lặp)
    └── draft-v0.3.md (nếu có thêm các lần lặp)
```

## Mẹo để đạt Chất lượng cao

- **Câu dẫn (Hook)**: Bắt đầu bằng một câu hỏi, một sự thật đáng ngạc nhiên hoặc một tình huống dễ liên hệ
- **Luồng văn bản (Flow)**: Mỗi đoạn văn nên kết nối mượt mà với đoạn tiếp theo
- **Bằng chứng**: Hỗ trợ các tuyên bố bằng dữ liệu từ nghiên cứu
- **Trích dẫn**: LUÔN LUÔN trích dẫn nguồn cho:
  - Tất cả các số liệu thống kê và điểm dữ liệu (ví dụ: "Theo [Nguồn], 75%...")
  - So sánh giữa các sản phẩm, dịch vụ hoặc cách tiếp cận (ví dụ: "X hoạt động nhanh gấp 2 lần Y [Nguồn]")
  - Các tuyên bố thực tế về xu hướng thị trường, kết quả nghiên cứu hoặc benchmark
  - Sử dụng trích dẫn nội dòng với định dạng: [Tên Nguồn] hoặc [Tác giả, Năm]
- **Giọng văn (Voice)**: Duy trì tông điệu nhất quán xuyên suốt bài viết
- **Độ dài**: Tôn trọng số lượng từ mục tiêu
- **Khả năng đọc**: Sử dụng các đoạn văn ngắn, các điểm gạch đầu dòng khi thích hợp
- **CTA**: Kết thúc bằng một lời kêu gọi hành động rõ ràng hoặc một câu hỏi gợi suy nghĩ

## Ghi chú

- Luôn chờ sự phê duyệt của người dùng tại các điểm kiểm tra đã nêu
- Giữ lại tất cả các phiên bản bản thảo để xem lịch sử
- Sử dụng tìm kiếm web để cập nhật thông tin mới nhất khi các URL được cung cấp
- Nếu tài nguyên không đủ, hãy yêu cầu người dùng thêm hoặc đề xuất nghiên cứu bổ sung
- Điều chỉnh tông điệu dựa trên đối tượng mục tiêu (kỹ thuật, đại chúng, kinh doanh, v.v.)
