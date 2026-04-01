#!/usr/bin/env python3
"""
Trình theo dõi sử dụng ngữ cảnh - Theo dõi lượng tiêu thụ token theo từng yêu cầu.

Sử dụng UserPromptSubmit làm hook "pre-message" và Stop làm hook "post-response"
để tính toán sự thay đổi (delta) trong việc sử dụng token cho mỗi yêu cầu.

Phiên bản này sử dụng ước tính dựa trên ký tự (không có phụ thuộc).
Để có độ chính xác tốt hơn, xem context-tracker-tiktoken.py.

Cách dùng:
    Cấu hình cả hai hook để sử dụng cùng một script:
    - UserPromptSubmit: lưu số lượng token hiện tại
    - Stop: tính toán delta và báo cáo mức sử dụng
"""
import json
import os
import sys
import tempfile

# Cấu hình
CONTEXT_LIMIT = 128000  # Cửa sổ ngữ cảnh của Claude (điều chỉnh cho mô hình của bạn)


def get_state_file(session_id: str) -> str:
    """Lấy đường dẫn tệp tạm để lưu trữ số lượng token trước tin nhắn, tách biệt theo phiên."""
    return os.path.join(tempfile.gettempdir(), f"claude-context-{session_id}.json")


def count_tokens_estimate(text: str) -> int:
    """
    Ước tính số lượng token bằng phép xấp xỉ dựa trên ký tự.

    Sử dụng tỷ lệ ~4 ký tự mỗi token, mang lại độ chính xác ~80-90%
    cho văn bản tiếng Anh. Kém chính xác hơn đối với mã nguồn và văn bản không phải tiếng Anh.
    """
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
    current_tokens = count_tokens_estimate(transcript_content)

    # Lưu vào tệp tạm để so sánh sau
    state_file = get_state_file(session_id)
    with open(state_file, "w") as f:
        json.dump({"pre_tokens": current_tokens}, f)


def handle_stop(data: dict) -> None:
    """Hook sau phản hồi: Tính toán và báo cáo sự thay đổi token."""
    session_id = data.get("session_id", "unknown")
    transcript_path = data.get("transcript_path", "")

    transcript_content = read_transcript(transcript_path)
    current_tokens = count_tokens_estimate(transcript_content)

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

    # Báo cáo việc sử dụng (stderr để không can thiệp vào đầu ra của hook)
    print(
        f"Ngữ cảnh (ước tính): ~{current_tokens:,} token "
        f"({percentage:.1f}% đã dùng, còn ~{remaining:,})",
        file=sys.stderr,
    )
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
