-- View for looking full stock orders info with joins other tables

CREATE OR REPLACE VIEW stock.full_order_info
AS SELECT o.id AS "orderId",
    o."invoiceNumber",
    o.amount AS "orderAmount",
    o.count as "productCount",
    a.number AS "accountNumber",
    b.name AS "bankName",
    o."productId",
    p.name AS "productName",
    p.code AS "productCode",
    o."catererId",
    c.code AS "catererCode",
    c.name AS "catererName",
    o."employeeId",
    concat(e."firstName", ' ', e."lastName") AS "employeeName",
    o."orderDate",
    o."supplyDate"
   FROM stock.orders o
     LEFT JOIN stock.products p ON o."productId" = p.id
     LEFT JOIN stock."catererProducts" cp ON p.id = cp."productId"
     LEFT JOIN stock.caterers c ON cp."catererId" = c.id
     LEFT JOIN bookkeeping.accounts a ON c."accountId" = a.id
     LEFT JOIN bookkeeping.banks b ON a."bankId" = b.id
     LEFT JOIN personal.employees e ON o."employeeId" = e.id;

-- ---------------------------------------------------------------------------------------------------------------------
