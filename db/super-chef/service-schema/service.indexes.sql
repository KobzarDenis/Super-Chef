-- Indexes for clients
create index "clients_phoneNumber_idx" on "service"."clients" ("phoneNumber");
create index "clients_firstName_lastName_idx" on  "service"."clients" ("firstName", "lastName");


-- Indexes for foods
create index "foods_price_idx" on  "service"."foods" ("price");


-- Indexes for discounts
create index "discounts_code_idx" on  "service"."discounts" ("code");

-- Indexes for orders
create index "orders_paymentType_idx" on  "service"."orders" ("paymentType");
create index "orders_dates_idx" on  "service"."orders" ("startDate", "endDate");
