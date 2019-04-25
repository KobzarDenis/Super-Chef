-- Comments for employeeRoles types and constraints
comment on column  "personal"."employeeRoles"."name" is 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';
comment on column  "personal"."employeeRoles"."description" is 'Type text because description will be able to have unlimited length.';
comment on index  "personal"."employeeRoles_name_idx" is 'This index created for optimized search employees by role name.';


-- Comments for employees types and constraints
comment on column  "personal"."employees"."firstName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column  "personal"."employees"."lastName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column  "personal"."employees"."email" is 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Null because it is not required.';
comment on column  "personal"."employees"."phoneNumber" is 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';
comment on column  "personal"."employees"."ein" is 'Type varchar(20) because ein can not be longer. Not null because it is required. Uniq because it is uniq for each employee.';
comment on column  "personal"."employees"."passportCode" is 'Type varchar(2) because passportCode can not be longer. Not null because it is required';
comment on column  "personal"."employees"."passportSeries" is 'Type varchar(10) because passportSeries wont be super long. Not null because it is required';
comment on column  "personal"."employees"."offerDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on column  "personal"."employees"."fireDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on constraint  "employees_passCode_length" on "personal"."employees" is 'Passport code can not be smallest than 2.';
comment on constraint  "employees_passSeries_length" on "personal"."employees" is 'Passport series can not be smallest than 5.';
comment on index  "personal"."employees_uniq_passport_idx" is 'This index created for uniq passCode + passSeries for each employee.';
comment on index  "personal"."employees_uniq_ein_idx" is 'This index created for uniq ein for each employee.';
comment on index  "personal"."employees_firstName_lastName_idx" is 'This index created for optimized employees search by first and last names.';
comment on index  "personal"."employees_passCode_passSeries_idx" is 'This index created for optimized employees search by passCode and passSeries.';
comment on index  "personal"."employees_ein_idx" is 'This index created for optimized search employees by ein.';
comment on index  "personal"."employees_phoneNumber_email_idx" is 'This index created for optimized search employees by phone number and email.';
