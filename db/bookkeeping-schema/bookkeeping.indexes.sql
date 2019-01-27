-- Indexes for banks
create index "banks_bin_bic" on "bookkeeping"."banks" ("bin", "bic");


-- Indexes for accounts
create index "accounts_number" on "bookkeeping"."accounts" ("number");
create unique index "accounts_uniq_number_per_bank" on "bookkeeping"."accounts" ("number", "bankId");


-- Indexes for incomes
create index "incomes_transactions" on "bookkeeping"."incomes" ("transactionId");
create index "incomes_dates" on "bookkeeping"."incomes" ("timestamp");


-- Indexes for outcomes
create index "outcomes_transactions" on "bookkeeping"."outcomes" ("transactionId");
create index "outcomes_dates" on "bookkeeping"."outcomes" ("timestamp");