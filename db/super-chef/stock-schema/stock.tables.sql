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

-- Stats tables with base partitions

create table if not exists stock."product_ordersMothStats"(
	"productId" int4 not null,
	"productName" varchar(200) not null,
	"productCode" varchar(50) not null,
	"catererId" int4 not null,
	"catererName" varchar(200) not null,
	"catererCode" varchar(50) not null,
	"catererAccountNumber" varchar(100) not null,
	"date" date not null,
	"amount"  numeric(7, 2) not null,
	"productCount" int4 not null,
	CONSTRAINT "product_ordersMothStats_positive_amount" CHECK ((amount > (0)::numeric)),
	CONSTRAINT "product_ordersMothStats_positive_productCount" CHECK (("productCount" > (0)::numeric))
) partition by list (extract(year from "date"));

CREATE TABLE "stock"."product_ordersMothStats_2018" PARTITION OF "stock"."product_ordersMothStats"
    FOR values IN (2018) partition by list (extract(month from date));

CREATE TABLE "stock"."product_ordersMothStats_2018_01" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (1);
CREATE TABLE "stock"."product_ordersMothStats_2018_02" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (2);
CREATE TABLE "stock"."product_ordersMothStats_2018_03" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (3);
CREATE TABLE "stock"."product_ordersMothStats_2018_04" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (4);
CREATE TABLE "stock"."product_ordersMothStats_2018_05" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (5);
CREATE TABLE "stock"."product_ordersMothStats_2018_06" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (6);
CREATE TABLE "stock"."product_ordersMothStats_2018_07" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (7);
CREATE TABLE "stock"."product_ordersMothStats_2018_08" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (8);
CREATE TABLE "stock"."product_ordersMothStats_2018_09" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (9);
CREATE TABLE "stock"."product_ordersMothStats_2018_10" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (10);
CREATE TABLE "stock"."product_ordersMothStats_2018_11" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (11);
CREATE TABLE "stock"."product_ordersMothStats_2018_12" PARTITION OF "stock"."product_ordersMothStats_2018"
    FOR values IN (12);

CREATE TABLE "stock"."product_ordersMothStats_2019" PARTITION OF "stock"."product_ordersMothStats"
    FOR values IN (2019) partition by list (extract(month from date));

CREATE TABLE "stock"."product_ordersMothStats_2019_01" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (1);
CREATE TABLE "stock"."product_ordersMothStats_2019_02" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (2);
CREATE TABLE "stock"."product_ordersMothStats_2019_03" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (3);
CREATE TABLE "stock"."product_ordersMothStats_2019_04" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (4);
CREATE TABLE "stock"."product_ordersMothStats_2019_05" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (5);
CREATE TABLE "stock"."product_ordersMothStats_2019_06" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (6);
CREATE TABLE "stock"."product_ordersMothStats_2019_07" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (7);
CREATE TABLE "stock"."product_ordersMothStats_2019_08" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (8);
CREATE TABLE "stock"."product_ordersMothStats_2019_09" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (9);
CREATE TABLE "stock"."product_ordersMothStats_2019_10" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (10);
CREATE TABLE "stock"."product_ordersMothStats_2019_11" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (11);
CREATE TABLE "stock"."product_ordersMothStats_2019_12" PARTITION OF "stock"."product_ordersMothStats_2019"
    FOR values IN (12);

-- ---------------------------------------------------------------------------------------------------------------------

create table if not exists stock."product_ordersYearStats"(
	"productId" int4 not null,
	"productName" varchar(200) not null,
	"productCode" varchar(50) not null,
	"catererId" int4 not null,
	"catererName" varchar(200) not null,
	"catererCode" varchar(50) not null,
	"catererAccountNumber" varchar(100) not null,
	"date" date not null,
	"amount"  numeric(7, 2) not null,
	"productCount" int4 not null,
	CONSTRAINT "product_ordersMothStats_positive_amount" CHECK ((amount > (0)::numeric)),
	CONSTRAINT "product_ordersMothStats_positive_productCount" CHECK (("productCount" > (0)::numeric))
) partition by range (date);

CREATE TABLE "stock"."product_ordersYearStats_2018" PARTITION OF "stock"."product_ordersYearStats"
    FOR VALUES FROM ('2018-01-01') TO ('2019-01-01');

 CREATE TABLE "stock"."product_ordersYearStats_2019" PARTITION OF "stock"."product_ordersYearStats"
    FOR VALUES FROM ('2019-01-01') TO ('2019-12-31');
