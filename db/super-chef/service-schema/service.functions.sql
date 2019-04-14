-- Function for calculation order amount

create or replace function service.calculate_order_amount (orderId integer, dicountCode varchar(10)) returns numeric(5, 2) AS $$
declare "discountValue" numeric(5,2);
declare "orderPrice" numeric(4, 3);
declare "finalPrice" numeric(4, 3);
begin
select sum(sof.price) into "orderPrice" from service.orders as so
    inner join service."orderFoods" as sof on so.id=sof."orderId"
where id=orderId;
"discountValue":= service.calculate_discount(dicountCode, "orderPrice");

if "discountValue" > 0 then
			"finalPrice" := ("orderPrice" - ("orderPrice" / "discountValue"));
else
			"finalPrice" := "orderPrice";
end if;

return "finalPrice";
END; $$ LANGUAGE plpgsql;


-- Function for calculation discount amount

create or replace function service.calculate_discount (discountCode varchar(10), amount numeric(4, 3)) returns numeric(5,2) AS $$
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
END; $$ LANGUAGE plpgsql;

-- Function for update discount bonuses

create or replace function service.update_discount_bonuses (discountCode varchar(10), amount numeric(4, 3)) returns void AS $$
declare "discountValue" numeric(5,2);
declare "bonusCoeficient" numeric(5,2);
begin
  "bonusCoeficient"=0.5;
update service.discounts set "accumulativeBonuses" = ("accumulativeBonuses" + ((amount / 100) * "bonusCoeficient")) where code=discountCode;
return;
END; $$ LANGUAGE plpgsql;

