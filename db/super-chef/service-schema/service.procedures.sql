CREATE OR REPLACE PROCEDURE service.order_pay("orderId" integer, "dicountCode" character varying, "statusId" integer, "timeStmp" timestamp with time zone)
 LANGUAGE plpgsql
AS $procedure$
    declare "oPrice" numeric(10,3);
begin
    update service.orders set status='closed' where id="orderId";
   RAISE NOTICE 'Update order';
   "oPrice":=(select service.calculate_order_amount("orderId", "dicountCode"));
   RAISE NOTICE '%', concat('calculate_order_amount: ', "orderId", '____', "oPrice");
   PERFORM service.update_discount_bonuses("dicountCode", "oPrice");
   RAISE NOTICE 'update_discount_bonuses';
  RAISE NOTICE '%', concat('oPrice: ', "oPrice", '____statusId', "statusId", '_____orderId', "orderId", '____timeStmp', "timeStmp");
   PERFORM bookkeeping.create_transaction_incomes("oPrice", "statusId", concat('Pay for order: ', "orderId"), "timeStmp");
   RAISE NOTICE 'create_transaction_incomes';

   commit;
end;
$procedure$
;
