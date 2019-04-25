create schema if not exists "service";

create table if not exists "service"."clients" (
	"id" serial primary key,
	"firstName" varchar(100) not null,
	"lastName" varchar(100) null,
	"email" varchar(50),
	"phoneNumber" varchar(20) not null
);

create table if not exists "service"."tables" (
	"id" serial primary key,
	"seatCount" smallint,
	"status" enum_tables_status not null default 'free',
	constraint "tables_positive_seatCount"  check ("seatCount" > 0)
);

create table if not exists "service"."foodGroups" (
	"id" serial primary key,
	"name" varchar(100) not null
);

create table if not exists "service"."foods" (
	"id" serial primary key,
	"name" varchar(100) not null,
	"description" text null,
	"price" numeric(15,2) not null,
	"groupId" int4 not null,
	constraint "foods_positive_price"  check ("price" > 0),
	foreign key ("groupId") references "service"."foodGroups" ("id")
);

create table if not exists "service"."ingredients" (
	"id" serial primary key,
	"name" varchar(100) not null
);

create table if not exists "service"."foodIngredients" (
	"foodId" int4 not null,
	"ingredientId" int4 not null,
	"weight" numeric(15,4) not null,
	constraint "foodIngredients_positive_weight"  check ("weight" > 0),
	primary key ("foodId", "ingredientId"),
	foreign key ("foodId") references "service"."foods" ("id"),
	foreign key ("ingredientId") references "service"."ingredients" ("id")
);

create table if not exists "service"."discountGroups" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "service"."discounts" (
	"id" serial primary key,
	"code" varchar(10) not null,
	"count" numeric(15,2) not null,
	"accumulativeBonuses" numeric(15,2) not null default 0,
	"description" text null,
	"groupId" int4 not null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	foreign key ("groupId") references "service"."discountGroups" ("id"),
	constraint "discounts_code_length" check(char_length("code") = 10),
	constraint "discounts_positive_count" check("count" > 0),
	constraint "discounts_positive_accumulativeBonuses" check("accumulativeBonuses" >= 0)
);

create table if not exists "service"."clientDiscounts" (
	"clientId" int4 not null,
	"discountId" int4 not null,
	primary key ("clientId", "discountId"),
	foreign key ("clientId") references "service"."clients" ("id"),
	foreign key ("discountId") references "service"."discounts" ("id")
);

create table if not exists "service"."orders" (
	"id" serial primary key,
	"clientId" int4 null,
	"employeeId" int4 not null,
	"tableId" int4 not null,
	"discountId" int4 null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	"totalPrice" numeric(15,2) null,
	"priceWithDiscount" numeric(15,2) null,
	"tips" numeric(15,2) default 0,
	"paymentType" "enum_orders_paymentType" not null,
	"status" "enum_orders_status" not null default 'opened',
	foreign key ("clientId") references "service"."clients" ("id"),
	foreign key ("employeeId") references "personal"."employees" ("id"),
	foreign key ("tableId") references "service"."tables" ("id"),
	foreign key ("discountId") references "service"."discounts" ("id"),
	constraint "service_orders_positive_totalPrice" check("totalPrice" > 0),
	constraint "service_orders_positive_tips" check("tips" >= 0)
);

create table if not exists "service"."orderFoods" (
	"orderId" int4 not null,
	"foodId" int4 not null,
	"count" smallint not null,
	"price" numeric(15,2) not null,
	primary key ("orderId", "foodId"),
	foreign key ("orderId") references "service"."orders" ("id"),
	foreign key ("foodId") references "service"."foods" ("id"),
	constraint "orderFoods_positive_count" check("count" > 0),
	constraint "orderFoods_positive_price" check("price" > 0)
);
