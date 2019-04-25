-- Comments for productGroups types and constraints
comment on column  "stock"."productGroups"."name" is 'Type varchar(200) name can be shorter but can not be longer than 200 characters.';
comment on column  "stock"."productGroups"."description" is 'Type text because description will be able to have unlimited length.';


-- Comments for products types and constraints
comment on column  "stock"."products"."name" is 'Type varchar(200) name can be shorter but can not be longer than 200 characters.';
comment on column  "stock"."products"."rest" is 'Type numeric(5,2) because we need only 2 digits scale. Required';
comment on column  "stock"."products"."code" is 'Type varchar(200) code can be shorter but can not be longer than 50 characters. Uniq identifier between the same kind of products.';
comment on constraint  "products_code_length" on "stock"."products" is 'Code can not be shorter than 5 characters. Uniq for each products.';
comment on constraint  "products_positive_rest" on "stock"."products" is 'Rest can not be smallest than 0.';
comment on index  "stock"."products_name_idx" is 'This index created for optimized products search by name.';
comment on index  "stock"."products_code_idx" is 'This index created for optimized products search by code.';


-- Comments for caterers types and constraints
comment on column  "stock"."caterers"."name" is 'Type varchar(200) name can be shorter but can not be longer than 200 characters. Uniq for each caterers.';
comment on column  "stock"."caterers"."address" is 'Type varchar(300) address can be shorter but can not be longer than 300 characters.';
comment on column  "stock"."caterers"."code" is 'Type varchar(200) code can be shorter but can not be longer than 50 characters. Uniq identifier between the same kind of products.';
comment on column  "stock"."caterers"."site" is 'Type text because it is link on web-site and it will be long string.Not required.';
comment on column  "stock"."caterers"."email" is 'Type varchar(50) because it is variable type and doesnt matter if email will be shorter. Not required.';
comment on column  "stock"."caterers"."phoneNumber" is 'Type varchar(20) because phoneNumber can not be longer. Required.';
comment on column  "stock"."caterers"."createdAt" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "stock"."caterers"."updatedAt" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "stock"."caterers"."deletedAt" is 'Type timestamptz because we can have worldwide restaurant. Not required.';
comment on constraint  "caterers_code_length" on "stock"."caterers" is 'Code can not be shorter than 5 characters. Uniq for each caterers.';
comment on index  "stock"."caterers_code_idx" is 'This index created for optimized caterers search by code.';
comment on index  "stock"."caterers_phoneNumber_idx" is 'This index created for optimized caterers search by phone number.';
comment on index  "stock"."caterers_name_code_idx" is 'This index created for optimized caterers search both name and code.';


-- Comments for productApplying types and constraints
comment on column  "stock"."productApplying"."date" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "stock"."productApplying"."count" is 'Type numeric(5,2) because we need only 2 digits scale. Required';
comment on constraint  "productApplying_positive_count" on "stock"."productApplying" is 'Count can not be smallest than 0.';
comment on index  "stock"."productApplying_date_idx" is 'This index created for optimized applying search by date.';


-- Comments for orders types and constraints
comment on column  "stock"."orders"."invoiceNumber" is 'Type varchar(100) invoiceNumber can be shorter but can not be longer than 50 characters. Uniq for each caterers.';
comment on column  "stock"."orders"."count" is 'Type numeric(5,2) because we need only 2 digits scale. Required';
comment on column  "stock"."orders"."amount" is 'Type numeric(5,2) because we need only 2 digits scale. Required';
comment on column  "stock"."orders"."orderDate" is 'Type timestamptz because we can have worldwide restaurant. Required.';
comment on column  "stock"."orders"."supplyDate" is 'Type timestamptz because we can have worldwide restaurant. Set only after supply.';
comment on constraint  "stock_orders_count" on "stock"."orders" is 'Count can not be smallest than 0.1.';
comment on constraint  "stock_orders_amount" on "stock"."orders" is 'Amount can not be smallest than 0.1.';
comment on index  "stock"."orders_invoiceNumber_idx" is 'This index created for optimized product orders search by invoice number.';
comment on index  "stock"."orders_orderDate_idx" is 'This index created for optimized product orders search by order date.';
comment on index  "stock"."orders_supplyDate_idx" is 'This index created for optimized product orders search by supply date.';
comment on index  "stock"."orders_amount_idx" is 'This index created for optimized product orders search by order amount.';
