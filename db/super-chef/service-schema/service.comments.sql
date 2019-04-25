-- Comments for clients types and constraints
comment on column  "service"."clients"."firstName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column  "service"."clients"."lastName" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter. Null because it is not required';
comment on column  "service"."clients"."email" is 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Null because it doesnt required.';
comment on column  "service"."clients"."phoneNumber" is 'Type varchar(20) because phoneNumber can not be longer. Not null because it is required.';
comment on index  "service"."clients_phoneNumber_idx" is 'This index created for optimized client search by phone number.';
comment on index  "service"."clients_firstName_lastName_idx" is 'This index created for optimized client search by first and last names.';


-- Comments for tables types and constraints
comment on column  "service"."tables"."seatCount" is 'Type smallint it is smallest integer type. Not null because it is required.';
comment on column  "service"."tables"."status" is 'Type enum_tables_status for check table status.';
comment on constraint  "tables_positive_seatCount" on "service"."tables" is 'Seat count can not be smallest than 2 places.';


-- Comments for foodGroups types and constraints
comment on column  "service"."foodGroups"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


-- Comments for foods types and constraints
comment on column  "service"."foods"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';
comment on column  "service"."foods"."description" is 'Type text because description will be able to have unlimited length.';
comment on column  "service"."foods"."price" is 'Type numeric(5,2) because we need only 2 digits scale.';
comment on constraint  "foods_positive_price" on "service"."foods" is 'Price can not be negative or 0.';
comment on index  "service"."foods_price_idx" is 'This index created for optimized food search by prices.';


-- Comments for ingredients types and constraints
comment on column  "service"."ingredients"."name" is 'Type varchar(100) name can be shorter but can not be longer than 100 characters.';


-- Comments for foodIngredients types and constraints
comment on column  "service"."foodIngredients"."weight" is 'Type numeric(5,4) because we need only 4 digits scale, not longer.';
comment on constraint  "foodIngredients_positive_weight" on "service"."foodIngredients" is 'Food ingredient weight can not be negative or 0.';


-- Comments for discountGroups types and constraints
comment on column  "service"."discountGroups"."name" is 'Type varchar(50) name can be shorter but can not be longer than 50 characters.';


-- Comments for discounts types and constraints
comment on column  "service"."discounts"."code" is 'Type varchar(100) because it is variable type and doesnt matter if name will be shorter.';
comment on column  "service"."discounts"."count" is 'Type numeric(5,2) because we need only 2 digits scale.';
comment on column  "service"."discounts"."accumulativeBonuses" is 'Type float4 because it wont be super long.';
comment on column  "service"."discounts"."description" is 'Type text because description will be able to have unlimited length.';
comment on column  "service"."discounts"."startDate" is 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert';
comment on column  "service"."discounts"."endDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required';
comment on constraint  "discounts_code_length" on "service"."discounts" is 'Code can not be shorter or longer than 10 characters.';
comment on constraint  "discounts_positive_count" on "service"."discounts" is 'Discount can not be smallest than 0.1.';
comment on constraint  "discounts_positive_accumulativeBonuses" on "service"."discounts" is 'Bonuses can not be smallest than 0.';
comment on index  "service"."discounts_code_idx" is 'This index created for optimized search discounts by code.';


-- Comments for orders types and constraints
comment on column  "service"."orders"."clientId" is 'Null because the client can be incognito. It means that we have no him in our DB.';
comment on column  "service"."orders"."totalPrice" is 'Type numeric(5,2) because we need only 2 digits scale.';
comment on column  "service"."orders"."priceWithDiscount" is 'Type numeric(5,2) because we need only 2 digits scale. Null because client will be able for pay without discount.';
comment on column  "service"."orders"."tips" is 'Type numeric(5,2) because we need only 2 digits scale. Null because can to let nothing.';
comment on column  "service"."orders"."paymentType" is 'Type enum_orders_paymentType because we have only 2 options.';
comment on column  "service"."orders"."startDate" is 'Type timestamptz because we can have worldwide restaurant. Null because we dont need this data during insert.';
comment on column  "service"."orders"."endDate" is 'Type timestamptz because we can have worldwide restaurant. Not null because it is required.';
comment on constraint  "service_orders_positive_totalPrice" on "service"."orders" is 'Total price can not be smallest than 0.1.';
comment on constraint  "service_orders_positive_tips" on "service"."orders" is 'Tips can not be smallest than 0.';
comment on index  "service"."orders_paymentType_idx" is 'This index created for optimized search orders by payment type.';
comment on index  "service"."orders_dates_idx" is 'This index created for optimized search orders by dates.';


-- Comments for orders types and constraints
comment on column  "service"."orderFoods"."count" is 'Type smallint because it wont be super long.';
comment on column  "service"."orderFoods"."price" is 'Type numeric(5,2) because we need only 2 digits scale.';
comment on constraint  "orderFoods_positive_count" on "service"."orderFoods" is 'Count can not be smallest than 0.';
comment on constraint  "orderFoods_positive_price" on "service"."orderFoods" is 'Price can not be smallest than 0.1.';
