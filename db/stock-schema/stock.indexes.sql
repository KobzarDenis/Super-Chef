-- Indexes for productApplying
create index "productApplying_date" on "stock"."productApplying" ("date");


-- Indexes for products
create index "products_name" on "stock"."products" ("name");
create index "products_code" on "stock"."products" ("code");


-- Indexes for caterers
create index "caterers_code" on "stock"."caterers" ("code");
create index "caterers_phoneNumber" on "stock"."caterers" ("phoneNumber");
create index "caterers_name_code" on "stock"."caterers" ("name","code");


-- Indexes for orders
create unique index "orders_invoiceNumber_catererId" on "stock"."orders" ("invoiceNumber", "catererId");
create index "orders_invoiceNumber" on "stock"."orders" ("invoiceNumber");
create index "orders_orderDate" on "stock"."orders" ("orderDate");
create index "orders_supplyDate" on "stock"."orders" ("supplyDate");
create index "orders_amount" on "stock"."orders" ("amount");
