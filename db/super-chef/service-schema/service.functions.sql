-- Function for calculation order amount

CREATE OR REPLACE FUNCTION service.calculate_order_amount(orderid integer, dicountcode character varying)
 RETURNS numeric
 LANGUAGE plpgsql
AS $function$
	declare "discountValue" numeric(15,2);
	declare "orderPrice" numeric(15, 3);
	declare "finalPrice" numeric(15, 3);
	begin
		select sum((sof.price * sof.count)) into "orderPrice" from service.orders as so
		inner join service."orderFoods" as sof on so.id=sof."orderId"
		where id=orderid;
		"discountValue":=service.calculate_discount(dicountcode, "orderPrice");

		if "discountValue" > 0 then
			"finalPrice" := "orderPrice" - "discountValue";
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
					   declare "discountValue" numeric(15,2);
declare "discountSum" numeric(15,2);
begin
select "count" into "discountValue" from service.discounts where "code"=discountCode;
if "discountValue" > 0 then
			"discountSum":= (amount / 100) * "discountValue";
else
			"discountSum":= 0;
end if;
return "discountSum";
END; $function$
;

-- Function for updating discount bonuses

CREATE OR REPLACE FUNCTION service.update_discount_bonuses(discountcode character varying, amount numeric)
				   RETURNS void
				   LANGUAGE plpgsql
				   AS $function$
				   declare "coeficient" numeric(5,2);
declare "accBonuses" numeric(15,2);
begin
	coeficient:=1.5;
update service.discounts set "accumulativeBonuses" = "accumulativeBonuses" + ((amount / 100) * coeficient) where code=discountcode;
return;
END; $function$
;


