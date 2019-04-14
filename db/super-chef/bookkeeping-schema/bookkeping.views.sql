-- View for get monthly outcomes transactions grouped by account number

CREATE OR REPLACE VIEW bookkeeping.monthly_outcomes
AS SELECT acc.number AS "accountNumber",
          bnk.name AS "bankName",
          min(ot."timestamp") AS date,
          sum(ot.amount) AS amount,
          sum (CASE WHEN ot.status = 4 THEN 1 ELSE 0 END)  as succeed,
          sum (CASE WHEN ot.status = 2 THEN 1 ELSE 0 END)  as canceled
   FROM bookkeeping.outcomes ot
            LEFT JOIN bookkeeping.accounts acc ON ot."accountId" = acc.id
            LEFT JOIN bookkeeping.banks bnk ON acc."bankId" = bnk.id
   GROUP BY ot."accountId", acc.number, bnk.name;

-- ---------------------------------------------------------------------------------------------------------------------

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
  WHERE oc."outcomeType" = (( SELECT "transactionTypes".id
           FROM bookkeeping."transactionTypes"
          WHERE "transactionTypes".name::text = 'Salary'::text));

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
  WHERE oc."outcomeType" = (( SELECT "transactionTypes".id
           FROM bookkeeping."transactionTypes"
          WHERE "transactionTypes".name::text = 'Order-Food'::text));


