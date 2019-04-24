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
