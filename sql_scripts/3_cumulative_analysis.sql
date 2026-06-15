WITH DailySpending AS (
	SELECT 
		SUBSTRING(date, 1, 10) AS transaction_date,
        ROUND(SUM(amount), 2) AS daily_total
	FROM transactions
    WHERE date IS NOT NULL
    GROUP BY SUBSTRING(date, 1, 10)
)

SELECT 
	transaction_date,
    daily_total,
    ROUND(SUM(daily_total) OVER (ORDER BY transaction_date ASC), 2) AS running_total
FROM DailySpending
ORDER BY transaction_date ASC;