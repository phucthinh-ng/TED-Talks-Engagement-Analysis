/*
Project: TED Talks Analysis
File: 02_data_enrichment_ted_talks.sql
Purpose:
- Enrich dữ liệu TED Talks để phục vụ phân tích & visualization
Input:
- VW_TED_TALKS_CLEAN
Output:
- VW_TED_TALKS_ENRICHED
*/

CREATE OR ALTER VIEW VW_TED_TALKS_ENRICHED AS

-- Thêm thời gian
WITH time_enrich AS (
    SELECT
        *,
        YEAR(talk_date) AS talk_year,
        MONTH(talk_date) AS talk_month
    FROM VW_TED_TALKS_CLEAN
),

popularity_enrich AS (
    SELECT
        *,
        -- Tỷ lệ view / like: càng thấp càng nhiều tương tác
        CASE
            WHEN total_likes = 0 OR total_likes IS NULL THEN NULL
            ELSE CAST(total_views AS FLOAT) / total_likes
        END AS view_like_ratio,

        -- Phân nhóm độ phổ biến
        CASE
            WHEN total_views >= 10000000 THEN 'Viral'
            WHEN total_views >= 1000000 THEN 'Very Popular'
            WHEN total_views >= 500000 THEN 'Popular'
            WHEN total_views >= 100000 THEN 'Normal'
            ELSE 'Low'
        END AS popularity_bucket
    FROM time_enrich
),
speaker_enrich AS (
    SELECT
        *,
        -- Số talk mỗi speaker
        COUNT(*) OVER (PARTITION BY speaker) AS speaker_talk_count,

        -- Tổng views của speaker
        SUM(total_views) OVER (PARTITION BY speaker) AS speaker_total_views
    FROM popularity_enrich
),
ranking_enrich AS (
    SELECT
        *,
        -- Rank talk theo views (toàn bộ dataset)
        DENSE_RANK() OVER (ORDER BY total_views DESC) AS talk_rank_by_views,

        -- Rank speaker theo tổng views
        DENSE_RANK() OVER (ORDER BY speaker_total_views DESC) AS speaker_rank_by_views
    FROM speaker_enrich
)

SELECT
    ted_talks_title,
    speaker,
    talk_date,
    talk_year,
    talk_month,
    total_views,
    total_likes,
    view_like_ratio,
    popularity_bucket,
    speaker_talk_count,
    speaker_total_views,
    talk_rank_by_views,
    speaker_rank_by_views,
    link
FROM ranking_enrich;

SELECT *
FROM VW_TED_TALKS_ENRICHED
