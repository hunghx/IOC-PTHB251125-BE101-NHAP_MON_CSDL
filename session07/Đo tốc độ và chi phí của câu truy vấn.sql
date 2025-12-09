explain analyze select * from sql_features where feature_name = 'fied SQL parameter';

create index on sql_features(feature_name);
-- drop index sql_features_feature_name_idx;

-- Seq Scan on sql_features  (cost=0.00..17.44 rows=1 width=77) (actual time=0.057..0.081 rows=1.00 loops=1)
--   Filter: ((feature_name)::text ~~ '%fied SQL parameter %'::text)
--   Rows Removed by Filter: 754
--   Buffers: shared hit=8
-- Planning Time: 0.104 ms
-- Execution Time: 0.097 ms


-- Seq Scan on sql_features  (cost=0.00..17.44 rows=1 width=77) (actual time=0.091..0.160 rows=1.00 loops=1)
--   Filter: ((feature_name)::text ~~ '%fied SQL parameter %'::text)
--   Rows Removed by Filter: 754
--   Buffers: shared hit=8
-- Planning:
--   Buffers: shared hit=5
-- Planning Time: 0.859 ms

