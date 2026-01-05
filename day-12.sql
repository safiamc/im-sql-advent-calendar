-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH counts AS (
  SELECT
    DATE(sent_at) AS sent_date,
    sender_id,
    COUNT(*) AS num_messages
  FROM npn_messages
  GROUP BY sent_date, sender_id
),

ranks AS (
  SELECT
  c.sent_date,
  u.user_name,
  RANK() OVER (PARTITION BY c.sent_date ORDER BY c.num_messages DESC) AS rank
FROM counts AS c
LEFT JOIN npn_users AS u ON c.sender_id = u.user_id
)

SELECT
  sent_date,
  user_name
FROM ranks
WHERE rank = 1
