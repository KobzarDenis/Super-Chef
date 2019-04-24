-- Full text search index

explain analyze select * from service.foods as f where service.food_make_tsvector(f.*) @@ plainto_tsquery('natus');


