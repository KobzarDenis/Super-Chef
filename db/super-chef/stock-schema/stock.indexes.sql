-- Indexes for productApplying
create index "productApplying_date_idx" on "stock"."productApplying" using btree ("date");


-- Indexes for products
create index "products_name_idx" on "stock"."products" ("name");
create index "products_code_idx" on "stock"."products" using hash ("code");


-- Indexes for caterers
create index "caterers_code_idx" on "stock"."caterers" using hash ("code");
create index "caterers_phoneNumber_idx" on "stock"."caterers" using hash ("phoneNumber");
create index "caterers_name_code_idx" on "stock"."caterers" ("name","code");


-- Indexes for orders
create unique index "orders_invoiceNumber_catererId_idx" on "stock"."orders" ("invoiceNumber", "catererId");
CREATE INDEX "orders_invoiceNumber_idx" ON stock.orders USING hash ("invoiceNumber");
create index "orders_orderDate_idx" on "stock"."orders" using btree ("orderDate");
create index "orders_supplyDate_idx" on "stock"."orders" using btree ("supplyDate");
create index "orders_amount_idx" on "stock"."orders" using btree ("amount");
