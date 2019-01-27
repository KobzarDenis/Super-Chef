-- Indexes for employeeRoles
create index "employeeRoles_name" on  "personal"."employeeRoles" ("name");


-- Indexes for employees
create unique index "employees_uniq_passport" on  "personal"."employees" ("id", "passportCode", "passportSeries");
create unique index "employees_uniq_ein" on  "personal"."employees" ("id", "ein");
create unique index "employees_uniq_accountId" on  "personal"."employees" ("id", "accountId");
create index "employees_firstName_lastName" on  "personal"."employees" ("firstName", "lastName");
create index "employees_passCode_passSeries" on  "personal"."employees" ("passportCode", "passportSeries");
create index "employees_ein" on  "personal"."employees" ("ein");
create index "employees_phoneNumber_email" on  "personal"."employees" ("phoneNumber", "email");