create schema if not exists "stock";

create table if not exists "stock"."productGroups"(
	"id" serial primary key,
	"name" varchar(200) not null,
	"description" text null
);

create table if not exists "stock"."products"(
	"id" serial primary key,
	"name" varchar(200) not null,
	"rest" numeric(5,2) not null,
	"code" varchar(50) unique not null,
	"groupId" int4 not null,
	"price" numeric(5,2) not null,
	constraint "products_price" check("price" > 0),
	constraint "products_code_length" check(char_length("code") >= 5),
	constraint "products_positive_rest" check("rest" >= 0),
	foreign key ("groupId") references "stock"."productGroups" ("id")
);

create table if not exists "stock"."caterers"(
	"id" serial primary key,
	"code" varchar(50) unique not null,
	"name" varchar(200) unique not null,
	"address" varchar(300) not null,
	"phoneNumber" varchar(20) unique not null,
	"email" varchar(50) null,
	"site" text null,
	"status" "enum_caterers_status" not null default 'active',
	"accountId" int4 unique not null,
	"createdAt" timestamptz not null,
	"updatedAt" timestamptz not null,
	"deletedAt" timestamptz null,
	constraint "caterers_code_length" check(char_length("code") >= 5),
	foreign key ("accountId") references "bookkeeping"."accounts" ("id")
);

create table if not exists "stock"."catererProducts"(
	"catererId" int4 not null,
	"productId" int4 not null,
	primary key("catererId", "productId"),
	foreign key ("catererId") references "stock"."caterers" ("id"),
	foreign key ("productId") references "stock"."products" ("id")
);

create table if not exists "stock"."productApplying"(
	"productId" int4 not null,
	"count" numeric(5,2) not null,
	"date" timestamptz not null,
	constraint "productApplying_positive_count" check("count" > 0),
	foreign key ("productId") references "stock"."products" ("id")
);

create table if not exists "stock"."productOrderStatus"(
	"id" serial primary key,
	"name" varchar(20)
);

create table if not exists "stock"."orders"(
	"id" serial primary key,
	"productId" int4 not null,
	"catererId" int4 not null,
	"employeeId" int4 not null,
	"invoiceNumber" varchar(100) not null,
	"count" numeric(5,2) not null,
	"orderDate" timestamptz not null,
	"supplyDate" timestamptz null,
	"statusId" smallint not null,
	"amount" numeric(5,2) not null,
	constraint "stock_orders_count" check("count" > 0),
	constraint "stock_orders_amount" check("amount" > 0),
	foreign key ("employeeId") references "personal"."employees" ("id"),
	foreign key ("catererId") references "stock"."caterers" ("id"),
	foreign key ("productId") references "stock"."products" ("id"),
	foreign key ("statusId") references "stock"."productOrderStatus" ("id")
);
