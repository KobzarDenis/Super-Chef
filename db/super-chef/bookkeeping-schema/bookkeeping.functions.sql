CREATE OR REPLACE FUNCTION bookkeeping.create_transaction_incomes(amount double precision, "tTypeId" integer, description character varying, "timeStmp" timestamp with time zone)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
	declare tid varchar(100);
	BEGIN
		insert into bookkeeping.incomes("timestamp", description, amount, "incomeType")
			values ("timeStmp",  description, amount, "tTypeId")
			on conflict ("transactionId") do update set "transactionId"=concat('in-', uuid_generate_v4()) returning "transactionId" into tid;
		return tid;
	END; $function$
;

-- create functions for update transactions statuses
create or replace function change_salary_monthly_transaction_status (old_status integer, new_status integer) returns void AS $$
BEGIN
update bookkeeping.outcomes set status=new_status where status=old_status and extract(month from timestamp) = extract(month from current_timestamp);
END; $$ LANGUAGE plpgsql;

-- on conflict (merge)
create or replace function bookkeeping.create_transaction_outcomes (account_id integer, employee_id integer, description varchar, amount float, outCome_type integer) returns varchar AS $$
				   declare tid varchar(100);
BEGIN
insert into bookkeeping.outcomes (id, "timestamp", "accountId", "employeeId", description, amount, "outcomeType", status)
values (default, (select CURRENT_TIMESTAMP),  account_id, employee_id, description, amount, outCome_type, (select id from bookkeeping."transactionStatuses" where name='Created'))
on conflict ("transactionId") do update set "transactionId"=concat('out-', uuid_generate_v4()) returning "transactionId" into tid;
return tid;
END; $$ LANGUAGE plpgsql;
