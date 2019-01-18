create table if not exists "clients" (
	"id" serial primary key,
	"firstName" varchar(100) not null,
	"lastName" varchar(100) not null,
	"email" varchar(50),
	"phoneNumber" varchar(20) not null
);

create table if not exists "tables" (
	"id" serial primary key,
	"seatCount" smallint,
	"status" enum_tables_status not null default 'free',
	constraint "tables_positive_seatCount"  check ("seatCount" > 1),
	constraint "tables_real_seatCount"  check ("seatCount" <= 20)
);

create table if not exists "foodGroups" (
	"id" serial primary key,
	"name" varchar(100) not null
);

create table if not exists "foods" (
	"id" serial primary key,
	"name" varchar(100) not null,
	"description" text null,
	"price" float4 not null,
	"groupId" int4 not null,
	constraint "foods_positive_price"  check ("price" > 0),
	foreign key ("groupId") references "foodGroups" ("id")
);

create table if not exists "ingredients" (
	"id" serial primary key,
	"name" varchar(100) not null
);

create table if not exists "foodIngredients" (
	"foodId" int4 not null,
	"ingredientId" int4 not null,
	"weight" float4 not null,
	constraint "foodIngredients_positive_weight"  check ("weight" > 0),
	primary key ("foodId", "ingredientId"),
	foreign key ("foodId") references "foods" ("id"),
	foreign key ("ingredientId") references "ingredients" ("id")
);

create table if not exists "employeeRoles" (
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" text null
);

create table if not exists "employees" (
	"id" serial,
	"firstName" varchar(100) not null,
	"lastName" varchar(100) not null,
	"ein" varchar(20) unique not null,
	"passportCode" varchar(5) not null,
	"passportSeries" varchar(10) not null,
	"sex" enum_employees_sex not null,
	"salary" float8 not null,
	"address" varchar(100) not null,
	"phoneNumber" varchar(20) not null,
	"email" varchar(50) not null,
	"roleId" int4 not null,
	"offerDate" timestamptz not null,
	"fireDate" timestamptz null,
	constraint "employees_passCode_length" check(char_length("passportCode") >= 2),
	constraint "employees_passSeries_length" check(char_length("passportSeries") >= 5),
	primary key ("id"),
	foreign key ("roleId") references "employeeRoles" ("id")
);

create table if not exists "discountGroups" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "discounts" (
	"id" serial primary key,
	"code" varchar(10) not null,
	"count" float4 not null,
	"accumulativeBonuses" float4 not null default 0,
	"description" text null,
	"groupId" int4 not null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	foreign key ("groupId") references "discountGroups" ("id"),
	constraint "discounts_code_length" check(char_length("code") = 10),
	constraint "discounts_positive_count" check("count" > 0),
	constraint "discounts_positive_accumulativeBonuses" check("accumulativeBonuses" >= 0)
);

create table if not exists "clientDiscounts" (
	"clientId" int4 not null,
	"discountId" int4 not null,
	primary key ("clientId", "discountId"),
	foreign key ("clientId") references "clients" ("id"),
	foreign key ("discountId") references "discounts" ("id")
);

create table if not exists "orders" (
	"id" serial primary key,
	"employeeId" int4 not null,
	"tableId" int4 not null,
	"discountId" int4 null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	"totalPrice" float4 null,
	"priceWithDiscount" float4 null,
	"tips" float4 default 0,
	"paymentType" "enum_orders_paymentType" not null,
	foreign key ("employeeId") references "employees" ("id"),
	foreign key ("tableId") references "tables" ("id"),
	foreign key ("discountId") references "discounts" ("id"),
	constraint "orders_positive_totalPrice" check("totalPrice" > 0),
	constraint "orders_positive_tips" check("tips" >= 0)
);

create table if not exists "orderFoods" (
	"orderId" int4 not null,
	"foodId" int4 not null,
	"count" smallint not null,
	"price" float4 not null,
	primary key ("orderId", "foodId"),
	foreign key ("orderId") references "orders" ("id"),
	foreign key ("foodId") references "foods" ("id"),
	constraint "orderFoods_positive_count" check("count" > 0),
	constraint "orderFoods_positive_price" check("price" > 0)
);

create table if not exists "clientOrders" (
	"clientId" int4 not null,
	"orderId" int4 not null,
	primary key ("clientId", "orderId"),
	foreign key ("clientId") references "clients" ("id"),
	foreign key ("orderId") references "orders" ("id")
);