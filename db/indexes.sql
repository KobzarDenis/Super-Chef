-- Indexes for clients
create index "clients_phoneNumber" on "clients" ("phoneNumber");
create index "clients_firstName_lastName" on "clients" ("firstName", "lastName");


-- Indexes for foods
create index "foods_price" on "foods" ("price");


-- Indexes for employeeRoles
create index "employeeRoles_name" on "employeeRoles" ("name");


-- Indexes for employees
create unique index "employees_uniq_passport" on "employees" ("id", "passportCode", "passportSeries");
create unique index "employees_uniq_ein" on "employees" ("id", "ein");
create index "employees_firstName_lastName" on "employees" ("firstName", "lastName");
create index "employees_passCode_passSeries" on "employees" ("passportCode", "passportSeries");
create index "employees_ein" on "employees" ("ein");
create index "employees_phoneNumber_email" on "employees" ("phoneNumber", "email");


-- Indexes for discounts
create index "discounts_code" on "discounts" ("code");

-- Indexes for orders
create index "orders_paymentType" on "orders" ("paymentType");
create index "orders_dates" on "orders" ("startDate", "endDate");
