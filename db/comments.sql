-- Comments for clients types and constraints
comment on column "clients"."firstName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column "clients"."lastName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column "clients"."email" is 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Null because it doesnt required.';
comment on column "clients"."phoneNumber" is 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';
comment on index "clients_phoneNumber" is 'This index created for optimized client search by phone number.';
comment on index "clients_firstName_lastName" is 'This index created for optimized client search by first and last names.';


-- Comments for tables types and constraints
comment on column "tables"."seatCount" is 'Type smallint it is smallest integer type. Not null because it is required.';
comment on column "tables"."status" is 'Type enum_tables_status for check table status.';
comment on constraint "tables_positive_seatCount" on "tables" is 'Seat count can not be smallest than 2 places.';
comment on constraint "tables_real_seatCount" on "tables" is 'Seat count can not be biggest than 20 places.';


-- Comments for foodGroups types and constraints
comment on column "foodGroups"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


-- Comments for foods types and constraints
comment on column "foods"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';
comment on column "foods"."description" is 'Type text because description will be able to have unlimited length.';
comment on column "foods"."price" is 'Type float4 because it wont be supper long.';
comment on constraint "foods_positive_price" on "foods" is 'Price can not be negative or 0.';
comment on index "foods_price" is 'This index created for optimized food search by prices.';


-- Comments for ingredients types and constraints
comment on column "ingredients"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


-- Comments for foodIngredients types and constraints
comment on column "foodIngredients"."weight" is 'Type float4 because it wont be supper long.';
comment on constraint "foodIngredients_positive_weight" on "foodIngredients" is 'Food ingredient weight can not be negative or 0.';


-- Comments for employeeRoles types and constraints
comment on column "employeeRoles"."name" is 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';
comment on column "employeeRoles"."description" is 'Type text because description will be able to have unlimited length.';
comment on index "employeeRoles_name" is 'This index created for optimized search employees by role name.';


-- Comments for employees types and constraints
comment on column "employees"."firstName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column "employees"."lastName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column "employees"."email" is 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Not null because it is required.';
comment on column "employees"."phoneNumber" is 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';
comment on column "employees"."ein" is 'Type varchar(20) because ein can not be longer. Not null because it is required. Uniq because it is uniq for each employee.';
comment on column "employees"."passportCode" is 'Type varchar(2) because passportCode can not be longer. Not null because it is required';
comment on column "employees"."passportSeries" is 'Type varchar(10) because passportSeries wont be super long. Not null because it is required';
comment on column "employees"."offerDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on column "employees"."fireDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on constraint "employees_passCode_length" on "employees" is 'Passport code can not be smallest than 2.';
comment on constraint "employees_passSeries_length" on "employees" is 'Passport series can not be smallest than 5.';
comment on index "employees_uniq_passport" is 'This index created for uniq passCode + passSeries for each employee.';
comment on index "employees_uniq_ein" is 'This index created for uniq ein for each employee.';
comment on index "employees_firstName_lastName" is 'This index created for optimized employees search by first and last names.';
comment on index "employees_passCode_passSeries" is 'This index created for optimized employees search by passCode and passSeries.';
comment on index "employees_ein" is 'This index created for optimized search employees by ein.';
comment on index "employees_phoneNumber_email" is 'This index created for optimized search employees by phone number and email.';


-- Comments for discountGroups types and constraints
comment on column "discountGroups"."name" is 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';


-- Comments for discounts types and constraints
comment on column "discounts"."code" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column "discounts"."count" is 'Type float4 because it wont be super long.';
comment on column "discounts"."accumulativeBonuses" is 'Type float4 because it wont be super long.';
comment on column "discounts"."description" is 'Type text because description will be able to have unlimited length.';
comment on column "discounts"."startDate" is 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert';
comment on column "discounts"."endDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on constraint "discounts_code_length" on "discounts" is 'Code can not be shorter or longer than 10 characters.';
comment on constraint "discounts_positive_count" on "discounts" is 'Discount can not be smallest than 0.1.';
comment on constraint "discounts_positive_accumulativeBonuses" on "discounts" is 'Bonuses can not be smallest than 0.';
comment on index "discounts_code" is 'This index created for optimized search discounts by code.';


-- Comments for orders types and constraints
comment on column "orders"."totalPrice" is 'Type float4 because it wont be super long.';
comment on column "orders"."priceWithDiscount" is 'Type float4 because it wont be super long. Null because client will be able for pay without discount.';
comment on column "orders"."tips" is 'Type float4 because it wont be super long. Null because can to let nothing.';
comment on column "orders"."paymentType" is 'Type enum_orders_paymentType because we have only 2 options.';
comment on column "orders"."startDate" is 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert.';
comment on column "orders"."endDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required.';
comment on constraint "orders_positive_totalPrice" on "orders" is 'Total price can not be smallest than 0.1.';
comment on constraint "orders_positive_tips" on "orders" is 'Tips can not be smallest than 0.';
comment on index "orders_paymentType" is 'This index created for optimized search orders by payment type.';
comment on index "orders_dates" is 'This index created for optimized search orders by dates.';


-- Comments for orders types and constraints
comment on column "orderFoods"."count" is 'Type smallint because it wont be super long.';
comment on column "orderFoods"."price" is 'Type float4 because it wont be super long.';
comment on constraint "orderFoods_positive_count" on "orderFoods" is 'Count can not be smallest than 0.';
comment on constraint "orderFoods_positive_price" on "orderFoods" is 'Price can not be smallest than 0.1.';