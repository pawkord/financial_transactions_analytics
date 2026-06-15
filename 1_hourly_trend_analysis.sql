-- Total spent

SELECT
	HOUR(date) AS transaction_hour,
    ROUND(SUM(amount),2) AS total_spent
FROM transactions
WHERE date IS NOT NULL
GROUP BY HOUR(date)
ORDER BY total_spent DESC
LIMIT 5;

-- Average value spent per transaction

SELECT
	HOUR(date) AS transaction_hour,
    ROUND(AVG(amount),2) AS average_transaction_value
FROM transactions
WHERE date IS NOT NULL
GROUP BY HOUR(date)
ORDER BY average_transaction_value DESC
LIMIT 5;

-- Total transactions

SELECT
	HOUR(date) AS transaction_hour,
    COUNT(*) AS total_transactions
FROM transactions
WHERE date IS NOT NULL
GROUP BY HOUR(date)
ORDER BY total_transactions DESC
LIMIT 5;