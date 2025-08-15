CREATE OR REPLACE TABLE `mandiri-sekuritas-469009.users_dataset.transaction_user_card_detail` AS
SELECT
  t.id,
  t.date,
  SAFE_CAST(t.amount AS FLOAT64) AS amount,
  t.card_id,
  t.client_id AS user_id,

  -- Card Info
  c.card_type,
  c.credit_limit,
  c.expires,

  -- User Info
  u.gender,
  u.current_age AS age,
  u.yearly_income AS income,
  u.credit_score
  
FROM `mandiri-sekuritas-469009.users_dataset.transactions_data` t
LEFT JOIN `mandiri-sekuritas-469009.users_dataset.cards_data` c ON t.card_id = c.client_id
LEFT JOIN `mandiri-sekuritas-469009.users_dataset.users_data` u ON t.client_id = u.id
WHERE t.amount IS NOT NULL AND SAFE_CAST(t.amount AS FLOAT64) > 0
