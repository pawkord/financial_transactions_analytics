WITH CustomerTransactions AS (
	SELECT
		client_id,
        COUNT(id) AS total_transactions,
        ROUND(SUM(amount), 2) AS total_spent,
        ROUND(AVG(amount), 2) AS average_order_value,
        MAX(use_chip) AS preferred_method
	FROM transactions
    WHERE amount > 0
    GROUP BY client_id
),
CustomerSegments AS (
	SELECT
		id AS client_id,
        CASE 
			WHEN yearly_income >= 100000 THEN 'High income ($100k+)'
            WHEN yearly_income >= 50000 THEN 'Mid income ($50k-$100k)'
			ELSE 'Low income (>$50k)'
		END AS income_segment
	FROM users
)

SELECT 
	u.id AS user_id,
    u.current_age,
    u.gender,
    u.credit_score,
    s.income_segment,
    MAX(c.card_on_dark_web) AS dark_web_activity,
    COALESCE(ct.total_transactions, 0) AS total_transactions,
    COALESCE(ct.total_spent, 0) AS lifetime_value,
    COALESCE(ct.average_order_value, 0) AS aov,
    ct.preferred_method
FROM users u
LEFT JOIN CustomerSegments s
	ON u.id = s.client_id
LEFT JOIN cards c 
	ON u.id = c.client_id
LEFT JOIN CustomerTransactions ct
	ON u.id = ct.client_id
GROUP BY
	u.id,
    u.current_age,
    u.gender,
    u.credit_score,
    s.income_segment,
    ct.total_transactions,
    ct.total_spent,
    ct.average_order_value,
    ct.preferred_method
ORDER BY lifetime_value DESC;