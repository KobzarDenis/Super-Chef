-- Comments for banks types and constraints
comment on column  "bookkeeping"."banks"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';
comment on column  "bookkeeping"."banks"."transitAccount" is 'Type varchar(100) transitAccount can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';
comment on column  "bookkeeping"."banks"."bic" is 'Type varchar(100) bic can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';
comment on column  "bookkeeping"."banks"."bin" is 'Type varchar(100) bin can be shorter but can not be longer than 100 characters. Required. Uniq for each banks.';
comment on constraint  "banks_transitAccount_length" on "bookkeeping"."banks" is 'Transit account can not be shorter than 8 characters. Uniq for each banks.';
comment on constraint  "banks_bic_length" on "bookkeeping"."banks" is 'BIC number can not be shorter than 4 characters. Uniq for each banks.';
comment on constraint  "banks_bin_lenght" on "bookkeeping"."banks" is 'BIN number can not be shorter than 4 characters. Uniq for each banks.';
comment on index  "bookkeeping"."banks_bin_bic" is 'This index created for optimized banks search by bin and bic numbers.';


-- Comments for accounts types and constraints
comment on column  "bookkeeping"."accounts"."number" is 'Type varchar(100) number can be shorter but can not be longer than 100 characters. Required.';
comment on column  "bookkeeping"."accounts"."isActive" is 'Type boolean because we need only 2 values (true/false). Required.';
comment on column  "bookkeeping"."accounts"."createdAt" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "bookkeeping"."accounts"."updatedAt" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on constraint  "accounts_number_lenght" on "bookkeeping"."accounts" is 'Number can not be shorter than 8.';
comment on index  "bookkeeping"."accounts_number" is 'This index created for optimized accounts search by number.';
comment on index  "bookkeeping"."accounts_uniq_number_per_bank" is 'This index created for save unique number account for each banks.';


-- Comments for incomes types and constraints
comment on column  "bookkeeping"."incomes"."transactionId" is 'Type varchar(50) transactionId can be shorter but can not be longer than 50 characters. Special key with prefix "in-" and uuid. Required. Uniq for each incomes.';
comment on column  "bookkeeping"."incomes"."description" is 'Type text because description will be able to have unlimited length.';
comment on column  "bookkeeping"."incomes"."amount" is 'Type numeric(5,2) because we need only 2 digits scale. Required.';
comment on column  "bookkeeping"."incomes"."timestamp" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "bookkeeping"."incomes"."incomeType" is 'Income type. Value from table transactionTypes. Required.';
comment on constraint  "incomes_positive_amount" on "bookkeeping"."incomes" is 'Amount can not be smallest than 0.1.';
comment on index  "bookkeeping"."incomes_transactions" is 'This index created for optimized incomes search by transactionId.';
comment on index  "bookkeeping"."incomes_dates" is 'This index created for optimized incomes search by dates.';

-- Comments for outcomes types and constraints
comment on column  "bookkeeping"."outcomes"."transactionId" is 'Type varchar(50) transactionId can be shorter but can not be longer than 50 characters. Special key with prefix "out-" and uuid. Required. Uniq for each incomes.';
comment on column  "bookkeeping"."outcomes"."description" is 'Type text because description will be able to have unlimited length.';
comment on column  "bookkeeping"."outcomes"."amount" is 'Type numeric(5,2) because we need only 2 digits scale. Required.';
comment on column  "bookkeeping"."outcomes"."timestamp" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "bookkeeping"."outcomes"."outcomeType" is 'Outcome type. Value from table transactionTypes. Required.';
comment on column  "bookkeeping"."outcomes"."status" is 'Transaction status. Value from table transactionStatuses. Required.';
comment on constraint  "outcomes_positive_amount" on "bookkeeping"."outcomes" is 'Amount can not be smallest than 0.1.';
comment on index  "bookkeeping"."outcomes_transactions" is 'This index created for optimized outcomes search by transactionId.';
comment on index  "bookkeeping"."outcomes_dates" is 'This index created for optimized outcomes search by dates.';
