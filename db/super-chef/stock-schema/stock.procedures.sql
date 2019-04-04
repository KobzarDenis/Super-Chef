-- Procedure for creating monthly PRODUCT ORDERS statistic (it can be used by JOB)

CREATE OR REPLACE PROCEDURE stock."create_ordersMothStats"()
 LANGUAGE plpgsql
AS $procedure$
	declare curr_y integer;
	declare curr_m integer;
 begin
	 curr_y := extract(year from current_date);
	 curr_m := extract(month from current_date);

	insert into stock."product_ordersMothStats" (date, "productId", "productCode", "productName", "catererId", "catererCode", "catererName", "catererAccountNumber", amount, "productCount" )
	select
	current_date as "date",
	fi."productId",
	fi."productCode",
	fi."productName",
	fi."catererId",
	fi."catererCode",
	fi."catererName",
	fi."accountNumber",
	sum(fi."productCount") as "productCount",
	sum(fi."orderAmount") as "orderAmount"
 from stock."full_order_info" as fi
 where
 extract(year from fi."supplyDate")=curr_y
		and
		extract(month from fi."supplyDate")=curr_m
 group by
 	fi."productId", fi."productCode", fi."productName", fi."catererId", fi."catererCode", fi."catererName", fi."accountNumber";
 end;
$procedure$

-- ---------------------------------------------------------------------------------------------------------------------
