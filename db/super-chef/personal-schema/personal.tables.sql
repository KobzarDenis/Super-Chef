create schema if not exists "personal";

create table if not exists "personal"."employeeRoles" (
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" text null
);

create table if not exists "personal"."employees" (
	"id" serial primary key,
	"firstName" varchar(100) not null,
	"lastName" varchar(100) not null,
	"ein" varchar(20) unique not null,
	"accountId" int4 not null,
	"passportCode" varchar(5) not null,
	"passportSeries" varchar(10) not null,
	"sex" enum_employees_sex not null,
	"salary" numeric(5,2) not null,
	"address" varchar(100) not null,
	"phoneNumber" varchar(20) not null,
	"email" varchar(50) null,
	"roleId" int4 not null,
	"offerDate" timestamptz not null,
	"fireDate" timestamptz null,
	constraint "employees_passCode_length" check(char_length("passportCode") >= 2),
	constraint "employees_passSeries_length" check(char_length("passportSeries") >= 5),
	foreign key ("roleId") references "personal"."employeeRoles" ("id"),
	foreign key ("accountId") references "bookkeeping"."accounts" ("id")
);