-- Function for calculation order amount

CREATE OR REPLACE FUNCTION service.calculate_order_amount(orderid integer, dicountcode character varying)
              RETURNS numeric
              LANGUAGE plpgsql
              AS $function$
              declare "discountValue" numeric(5,2);
declare "orderPrice" numeric(10, 3);
declare "finalPrice" numeric(10, 3);
begin
select sum((sof.price * sof.count)) into "orderPrice" from service.orders as so
                                                               inner join service."orderFoods" as sof on so.id=sof."orderId"
where id=orderid;
"discountValue":=service.calculate_discount(dicountcode, "orderPrice");

if "discountValue" > 0 then
			"finalPrice" := ("orderPrice" - ("orderPrice" / "discountValue"));
else
			"finalPrice" := "orderPrice";
end if;

return "finalPrice";
END; $function$
;


-- Function for calculation discount amount

CREATE OR REPLACE FUNCTION service.calculate_discount(discountcode character varying, amount numeric)
                   RETURNS numeric
                   LANGUAGE plpgsql
                   AS $function$
                   declare "discountValue" numeric(5,2);
declare "discountSum" numeric(5,2);
begin
select "count" into "discountValue" from service.discounts where "code"=discountCode;
if "discountValue" > 0 then
			"discountSum":= amount / "discountValue";
else
			"discountSum":= 0;
end if;
return "discountSum";
END; $function$
;

