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
	"amount" numeric(5,2) not null,
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
	"amount" numeric(5,2) not null,
	"outcomeType" smallint not null,
	"status" smallint not null,
	constraint "outcomes_positive_amount" check("amount" > 0),
	foreign key ("outcomeType") references "bookkeeping"."transactionTypes" ("id"),
	foreign key ("status") references "bookkeeping"."transactionStatuses" ("id"),
	foreign key ("accountId") references "bookkeeping"."accounts" ("id"),
	foreign key ("employeeId") references "personal"."employees" ("id")
);
