/*
Project: TED Talks Analysis
File: 01_profiling_cleaning_ted_talks.sql
Purpose:
- Thực hiện data profiling cơ bản
- Làm sạch và chuẩn hóa dữ liệu TED Talks
- Chuẩn bị dữ liệu cho bước enrichment & visualization

Dataset đặc điểm:
- Dữ liệu khá sạch (scraped từ TED)
- Ít missing, ít lỗi logic
→ Mục tiêu: kiểm tra + chuẩn hóa, KHÔNG xử lý phức tạp

Final output:
- View: VW_TED_TALKS_CLEAN
*/

--------------------------------------------------
-- 1. DATA PROFILING – QUICK CHECK
--------------------------------------------------

-- 1.1 Kiểm tra số lượng bản ghi
SELECT COUNT(*) AS total_records FROM [data];
-- Insight: 5440 bản ghi

-- 1.2 Kiểm tra trùng title
SELECT title, COUNT(*) AS cnt
FROM [data]
GROUP BY title
HAVING COUNT(*) > 1;
-- Insight: Không phát hiện title trùng

-- 1.3 Kiểm tra khoảng thời gian
SELECT 
    MIN(CAST('01 ' + [date] AS DATE)) AS min_date,
    MAX(CAST('01 ' + [date] AS DATE)) AS max_date
FROM [data];
-- Insight: Dữ liệu trải dài từ 1970 đến 2022 

-- 1.4 Kiểm tra phân bố views
SELECT views, COUNT(*) 
FROM [data]
GROUP BY views
ORDER BY views DESC;
-- Insight: Không có giá trị âm hoặc 0 → hợp lý

-- 1.5 Kiểm tra phân bố likes
SELECT likes, COUNT(*)
FROM [data]
GROUP BY likes
ORDER BY likes DESC;
-- Insight: Likes tương quan với views, không phát hiện bất thường

--------------------------------------------------
-- 2. DATA CLEANING & STANDARDIZATION
--------------------------------------------------

/*
Chiến lược làm sạch:
- Không drop dữ liệu nếu không cần thiết
- Chỉ chuẩn hóa kiểu dữ liệu & loại bỏ record thiếu thông tin quan trọng
*/

CREATE OR ALTER VIEW VW_TED_TALKS_CLEAN AS

WITH cast_type_and_rename AS (
    SELECT
        title AS ted_talks_title,
        author AS speaker,
        CAST('01 ' + [date] AS DATE) AS talk_date,
        CAST(views AS BIGINT) AS total_views,
        CAST(likes AS INT) AS total_likes,
        link
    FROM [data]
    WHERE
        [date] IS NOT NULL
        AND views IS NOT NULL
)

/* Final clean output */
SELECT
    ted_talks_title,
    speaker,
    talk_date,
    total_views,
    total_likes,
    link
FROM cast_type_and_rename;

SELECT * FROM VW_TED_TALKS_CLEAN


