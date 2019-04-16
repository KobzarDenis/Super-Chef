CREATE OR REPLACE PROCEDURE service.order_pay("orderId" integer, "dicountCode" varchar(50))
LANGUAGE plpgsql AS $procedure$
begin
    declare "oPrice" numeric(5, 2);
    "oPrice" = (select service.calculate_order_amount("orderId", "dicountCode"));
    update service.orders set status='closed' where id="orderId";
    select service.update_discount_bonuses("discountCode", "oPrice");
    select bookkeping.create_transaction_incomes("oPrice", 9, concat('Pay for order: ', "orderId"));
    exception when others then rollback;
    commit;
end;
$procedure$;
