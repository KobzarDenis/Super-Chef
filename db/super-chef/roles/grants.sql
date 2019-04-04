CREATE ROLE chef SUPERUSER CREATEDB CREATEROLE NOINHERIT LOGIN PASSWORD 'test';

create role "accountant" with login password 'admin';
grant usage on schema "bookkeeping" to  "accountant";

grant select, update, insert, delete on table "bookkeeping"."accounts" to "accountant";
grant select, update, insert, delete on table "bookkeeping"."banks" to "accountant";
grant select, update, insert, delete on table "bookkeeping"."incomes" to "accountant";
grant select, update, insert, delete on table "bookkeeping"."outcomes" to "accountant";
grant select, update, insert, delete on table "bookkeeping"."transactionStatuses" to "accountant";
grant select, update, insert, delete on table "bookkeeping"."transactionTypes" to "accountant";

create role "manager" with login password 'admin';
grant usage on schema "service" to  "manager";
grant usage on schema "personal" to  "manager";

grant select, update, insert, delete on table "service"."clients" to "manager";
grant select, update, insert, delete on table "service"."tables" to "manager";
grant select, update, insert, delete on table "service"."foodGroups" to "manager";
grant select, update, insert, delete on table "service"."foods" to "manager";
grant select, update, insert, delete on table "service"."ingredients" to "manager";
grant select, update, insert, delete on table "service"."foodIngredients" to "manager";
grant select, update, insert, delete on table "service"."discountGroups" to "manager";
grant select, update, insert, delete on table "service"."discounts" to "manager";
grant select, update, insert, delete on table "service"."clientDiscounts" to "manager";
grant select, update, insert, delete on table "service"."orders" to "manager";
grant select, update, insert, delete on table "service"."orderFoods" to "manager";

grant select, update, insert, delete on table "personal"."employeeRoles" to "manager";
grant select, update, insert, delete on table "personal"."employees" to "manager";

grant select, update, insert, delete on table "stock"."productGroups" to "manager";
grant select, update, insert, delete on table "stock"."products" to "manager";
grant select, update, insert, delete on table "stock"."caterers" to "manager";
grant select, update, insert, delete on table "stock"."catererProducts" to "manager";
grant select, update, insert, delete on table "stock"."productApplying" to "manager";
grant select, update, insert, delete on table "stock"."productOrderStatus" to "manager";
grant select, update, insert, delete on table "stock"."productOrders" to "manager";