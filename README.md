# 📊 TED Talks: Performance & Engagement Analytics

## 📝 Project Overview
Dự án này thực hiện phân tích chuyên sâu trên tập dữ liệu hơn **5,400 bài diễn thuyết TED Talks** để khám phá các yếu tố tạo nên sự thành công của nội dung. Thay vì chỉ báo cáo lượt xem, dự án đi sâu vào phân tích **Chất lượng tương tác (Engagement Quality)** để tìm ra những nội dung thực sự có giá trị.

## 🛠️ Tech Stack & Tools
* **Database:** SQL Server (T-SQL) - Dọn dẹp và làm giàu dữ liệu (Data Enrichment).
* **Visualization:** Power BI - Xây dựng Dashboard kể chuyện bằng dữ liệu (Data Storytelling).
* **IDE:** DBeaver - Thực thi truy vấn SQL.
* **Dataset:** TED Talks Dataset (Kaggle).

## 🏗️ Data Processing Pipeline

### 1. Data Cleaning & Standardization
* Chuyển đổi định dạng ngày tháng từ chuỗi văn bản "Month Year" sang kiểu `DATE` chuẩn bằng cách chuẩn hóa ngày đầu tháng (01).
* Xử lý các giá trị khuyết và ép kiểu dữ liệu cho các cột `Views` và `Likes` để đảm bảo tính chính xác cho các hàm tính toán.

### 2. Data Enrichment (Kỹ thuật SQL Nâng cao)
Sử dụng **CTEs** và **Window Functions** để tạo ra các chiều phân tích mới:
* **Engagement Quality Index:** Tính toán tỷ lệ `view_like_ratio = Total Views / Total Likes`. Tỷ lệ này càng thấp minh chứng cho nội dung có giá trị tác động cao hơn.
* **Popularity Segmentation:** Phân khúc bài talk thành 5 cấp độ (Viral, Very Popular, Popular, Normal, Low) bằng hàm `CASE WHEN`.
* **Speaker Performance Ranking:** Sử dụng `DENSE_RANK()` để xếp hạng diễn giả theo lượt xem và số lượng bài nói.

## 📊 Dashboard Insights
Dashboard gồm 3 trang phân tích chuyên sâu:

### Trang 1: Overview & Performance Analysis
![Page 1](Screenshots/image_b99701.png)
* Phác họa bức tranh toàn cảnh về 11 tỷ lượt xem của hệ sinh thái TED và xu hướng bùng nổ nội dung từ năm 2000.

### Trang 2: Speaker & Engagement Analysis
![Page 2](Screenshots/image_b9971c.png)
* Phân tích sự đối lập giữa diễn giả có số lượng bài nói lớn và diễn giả có tầm ảnh hưởng đột phá trên từng nội dung.

### Trang 3: Quantity vs. Quality (Deep-Dive)
![Page 3](Screenshots/image_ba805f.png)
* Sử dụng biểu đồ Scatter Chart để tìm ra các "Hidden Gems" – những bài nói có lượt xem trung bình nhưng nhận được tỷ lệ ủng hộ cực cao.

## 💡 Business Impact & Application
* Xác định được các xu hướng nội dung đang được khán giả quan tâm nhất qua các năm.
* Cung cấp bộ lọc hiệu quả để tối ưu hóa chiến lược tái quảng bá (Re-promotion) cho các nội dung chất lượng cao nhưng chưa đạt lượt xem Viral.

---

**Contact Information:**
* **LinkedIn:** [Link LinkedIn của Sói]
* **Email:** [Email của Sói]
