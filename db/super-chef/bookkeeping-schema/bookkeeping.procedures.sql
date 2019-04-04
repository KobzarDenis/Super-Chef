-- Procedure for creating monthly OUTCOMES statistic (it can be used by JOB)

CREATE OR REPLACE PROCEDURE bookkeeping."create_outcomesTransactionMonthStats"()
 LANGUAGE plpgsql
AS $procedure$
 declare curr_y integer;
	declare curr_m integer;
 begin
	 curr_y := extract(year from current_date);
	 curr_m := extract(month from current_date);
 insert into bookkeeping."outcomesTransactionMonthStats" (date, "bankName", "accountNumber", amount, succeed, canceled)
        select
			current_date as "date",
			"bankName",
			"accountNumber",
			amount,
			succeed,
			canceled
		from
			bookkeeping.monthly_outcomes as oc
		where
		extract(year from oc.date)=curr_y
		and
		extract(month from oc.date)=curr_m;
end;
$procedure$

-- ---------------------------------------------------------------------------------------------------------------------

