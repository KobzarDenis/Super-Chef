CREATE OR REPLACE PROCEDURE service.order_pay("orderId" integer, "dicountCode" character varying, "statusId" integer, "timeStmp" timestamp with time zone)
              LANGUAGE plpgsql
              AS $procedure$
              declare "oPrice" numeric(15,3);
declare "oStatus" varchar;
begin
select "status" into "oStatus" from service.orders where id="orderId" for update;
if "oStatus" = 'closed' then
			RAISE NOTICE 'Order already closed';
else
update service.orders set status='closed' where id="orderId";
RAISE NOTICE 'Update order';
"oPrice":=(select service.calculate_order_amount("orderId", "dicountCode"));
RAISE NOTICE '%', concat('calculate_order_amount: orderId: ', "orderId", '____oPrice: ', "oPrice");
PERFORM service.update_discount_bonuses("dicountCode", "oPrice");
RAISE NOTICE 'update_discount_bonuses';
RAISE NOTICE '%', concat('oPrice: ', "oPrice", '____statusId: ', "statusId", '_____orderId: ', "orderId", '____timeStmp: ', "timeStmp");
PERFORM bookkeeping.create_transaction_incomes("oPrice", "statusId", concat('Pay for order: ', "orderId"), "timeStmp");
RAISE NOTICE 'create_transaction_incomes';
end if;

exception when others then rollback;
commit;
end;
$procedure$
;
