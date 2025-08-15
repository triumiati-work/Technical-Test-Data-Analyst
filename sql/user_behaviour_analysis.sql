CREATE OR REPLACE VIEW `mandiri-sekuritas-469009.users_dataset.user_behavior_exec_view` AS

WITH filtered_data AS (
  SELECT
    DATE_TRUNC(DATE(date), MONTH) AS transaction_month_date,
    FORMAT_DATE('%Y-%m', DATE(date)) AS transaction_month_label,
    EXTRACT(YEAR FROM DATE(date)) AS transaction_year,

    CASE
      WHEN age < 25 THEN 'Under 25'
      WHEN age BETWEEN 25 AND 34 THEN '25-34'
      WHEN age BETWEEN 35 AND 44 THEN '35-44'
      WHEN age BETWEEN 45 AND 54 THEN '45-54'
      ELSE '55+'
    END AS age_group,

    IFNULL(card_type, 'Unknown') AS card_type_label,

    CASE
      WHEN credit_score >= 750 THEN 'Excellent'
      WHEN credit_score >= 650 THEN 'Good'
      WHEN credit_score >= 550 THEN 'Fair'
      ELSE 'Poor'
    END AS credit_score_group,

    amount,
    user_id
  FROM `mandiri-sekuritas-469009.users_dataset.transaction_user_card_detail`
  WHERE amount IS NOT NULL AND amount > 0
)

SELECT
  transaction_month_date,
  transaction_month_label,
  transaction_year,
  age_group,
  card_type_label,
  credit_score_group,
  COUNT(*) AS total_transactions,
  ROUND(SUM(amount), 2) AS total_amount,
  ROUND(AVG(amount), 2) AS avg_amount,
  COUNT(DISTINCT user_id) AS unique_users
FROM filtered_data
GROUP BY
  transaction_month_date,
  transaction_month_label,
  transaction_year,
  age_group,
  card_type_label,
  credit_score_group
ORDER BY transaction_month_date DESC, total_amount DESC;
