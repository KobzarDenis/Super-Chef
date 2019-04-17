-- Indexes for employeeRoles
create index "employeeRoles_name_idx" on  "personal"."employeeRoles" ("name");


-- Indexes for employees
create unique index "employees_uniq_passport_idx" on  "personal"."employees" ("id", "passportCode", "passportSeries");
create unique index "employees_uniq_ein_idx" on  "personal"."employees" ("id", "ein");
create unique index "employees_uniq_accountId_idx" on  "personal"."employees" ("id", "accountId");
create index "employees_firstName_lastName_idx" on  "personal"."employees" ("firstName", "lastName");
create index "employees_passCode_passSeries_idx" on  "personal"."employees" USING HASH ("passportCode", "passportSeries");
create index "employees_ein_idx" on  "personal"."employees" USING HASH ("ein");
create index "employees_phoneNumber_email_idx" on  "personal"."employees" ("phoneNumber", "email");
