create schema if not exists "bookkeeping";
create extension if not exists "uuid-ossp";

create table if not exists "bookkeeping"."banks"(
	"id" serial primary key,
	"name" varchar(100) unique not null,
	"transitAccount" varchar(100) unique not null,
	"bic" varchar(100) unique not null,
	"bin" varchar(100) unique not null,
	constraint "banks_transitAccount_length" check(char_length("transitAccount") >= 8),
	constraint "banks_bic_length" check(char_length("bic") >= 4),
	constraint "banks_bin_lenght" check(char_length("bin") >= 4)
);

create table if not exists "bookkeeping"."accounts"(
  	"id" serial primary key,
  	"number" varchar(100) not null,
  	"bankId" int4 not null,
  	"isActive" boolean not null default true,
  	"createdAt" timestamptz not null,
  	"updatedAt" timestamptz not null,
  	constraint "accounts_number_lenght" check(char_length("number") >= 8),
  	foreign key ("bankId") references "bookkeeping"."banks" ("id")
);

create table if not exists "bookkeeping"."transactionTypes"(
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" varchar(300) not null
);

create table if not exists "bookkeeping"."transactionStatuses"(
	"id" serial primary key,
	"name" varchar(20),
	"description" varchar(300) null
);

create table if not exists "bookkeeping"."incomes"(
	"id" serial primary key,
	"transactionId" varchar(50) unique not null default concat('in-', uuid_generate_v4()),
	"description" text null,
	"timestamp" timestamptz not null,
	"amount" numeric(15,2) not null,
	"incomeType" smallint not null,
	constraint "incomes_positive_amount" check("amount" > 0),
	foreign key ("incomeType") references "bookkeeping"."transactionTypes" ("id")
);

create table if not exists "bookkeeping"."outcomes"(
	"id" serial primary key,
	"transactionId" varchar(50) unique not null default concat('out-', uuid_generate_v4()),
	"accountId" int4 not null,
	"employeeId" int4 not null,
	"description" text null,
	"timestamp" timestamptz not null,
	"amount" numeric(15,2) not null,
	"outcomeType" smallint not null,
	"status" smallint not null,
	constraint "outcomes_positive_amount" check("amount" > 0),
	foreign key ("outcomeType") references "bookkeeping"."transactionTypes" ("id"),
	foreign key ("status") references "bookkeeping"."transactionStatuses" ("id"),
	foreign key ("accountId") references "bookkeeping"."accounts" ("id"),
	foreign key ("employeeId") references "personal"."employees" ("id")
);

-- Stats tables with base partitions

create table if not exists "bookkeeping"."outcomesTransactionMonthStats"(
	id serial not null,
	"date" date not null,
	"accountNumber" varchar(100) not null,
	"bankName" varchar(100) not null,
	"amount" numeric(25, 2) not null,
	"succeed" int4 not null default 0,
	"canceled" int2 not null default 0,
	CONSTRAINT "outcomesMonthStats_positive_amount" CHECK ((amount > (0)::numeric)),
	CONSTRAINT "outcomesMonthStats_positive_suceed_count" CHECK ((succeed >= (0)::numeric)),
	CONSTRAINT "outcomesMonthStats_positive_canceled_count" CHECK ((canceled >= (0)::numeric))
) partition by list (extract(year from date));

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats"
    FOR values IN (2016) partition by list (extract(month from date));

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_01" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (1);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_02" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (2);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_03" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (3);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_04" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (4);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_05" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (5);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_06" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (6);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_07" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (7);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_08" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (8);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_09" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (9);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_10" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (10);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_11" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (11);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2016_12" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2016"
    FOR values IN (12);

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats"
    FOR values IN (2017) partition by list (extract(month from date));

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_01" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (1);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_02" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (2);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_03" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (3);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_04" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (4);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_05" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (5);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_06" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (6);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_07" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (7);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_08" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (8);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_09" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (9);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_10" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (10);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_11" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (11);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2017_12" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2017"
    FOR values IN (12);


CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats"
    FOR values IN (2018) partition by list (extract(month from date));

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_01" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (1);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_02" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (2);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_03" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (3);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_04" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (4);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_05" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (5);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_06" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (6);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_07" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (7);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_08" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (8);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_09" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (9);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_10" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (10);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_11" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (11);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2018_12" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2018"
    FOR values IN (12);

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats"
    FOR values IN (2019) partition by list (extract(month from date));

CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_01" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (1);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_02" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (2);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_03" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (3);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_04" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (4);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_05" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (5);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_06" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (6);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_07" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (7);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_08" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (8);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_09" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (9);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_10" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (10);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_11" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (11);
CREATE TABLE "bookkeeping"."outcomesTransactionMonthStats_2019_12" PARTITION OF "bookkeeping"."outcomesTransactionMonthStats_2019"
    FOR values IN (12);

-- ------------------------------------------------------------------------------------------------------------------------------------------------------

create table if not exists "bookkeeping"."outcomesTransactionYearStats"(
	id serial not null,
	"date" date not null,
	"accountNumber" varchar(100) not null,
	"bankName" varchar(100) not null,
	"amount" numeric(30, 2) not null,
	"succeed" int4 not null default 0,
	"canceled" int2 not null default 0,
	CONSTRAINT "outcomesYearStats_positive_amount" CHECK ((amount > (0)::numeric)),
	CONSTRAINT "outcomesYearStats_positive_suceed_count" CHECK ((succeed >= (0)::numeric)),
	CONSTRAINT "outcomesYearStats_positive_canceled_count" CHECK ((canceled >= (0)::numeric))
) partition by range (date);

CREATE TABLE "bookkeeping"."outcomesTransactionYearStats_2016" PARTITION OF "bookkeeping"."outcomesTransactionYearStats"
    FOR VALUES FROM ('2016-01-01') TO ('2017-01-01');

CREATE TABLE "bookkeeping"."outcomesTransactionYearStats_2017" PARTITION OF "bookkeeping"."outcomesTransactionYearStats"
    FOR VALUES FROM ('2017-01-01') TO ('2018-01-01');

CREATE TABLE "bookkeeping"."outcomesTransactionYearStats_2018" PARTITION OF "bookkeeping"."outcomesTransactionYearStats"
    FOR VALUES FROM ('2018-01-01') TO ('2019-01-01');

 CREATE TABLE "bookkeeping"."outcomesTransactionYearStats_2019" PARTITION OF "bookkeeping"."outcomesTransactionYearStats"
    FOR VALUES FROM ('2019-01-01') TO ('2020-01-01');

-- ------------------------------------------------------------------------------------------------------------------------------------------------------
