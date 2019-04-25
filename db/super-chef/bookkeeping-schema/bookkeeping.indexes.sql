-- Indexes for banks
create index "banks_bin_bic" on "bookkeeping"."banks" ("bin", "bic");


-- Indexes for accounts
create index "accounts_number" on "bookkeeping"."accounts" ("number");
create unique index "accounts_uniq_number_per_bank" on "bookkeeping"."accounts" ("number", "bankId");


-- Indexes for incomes
create index "incomes_transactionId_idx" on "bookkeeping"."incomes" USING HASH ("transactionId");
create index "incomes_dates" on "bookkeeping"."incomes" USING BTREE ("timestamp");

-- Indexes for outcomes
create index "outcomes_transactionId_idx" on "bookkeeping"."outcomes" USING HASH ("transactionId");
create index "outcomes_dates" on "bookkeeping"."outcomes" USING BTREE ("timestamp");
CREATE INDEX outcomes_type ON bookkeeping.outcomes USING btree ("outcomeType");
CREATE INDEX outcomes_status ON bookkeeping.outcomes USING btree ("status");

-- Indexes for outcomes monthly statistic (for each partition)

create index "outcomesTransactionMonthStats_2016_01_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_01" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_02_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_02" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_03_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_03" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_04_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_04" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_05_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_05" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_06_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_06" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_07_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_07" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_08_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_08" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_09_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_09" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_10_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_10" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_11_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_11" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2016_12_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2016_12" using hash ("accountNumber");

create index "outcomesTransactionMonthStats_2017_01_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_01" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_02_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_02" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_03_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_03" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_04_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_04" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_05_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_05" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_06_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_06" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_07_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_07" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_08_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_08" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_09_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_09" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_10_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_10" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_11_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_11" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2017_12_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2017_12" using hash ("accountNumber");

create index "outcomesTransactionMonthStats_2018_01_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_01" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_02_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_02" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_03_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_03" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_04_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_04" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_05_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_05" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_06_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_06" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_07_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_07" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_08_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_08" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_09_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_09" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_10_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_10" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_11_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_11" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2018_12_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2018_12" using hash ("accountNumber");

create index "outcomesTransactionMonthStats_2019_01_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_01" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_02_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_02" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_03_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_03" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_04_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_04" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_05_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_05" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_06_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_06" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_07_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_07" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_08_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_08" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_09_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_09" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_10_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_10" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_11_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_11" using hash ("accountNumber");
create index "outcomesTransactionMonthStats_2019_12_amount_idx" on "bookkeeping"."outcomesTransactionMonthStats_2019_12" using hash ("accountNumber");

-- Indexes for UNIQUE date per accountNumber

create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_01" on "bookkeeping"."outcomesTransactionMonthStats_2016_01"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_02" on "bookkeeping"."outcomesTransactionMonthStats_2016_02"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_03" on "bookkeeping"."outcomesTransactionMonthStats_2016_03"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_04" on "bookkeeping"."outcomesTransactionMonthStats_2016_04"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_05" on "bookkeeping"."outcomesTransactionMonthStats_2016_05"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_06" on "bookkeeping"."outcomesTransactionMonthStats_2016_06"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_07" on "bookkeeping"."outcomesTransactionMonthStats_2016_07"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_08" on "bookkeeping"."outcomesTransactionMonthStats_2016_08"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_09" on "bookkeeping"."outcomesTransactionMonthStats_2016_09"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_10" on "bookkeeping"."outcomesTransactionMonthStats_2016_10"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_11" on "bookkeeping"."outcomesTransactionMonthStats_2016_11"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2016_12" on "bookkeeping"."outcomesTransactionMonthStats_2016_12"("accountNumber", "date");

create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_01" on "bookkeeping"."outcomesTransactionMonthStats_2017_01"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_02" on "bookkeeping"."outcomesTransactionMonthStats_2017_02"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_03" on "bookkeeping"."outcomesTransactionMonthStats_2017_03"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_04" on "bookkeeping"."outcomesTransactionMonthStats_2017_04"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_05" on "bookkeeping"."outcomesTransactionMonthStats_2017_05"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_06" on "bookkeeping"."outcomesTransactionMonthStats_2017_06"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_07" on "bookkeeping"."outcomesTransactionMonthStats_2017_07"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_08" on "bookkeeping"."outcomesTransactionMonthStats_2017_08"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_09" on "bookkeeping"."outcomesTransactionMonthStats_2017_09"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_10" on "bookkeeping"."outcomesTransactionMonthStats_2017_10"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_11" on "bookkeeping"."outcomesTransactionMonthStats_2017_11"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2017_12" on "bookkeeping"."outcomesTransactionMonthStats_2017_12"("accountNumber", "date");

create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_01" on "bookkeeping"."outcomesTransactionMonthStats_2018_01"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_02" on "bookkeeping"."outcomesTransactionMonthStats_2018_02"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_03" on "bookkeeping"."outcomesTransactionMonthStats_2018_03"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_04" on "bookkeeping"."outcomesTransactionMonthStats_2018_04"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_05" on "bookkeeping"."outcomesTransactionMonthStats_2018_05"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_06" on "bookkeeping"."outcomesTransactionMonthStats_2018_06"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_07" on "bookkeeping"."outcomesTransactionMonthStats_2018_07"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_08" on "bookkeeping"."outcomesTransactionMonthStats_2018_08"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_09" on "bookkeeping"."outcomesTransactionMonthStats_2018_09"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_10" on "bookkeeping"."outcomesTransactionMonthStats_2018_10"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_11" on "bookkeeping"."outcomesTransactionMonthStats_2018_11"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2018_12" on "bookkeeping"."outcomesTransactionMonthStats_2018_12"("accountNumber", "date");

create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_01" on "bookkeeping"."outcomesTransactionMonthStats_2019_01"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_02" on "bookkeeping"."outcomesTransactionMonthStats_2019_02"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_03" on "bookkeeping"."outcomesTransactionMonthStats_2019_03"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_04" on "bookkeeping"."outcomesTransactionMonthStats_2019_04"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_05" on "bookkeeping"."outcomesTransactionMonthStats_2019_05"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_06" on "bookkeeping"."outcomesTransactionMonthStats_2019_06"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_07" on "bookkeeping"."outcomesTransactionMonthStats_2019_07"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_08" on "bookkeeping"."outcomesTransactionMonthStats_2019_08"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_09" on "bookkeeping"."outcomesTransactionMonthStats_2019_09"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_10" on "bookkeeping"."outcomesTransactionMonthStats_2019_10"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_11" on "bookkeeping"."outcomesTransactionMonthStats_2019_11"("accountNumber", "date");
create unique index "outcomesTransactionMonthStats_uniq_date_per_account_2019_12" on "bookkeeping"."outcomesTransactionMonthStats_2019_12"("accountNumber", "date");

-- Indexes for outcomes yearly statistic (for each partition)

create index "outcomesTransactionYearStats_2016_amount_idx" on "bookkeeping"."outcomesTransactionYearStats_2016" using hash ("accountNumber");
create index "outcomesTransactionYearStats_2017_amount_idx" on "bookkeeping"."outcomesTransactionYearStats_2017" using hash ("accountNumber");
create index "outcomesTransactionYearStats_2018_amount_idx" on "bookkeeping"."outcomesTransactionYearStats_2018" using hash ("accountNumber");
create index "outcomesTransactionYearStats_2019_amount_idx" on "bookkeeping"."outcomesTransactionYearStats_2019" using hash ("accountNumber");
