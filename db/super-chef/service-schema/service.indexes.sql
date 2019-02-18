-- Indexes for clients
create index "clients_phoneNumber" on "service"."clients" ("phoneNumber");
create index "clients_firstName_lastName" on  "service"."clients" ("firstName", "lastName");


-- Indexes for foods
create index "foods_price" on  "service"."foods" ("price");


-- Indexes for discounts
create index "discounts_code" on  "service"."discounts" ("code");

-- Indexes for orders
create index "orders_paymentType" on  "service"."orders" ("paymentType");
create index "orders_dates" on  "service"."orders" ("startDate", "endDate");
