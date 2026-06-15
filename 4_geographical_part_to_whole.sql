WITH StateVolume AS (
	SELECT
		merchant_state,
        SUM(amount) AS state_volume
	FROM transactions
    WHERE merchant_state IS NOT NULL
    GROUP BY merchant_state
)

SELECT 
	merchant_state,
    ROUND(state_volume, 2) AS state_volume,
    ROUND((state_volume/SUM(state_volume) OVER ())*100, 2) AS percentage_of_total
FROM StateVolume
ORDER BY percentage_of_total DESC
LIMIT 10;