WITH CustomerSegments AS (
	SELECT 
		id AS client_id,
        yearly_income,
        CASE
			WHEN yearly_income >= 100000 THEN '1. High income ($100k+)'
            WHEN yearly_income >= 50000 THEN '2. Mid income ($50k-$100k)'
            ELSE '3. Low income (<$50k)'
		END AS income_segment
	FROM users
)

SELECT
	income_segment,
    COUNT(client_id) AS total_customers,
    ROUND(COUNT(client_id)*100/(SELECT COUNT(*) FROM users), 2) AS percentage_of_total
FROM CustomerSegments
GROUP BY income_segment
ORDER BY income_segment ASC;
            