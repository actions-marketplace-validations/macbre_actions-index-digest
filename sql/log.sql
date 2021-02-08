-- these use index
SELECT item_id FROM 0002_queries_not_using_indices WHERE item_id = 2;
SELECT item_id FROM 0002_queries_not_using_indices WHERE item_id BETWEEN 1 AND 3;
SELECT item_id FROM 0002_queries_not_using_indices WHERE foo = "test" AND item_id = 1;
-- these do not use index
SELECT item_id FROM 0002_queries_not_using_indices WHERE foo = "test" OR item_id > 1;
SELECT item_id FROM 0002_queries_not_using_indices WHERE foo = "test"
-- no matching row in const table (#44)
SELECT foo FROM 0002_queries_not_using_indices WHERE item_id = 5;
-- #148: EXPLAINS' Extra says "No tables used"
SELECT 1*1;
SELECT 1 AS one FROM dual WHERE exists ( SELECT item_id FROM 0002_queries_not_using_indices WHERE foo = "test" );

