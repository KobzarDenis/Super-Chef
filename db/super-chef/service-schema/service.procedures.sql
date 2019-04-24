CREATE OR REPLACE PROCEDURE service.order_pay("orderId" integer, "dicountCode" varchar(50))
LANGUAGE plpgsql
AS $procedure$
    declare "oPrice" numeric(4,3);
begin
    update service.orders set status='closed' where id="orderId";
    "oPrice" := (select service.calculate_order_amount("orderId", "dicountCode"));
    select service.update_discount_bonuses("discountCode", "oPrice");
    select bookkeping.create_transaction_incomes("oPrice", 9, concat('Pay for order: ', "orderId"));
    commit;
    exception when others then rollback;
end;
$procedure$;
