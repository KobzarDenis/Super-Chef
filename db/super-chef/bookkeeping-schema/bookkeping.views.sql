-- View for get monthly outcomes transactions grouped by account number

CREATE OR REPLACE VIEW bookkeeping.monthly_outcomes
AS SELECT acc.number AS "accountNumber",
          bnk.name AS "bankName",
          ot."timestamp" AS date,
          sum(case when ot.status = 4 THEN ot.amount else 0 END) AS amount,
          sum (CASE WHEN ot.status = 4 THEN 1 ELSE 0 END)  as succeed,
          sum (CASE WHEN ot.status = 2 THEN 1 ELSE 0 END)  as canceled
   FROM bookkeeping.outcomes ot
            LEFT JOIN bookkeeping.accounts acc ON ot."accountId" = acc.id
            LEFT JOIN bookkeeping.banks bnk ON acc."bankId" = bnk.id
   GROUP BY ot."accountId", acc.number, bnk.name, ot."timestamp";
-- ---------------------------------------------------------------------------------------------------------------------

-- View for get yearly outcomes transactions grouped by account number and year

CREATE OR REPLACE VIEW bookkeeping.yearly_outcomes
AS SELECT m_ot."accountNumber" AS "accountNumber",
          m_ot."bankName" AS "bankName",
          date_part('year', m_ot.date)::integer AS year,
          sum(m_ot.amount) AS amount,
          sum(m_ot.succeed) as succeed,
          sum(m_ot.canceled) as canceled
   from bookkeeping.monthly_outcomes as m_ot
   GROUP BY m_ot."accountNumber", m_ot."bankName", date_part('year', m_ot.date);

-- Permissions

ALTER TABLE bookkeeping.yearly_outcomes OWNER TO postgres;
GRANT ALL ON TABLE bookkeeping.yearly_outcomes TO postgres;

-- View for selecting salary outcomes info

CREATE OR REPLACE VIEW bookkeeping.salary_outcome_transactions_info
AS SELECT e.id AS "employeeId",
    concat(e."firstName", ' ', e."lastName") AS "employeeName",
    acc.number as "accountNumber",
    b.name as "bankName",
    oc.amount,
    oc."timestamp"
   FROM bookkeeping.outcomes oc
     LEFT JOIN bookkeeping.accounts acc ON oc."accountId" = acc.id
     LEFT JOIN bookkeeping.banks b ON acc."bankId" = b.id
     LEFT JOIN personal.employees e ON acc.id = e."accountId"
  WHERE oc."outcomeType" = 1;

-- View for selecting order-food outcomes info

CREATE OR REPLACE VIEW bookkeeping.product_orders_outcome_transactions_info
AS SELECT c.id AS "catererId",
    c.code AS "catererCode",
    c.name AS "catererName",
    c."phoneNumber",
    c.email,
    c.site,
    acc.number AS "accountNumber",
    b.name AS "bankName",
    oc.amount,
    oc."timestamp"
   FROM bookkeeping.outcomes oc
     LEFT JOIN bookkeeping.accounts acc ON oc."accountId" = acc.id
     LEFT JOIN bookkeeping.banks b ON acc."bankId" = b.id
     LEFT JOIN stock.caterers c ON acc.id = c."accountId"
  WHERE oc."outcomeType" = 2;


