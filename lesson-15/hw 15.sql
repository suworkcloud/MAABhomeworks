CREATE TABLE #EmptySeats(Number INT, Empty VARCHAR(1))

INSERT INTO #EmptySeats VALUES (1, 'Y'), (2, 'N'), (3, 'N'), (4, 'Y'), (5, 'Y'), (6, 'Y'), (7, 'N'),
(8, 'Y'), (9, 'Y'), (10, 'Y'), (11, 'N'), (12, '')

SELECT * FROM #EmptySeats

WITH cte AS(
SELECT *, LAG(Empty, 1) OVER (ORDER BY Number) AS preone, LAG(Empty, 2) OVER (ORDER BY Number) AS pretwo,
LEAD(Empty, 1) OVER (ORDER BY Number) AS afterone, LEAD(Empty, 2) OVER (ORDER BY Number) AS aftertwo
FROM #EmptySeats), cte2 AS(
SELECT *, Number - ROW_NUMBER() OVER(ORDER BY Number) as rn FROM cte
WHERE (Empty = 'Y' AND preone = 'Y' AND pretwo = 'Y') OR (Empty = 'Y' AND preone = 'Y' AND afterone = 'Y')
OR (Empty = 'Y' AND afterone = 'Y' AND aftertwo = 'Y'))
SELECT STRING_AGG(Number, ' - ') AS EmptySeats FROM cte2
GROUP BY rn

WITH rcte AS(
SELECT *, LEAD(Empty) OVER (ORDER BY Number) prv, LEAD(Empty,2) OVER (ORDER BY Number) nxt FROM #EmptySeats)
SELECT CONCAT(Number, ' - ', Number +1, ' - ', Number+2) FROM rcte
WHERE rcte.Empty='Y' AND rcte.prv='Y' AND rcte.nxt='Y'

WITH cte AS(
SELECT *, Empty + '-' + LEAD(Empty) OVER(ORDER BY (SELECT NULL)) + '-' + LEAD(Empty,2) OVER(ORDER BY (SELECT NULL)) AS l2,
CAST(Number AS VARCHAR(50)) + '-' 
+ CAST(LEAD(Number) OVER(ORDER BY (SELECT NULL)) AS VARCHAR(50)) + '-' 
+ CAST(LEAD(Number,2) OVER(ORDER BY (SELECT NULL)) AS VARCHAR(50)) AS l3 FROM #EmptySeats)
SELECT cte.l3 FROM cte
WHERE cte.l2 = 'Y-Y-Y'
