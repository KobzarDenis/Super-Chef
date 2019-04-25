-- Full text search index

explain analyze select * from service.foods as f where service.food_make_tsvector(f.*) @@ plainto_tsquery('natus');

-- Transaction get

explain analyze select * from bookkeeping.incomes where "transactionId"='in-49bafc65-05c9-4658-bf9b-0695249629a9';


-- Order pay

 call service.order_pay(30448, 'UN-2720300', 63, '2016-11-2 16:26:56.691 +00:00');
