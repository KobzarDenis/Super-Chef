alter table stock.products add column "price" numeric(5,2) not null;
alter table stock.products add constraint "product_price" check("price">0);