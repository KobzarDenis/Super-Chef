
create table if not exists "clients" (
	"id" serial primary key,
	"firstName" varchar(50) not null,
	"lastName" varchar(50)  not null,
	"email" varchar(50),
	"phoneNumber" varchar(20)  not null
);


create table if not exists "tables" (
	"id" serial primary key,
	"seatCount" int4 not null
);

create table if not exists "foodGroups" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "foods" (
	"id" serial primary key,
	"name" varchar(50) not null,
	"description" text null,
	"price" float8 not null,
	"groupId" int4 not null,
	foreign key ("groupId") references "foodGroups" ("id")
);

create table if not exists "ingredients" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "foodIngredients" (
	"foodId" int4 not null,
	"ingredientId" int4 not null,
	"weight" float8 not null,
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
	"firstName" varchar(50) not null,
	"lastName" varchar(50) not null,
	"ein" varchar(20) not null,
	"passportCode" varchar(2) not null,
	"passportSeries" int2 not null,
	"sex" varchar(6) not null,
	"salary" float8 not null,
	"address" varchar(100) not null,
	"phoneNumber" varchar(20) not null,
	"email" varchar(50) not null,
	"roleId" int4 not null,
	"offerDate" timestamptz not null,
	"fireDate" timestamptz null,
	primary key ("id"),
	foreign key ("roleId") references "employeeRoles" ("id")
);

create table if not exists "discountGroups" (
	"id" serial primary key,
	"name" varchar(50) not null
);

create table if not exists "discounts" (
	"id" serial primary key,
	"count" float4 not null,
	"description" text null,
	"groupId" int4 not null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	foreign key ("groupId") references "discountGroups" ("id")
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
	"discountId" int4 not null,
	"startDate" timestamptz not null,
	"endDate" timestamptz null,
	"totalPrice" float8 null,
	"priceWithDiscount" float8 null,
	"tips" float8 default 0,
	foreign key ("employeeId") references "employees" ("id"),
	foreign key ("tableId") references "tables" ("id"),
	foreign key ("discountId") references "discounts" ("id")
);

create table if not exists "orderFoods" (
	"orderId" int4 not null,
	"foodId" int4 not null,
	"count" int4 not null,
	primary key ("orderId", "foodId"),
	foreign key ("orderId") references "orders" ("id"),
	foreign key ("foodId") references "foods" ("id")
);

create table if not exists "clientOrders" (
	"clientId" int4 not null,
	"orderId" int4 not null,
	primary key ("clientId", "orderId"),
	foreign key ("clientId") references "clients" ("id"),
	foreign key ("orderId") references "orders" ("id")
);

