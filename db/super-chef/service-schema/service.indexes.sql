-- Indexes for clients
create index "clients_phoneNumber_idx" on "service"."clients" ("phoneNumber");
create index "clients_firstName_lastName_idx" on  "service"."clients" ("firstName", "lastName");


-- Indexes for foods
create index "foods_price_idx" on  "service"."foods" ("price");


-- Indexes for discounts
create index "discounts_code_idx" on  "service"."discounts" using hash ("code");

-- Indexes for orders
create index "orders_paymentType_idx" on  "service"."orders" ("paymentType");
create index "orders_dates_idx" on  "service"."orders" ("startDate", "endDate");



-- Full text food search index
CREATE OR REPLACE FUNCTION service.food_make_tsvector(food service."foods") RETURNS tsvector AS $$
BEGIN
    RETURN (to_tsvector(food."name") || to_tsvector(food."description"));
END;
$$ LANGUAGE 'plpgsql' IMMUTABLE;

CREATE INDEX "food-full-text-vector" ON service.foods USING gin (service.food_make_tsvector(foods.*))
