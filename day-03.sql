-- SQL Advent Calendar - Day 3
-- Title: The Grinch's Best Pranks Per Target
-- Difficulty: hard
--
-- Question:
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--
-- The Grinch has brainstormed a ton of pranks for Whoville, but he only wants to keep the top prank per target, with the highest evilness score. Return the most evil prank for each target. If two pranks have the same evilness, the more recently brainstormed wins.
--

-- Table Schema:
-- Table: grinch_prank_ideas
--   prank_id: INTEGER
--   target_name: VARCHAR
--   prank_description: VARCHAR
--   evilness_score: INTEGER
--   created_at: TIMESTAMP
--

-- My Solution:

WITH target_groups AS (SELECT
  *,
  ROW_NUMBER() OVER (
    PARTITION BY target_name
    ORDER BY evilness_score DESC, created_at DESC
  ) AS row_num
FROM grinch_prank_ideas)

SELECT
  target_name,
  evilness_score,
  prank_description
FROM target_groups
WHERE row_num = 1
