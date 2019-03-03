-- FIRST TASK ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

SELECT
	ID,
	OPERNAME,
	ROW_NUMBER() OVER (PARTITION BY SUBSTRING(OPERNAME, 1, 1) ORDER BY OPERNAME) AS ROW_NUM,
	COUNT(ID) OVER () AS TOTAL_COUNT,
	LAG(ID, 1, 0) OVER (ORDER BY OPERNAME) AS LAST_ID,
	LEAD(ID, 1, 0) OVER (ORDER BY OPERNAME) AS NEXT_ID,
	FIRST_VALUE(OPERNAME) OVER (ORDER BY ID ROWS 2 PRECEDING) AS PRE_PREVIUS_NAME
FROM
	OPERATORS
ORDER BY OPERNAME;

-- SECOND TASK ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

SELECT
	ID,
	OPERNAME,
	ORGNAME,
	IF(FIN_MAIL='', IF(TECH_MAIL='', 'no email', TECH_MAIL), FIN_MAIL) AS MAILL,
	NTILE(3) OVER () AS GROUP_ID
FROM
	OPERATORS;

-- THIRD TASK ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

SELECT
	op.ID,
	op.OPERNAME,
	op.ORGNAME,
	p.PAY_DATE,
	p.PAY_SUM,
	(p.SUM_POS = 1) AS IS_GREATEST
FROM
	OPERATORS as op
		INNER JOIN (
		SELECT DISTINCT PAY_SUM, OPER_ID, PAY_DATE, ROW_NUMBER() over (PARTITION BY OPER_ID ORDER BY PAY_SUM DESC) as SUM_POS from PAY where PAY_SUM IS NOT NULL
	) AS p ON p.OPER_ID=op.ID AND p.SUM_POS IN (1,2)
ORDER BY op.OPERNAME;


-- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

CREATE INDEX sum_Idx ON PAY (OPER_ID, PAY_SUM);

WITH two_max_sum AS (
	SELECT MAX(PAY_SUM) AS PAY_SUM, OPER_ID, 1 AS IS_GREATEST FROM PAY AS p1 GROUP BY OPER_ID
	UNION
	SELECT MAX(PAY_SUM) AS PAY_SUM, OPER_ID, 0 AS IS_GREATEST FROM PAY AS p2 WHERE PAY_SUM < (SELECT MAX(PAY_SUM) FROM PAY WHERE OPER_ID = p2.OPER_ID) GROUP BY OPER_ID
)

SELECT
	op.ID,
	op.OPERNAME,
	op.ORGNAME,
	pF.PAY_SUM,
	pF.PAY_DATE,
	pF.IS_GREATEST
FROM
	OPERATORS AS op
		INNER JOIN (
		SELECT MAX(PAY_DATE) AS PAY_DATE, s.PAY_SUM, s.OPER_ID, s.IS_GREATEST FROM PAY AS pM
																																								 INNER JOIN two_max_sum AS s ON pM.OPER_ID=s.OPER_ID AND pM.PAY_SUM=s.PAY_SUM
		GROUP BY s.OPER_ID, s.PAY_SUM, s.IS_GREATEST
	) AS pF ON pf.OPER_ID=op.ID
ORDER BY op.OPERNAME;


-- FOURTH TASK ---------- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

